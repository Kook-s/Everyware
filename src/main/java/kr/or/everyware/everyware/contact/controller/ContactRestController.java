package kr.or.everyware.everyware.contact.controller;

import java.io.FileOutputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.Encoder;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.contact.service.IContactService;
import kr.or.everyware.everyware.contact.vo.AddressBook;
import kr.or.everyware.everyware.contact.vo.ContactInCompany;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Folder;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.toExcel.ExcelDownload;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/everyware")
@Slf4j
public class ContactRestController {
	
	@Autowired
	private IContactService contactService;
	@Autowired
	private Gson gson;
	@Autowired
	@Qualifier("empGsonBuilder")
	private GsonBuilder empGsonBuilder;
	@Autowired
	@Qualifier("folderGsonBuilder")
	private GsonBuilder folderGsonBuilder;
	
	/* 조직도 */
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@GetMapping(value = "/org", produces = "application/json;charset=utf-8")
	public String getOrganizationChart() {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String custId = employee.getCustId();
		
		List<Department> deptList = contactService.getEmpByDeptList(custId);
		String jsonData = empGsonBuilder.create().toJson(deptList);
		return jsonData;
	}
	
	/* 주소록 */
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@GetMapping(value = "/addressbook", produces = "application/json;charset=utf-8")
	public String getAddressBook() {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		
		List<Folder> folderList = contactService.getContactByFolderList(empId);
		String jsonData = folderGsonBuilder.create().toJson(folderList);
		return jsonData;
	}
	
	/* 부서 */
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@GetMapping(value = "/departments", produces = "application/json;charset=utf-8")
	public String getDeptList() {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String custId = employee.getCustId();
		
		List<Department> deptList = contactService.getDeptList(custId);
		String jsonData = gson.toJson(deptList);
		return jsonData;
	}
	
	
	/* 폴더 관리 */
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@GetMapping(value = "/contacts/folders", produces = "application/json;charset=utf-8")
	public String getFolderList() {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		
		List<Folder> folderList = contactService.getFolderList(empId);
		String jsonData = folderGsonBuilder.create().toJson(folderList);
		return jsonData;
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@PostMapping("/contacts/folders")
	public String addFolder(Folder folder) {
		// TODO add folder Type
		if(StringUtils.isAnyBlank(folder.getFolNm())) {
			return ServiceResult.FAILED.name();
		}
		ServiceResult result = contactService.addFolder(folder);
		return result.name();
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@PutMapping("/contacts/folders")
	public String editFolder(Folder folder) {
		ServiceResult result = contactService.editFolder(folder);
		return result.name();
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@DeleteMapping("/contacts/folders")
	public String deleteFolder(int folSn) {
		ServiceResult result = contactService.deleteFolder(folSn);
		return result.name();
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	private String generateEmpty(int depth) {
		String empty = "";
		for(int i=0; i<depth; i++){
			empty += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		return empty;
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	private void getFolderOption(List<Folder> folderList, StringBuilder builder) {
		for(Folder folder : folderList){
			int folSn = folder.getFolSn();
			String folNm = folder.getFolNm();
			int depth = folder.getDepth();
			String empty = generateEmpty(depth);
			
			builder.append("<option value='");
			builder.append(folSn);
			builder.append("'>");
			builder.append(empty);
			builder.append(folNm);
			builder.append("</option>");
			
			getFolderOption(folder.getFolders(), builder);
		}
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@GetMapping(value = "/contacts/new/folders", produces = "application/text; charset=utf8")
	public String getFolderSelectBox() {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		
		List<Folder> folderList = contactService.getFolderList(empId);
		
		if(folderList.size() == 0) {
			return "<option selected='selected' value='\\' disabled>폴더를 생성해주세요</option>";
		}
		
		for(Folder folder : folderList) {
			if(folder.getUpFolSn() == 0) {
				folder.calculateDepth();
			}
		}
		 	
		StringBuilder builder = new StringBuilder();
		builder.append("<option selected='selected' value='\\' disabled>선택</option>");
		
		getFolderOption(folderList, builder);
		
		return builder.toString();
	}
	
	
//	/* 사외주소록 관리 */
//	@GetMapping("/contacts/out")
//	public String getContactsOut() {
//		String empId = "test1";
//		log.info(empId);
//		List<AddressBook> addrList = contactService.getContactsOut(empId);
//		log.info(addrList.toString());
//		String jsonData = gson.toJson(addrList);
//		return jsonData;
//	}
//	
//	@PostMapping("/contacts/out")
//	public String addContactsOut(List<AddressBook> addrList) {
//		ServiceResult result = contactService.addContactsOut(addrList);
//		return result.name();
//	}
//	
//	@PutMapping("/contacts/out")
//	public String editContactsOut(List<AddressBook> addrList) {
//		ServiceResult result = contactService.editContactsOut(addrList);
//		return result.name();
//	}
//	
//	@DeleteMapping("/contacts/out")
//	public String deleteContactsOut(List<Integer> addrSnList) {
//		ServiceResult result = contactService.deleteContactsOut(addrSnList);
//		return result.name();
//	}
//	
//	@GetMapping("/contacts/out/excel")
//	public void getExcelContactsOut(HttpServletResponse response) throws Exception {
//		String empId = "test1";
//		List<AddressBook> addrList = contactService.getContactsOut(empId);
//		
//		ExcelDownload<AddressBook> excelDownload = new ExcelDownload<>(addrList, AddressBook.class);
//		excelDownload.write(response);
//	}
//	
//	
//	/* 사내주소록 관리 */
//	@GetMapping("/contacts/in")
//	public String getContactsIn() {
//		String empId = "test1";
//		log.info(empId);
//		List<ContactInCompany> addrList = contactService.getContactsIn(empId);
//		String jsonData = gson.toJson(addrList);
//		return jsonData;
//	}
//	
//	@PostMapping("/contacts/in")
//	public String addContactsIn(List<ContactInCompany> addrList) {
//		ServiceResult result = contactService.addContactsIn(addrList);
//		return result.name();
//	}
//	
//	@PutMapping("/contacts/in")
//	public String editContactsIn(List<ContactInCompany> addrList) {
//		ServiceResult result = contactService.editContactsIn(addrList);
//		return result.name();
//	}
//	
//	@DeleteMapping("/contacts/in")
//	public String deleteContactsIn(List<Integer> addrSnList) {
//		ServiceResult result = contactService.deleteContactsIn(addrSnList);
//		return result.name();
//	}
	
}
