package kr.or.everyware.everyware.contact.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.contact.service.IContactService;
import kr.or.everyware.everyware.contact.vo.AddressBook;
import kr.or.everyware.everyware.contact.vo.ContactInCompany;
import kr.or.everyware.everyware.contact.vo.Folder;
import kr.or.everyware.everyware.contact.vo.PaginationInfoVO;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/everyware")
@Slf4j
public class ContactController {
	
	@Autowired
	private IContactService contactService;

	/* 사내주소록 관리 */
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@GetMapping("/contacts/in")
	public String getContactsIn(Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();

		List<ContactInCompany> list = contactService.getContactsIn(empId);
		
		model.addAttribute("list", list);
		model.addAttribute("addressbookActive", "active");
		
		return "everyware/contacts/contactsIn";
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@PostMapping("/contacts/in")
	@ResponseBody
	public ResponseEntity<ServiceResult> addContactsIn(List<ContactInCompany> addrList) {
		ServiceResult result = contactService.addContactsIn(addrList);
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@PutMapping("/contacts/in")
	@ResponseBody
	public ResponseEntity<ServiceResult> editContactsIn(List<ContactInCompany> addrList) {
		ServiceResult result = contactService.editContactsIn(addrList);
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@DeleteMapping("/contacts/in")
	@ResponseBody
	public ResponseEntity<ServiceResult> deleteContactsIn(List<Integer> addrSnList) {
		ServiceResult result = contactService.deleteContactsIn(addrSnList);
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	
	/* 사외주소록 관리 */
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@GetMapping("/contacts/out")
	public String getContactsOut(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();

		List<AddressBook> list = contactService.getContactsOut(empId);
		
		model.addAttribute("list", list);
		
		return "everyware/contacts/contactsOut";
	}
	
	
//	@RequestMapping("/contacts/new")
//	public String testAddContacts(Model model) {
//		String empId = "test1";
//		List<Folder> folderList = contactService.getFolderList(empId);
//		
//		for(Folder folder : folderList) {
//			if(folder.getUpFolSn() == 0) {
//				folder.calculateDepth();
//			}
//		}
//		model.addAttribute("folderList", folderList);
//		return "everyware/contacts/contactsForm";
//	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@PostMapping(value = "/contacts/out", produces = "application/json; charset=utf8")
	@ResponseBody
	public ResponseEntity<ServiceResult> addContactsOut(@RequestBody List<AddressBook> addrList) {
		ServiceResult result = contactService.addContactsOut(addrList);
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@PutMapping(value = "/contacts/out", produces = "application/json; charset=utf8")
	@ResponseBody
	public ResponseEntity<ServiceResult> editContactsOut(@RequestBody List<AddressBook> addrList) {
		ServiceResult result = contactService.editContactsOut(addrList);
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@DeleteMapping("/contacts/out")
	@ResponseBody
	public ResponseEntity<ServiceResult> deleteContactsOut(@RequestBody List<Integer> addrSnList) {
		ServiceResult result = contactService.deleteContactsOut(addrSnList);
		return new ResponseEntity<ServiceResult>(result, HttpStatus.OK);
	}
	
}
