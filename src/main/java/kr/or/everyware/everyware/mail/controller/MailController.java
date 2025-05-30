package kr.or.everyware.everyware.mail.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.xmlbeans.impl.jam.provider.ResourcePath;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.mail.service.MailService;
import kr.or.everyware.everyware.mail.vo.BrowserPaging;
import kr.or.everyware.everyware.mail.vo.Email;
import kr.or.everyware.everyware.mail.vo.EmailDetail;
import kr.or.everyware.everyware.mail.vo.MailList;
import kr.or.everyware.everyware.mail.vo.MailPaging;
import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;
import kr.or.everyware.util.fileUtils.MediaUtils;

@Controller
@RequestMapping("/everyware")
public class MailController {

	@Resource(name = "uploadPath")
	private String resourcePath;
	
	@Inject
	MailService mailService;
	
	@PreAuthorize("hasAuthority('MAIL')")
	@RequestMapping("/mail")
	public String goMain(Model model) {
		model.addAttribute("mailActive","active");
		return "everyware/mail/mail";
	}
	
	@PreAuthorize("hasAuthority('MAIL')")
	@RequestMapping("/mail/profileList")
	public ResponseEntity<List<Employee>> getProfileList() {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		List<Employee> profileList = mailService.getProfileList(employee);
		
		return new ResponseEntity<List<Employee>>(profileList,HttpStatus.OK);
				
	}
	@PreAuthorize("hasAuthority('MAIL')")
	@RequestMapping("/mail/send")
	public ResponseEntity<ServiceResult> addMail(Email mail) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		mail.setSender(employee);
		System.out.println("파일"+mail.getCFiles());
		System.out.println("제목"+mail.getEmlTtl());
		System.out.println("내용"+mail.getEmlCn());
		System.out.println("상위"+mail.getUpEmlId());
		System.out.println("임시여부"+mail.getEmlTmprStrgYn());
		System.out.println("받는이"+mail.getCReceiver());
		System.out.println("파일타입"+mail.getFileType());
		System.out.println("fileInfoList"+mail.getFileInfoList());
		ServiceResult res = mailService.sendMail(mail);
		
		if(res.equals(ServiceResult.NOTEXIST)) {
			return new ResponseEntity<ServiceResult>(ServiceResult.NOTEXIST,HttpStatus.OK);
		}else {
			return new ResponseEntity<ServiceResult>(ServiceResult.OK,HttpStatus.OK);
		}

				
	}
	
	@PreAuthorize("hasAuthority('MAIL')")
	@PostMapping(value = "/mail/mailList" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public MailPaging<MailList> getMailList(@RequestBody BrowserPaging browserPaging) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		
		System.out.println("브라우저"+browserPaging);
		MailPaging<MailList> mailPaging = new MailPaging<MailList>();
		mailPaging.setIsLately(browserPaging.getIsLately());
		mailPaging.setAttachment(browserPaging.isAttachment());
		mailPaging.setBookMark(browserPaging.isBookMark());
		//검색 기능 추가시 활용
		if(StringUtils.isNotBlank(browserPaging.getSearchKeyword())) {
			mailPaging.setSearchWord(browserPaging.getSearchKeyword());
		}
		mailPaging.setMenuName(browserPaging.getMenuName());
		mailPaging.setEmpId(employee.getEmpId());
		mailPaging.setCurrentPage(browserPaging.getPage()); 	//startRow, endRow, startPage, endPage가 결정
		int totalRecord = mailService.selectMailCount(mailPaging);
		mailPaging.setTotalRecord(totalRecord); 
		List<MailList> dataList =mailService.selectMailList(mailPaging);
		mailPaging.setDataList(dataList);
		int mailUnreadCount = mailService.selectUnreadMailCount(employee.getEmpId());
		mailPaging.setMailUnreadCount(mailUnreadCount);
		mailService.getMailTotal(mailPaging);
		
		return mailPaging;
				
	}
	
	
	@PreAuthorize("hasAuthority('MAIL')")
	@PostMapping(value = "/mail/bookMark" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> editBookMark(@RequestBody Map<String, Object> map){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		map.put("empId", employee.getEmpId());
		int res = mailService.modifyMailBookMark(map);
		map.put("res", res);
		return map;
	}
	
	@PreAuthorize("hasAuthority('MAIL')")
	@PostMapping(value = "/mail/detail" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public EmailDetail getMailDetail(@RequestBody Map<String, Object> map){

		String emlId = (String)map.get("emlId");
		
		EmailDetail emailDetail = mailService.getMailDetail(Integer.parseInt(emlId));
		
		return emailDetail;
	}
	

	
	@PreAuthorize("hasAuthority('MAIL')")
	@GetMapping(value = "/mail/thumbnail")
	public ResponseEntity<byte[]> getThumbnail(AttachFile attachFile){
		InputStream is=null;
		ResponseEntity<byte[]> entity = null;
		try {
			AttachFile fileInfo = mailService.getAttachFile(attachFile);
			String savedFileName=fileInfo.getFileSavedNm();
			String front = savedFileName.substring(0,12); 	// /2023/06/07 폴더
			String end = savedFileName.substring(12);		// 뒤 파일 명
			String fileName= front+"s_"+end;
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMeMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			is = new FileInputStream(fileInfo.getFilePath()+fileName);
			if(mType!=null) {
				headers.setContentType(mType);
			}else {
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; fileName=\""+new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is),headers,HttpStatus.CREATED);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				is.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return entity;
	}
	@PreAuthorize("hasAuthority('MAIL')")
	@GetMapping(value = "/mail/filedownload")
	public ResponseEntity<byte[]> getFile(AttachFile attachFile){
		System.out.println(attachFile);
		InputStream is=null;
		ResponseEntity<byte[]> entity = null;
		try {
			AttachFile fileInfo = mailService.getAttachFile(attachFile);
			String fileName = fileInfo.getFileSavedNm();
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMeMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			is = new FileInputStream(fileInfo.getFilePath()+fileName);
			fileName = fileName.substring(fileName.indexOf("_")+1);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment; fileName=\""+new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is),headers,HttpStatus.CREATED);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				is.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return entity;
	}
	
	@PreAuthorize("hasAuthority('MAIL')")
	@PostMapping(value = "/mail/readmail" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> editMailReceive(@RequestBody Map<String, Object> map){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		map.put("empId", employee.getEmpId());
		ServiceResult res = mailService.readMail(map);
		int unreadCnt = mailService.selectUnreadMailCount(employee.getEmpId());
		map.put("unreadCnt", unreadCnt);
		map.put("res", res);
		return map;
	}
	@PreAuthorize("hasAuthority('MAIL')")
	@PostMapping(value = "/mail/mailinfo" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public Email getMailInfo(@RequestBody Map<String, Object> map){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		Email email = mailService.getMail(map);
		
		return email;
	}
	
	@PreAuthorize("hasAuthority('MAIL')")
	@PostMapping(value = "/mail/trash" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> editToTrash(@RequestBody Map<String, Object> map){
		ServiceResult res = mailService.mailToTrash(map);
		map.put("res", res);
		return map;
	}
	
	@PreAuthorize("hasAuthority('MAIL')")
	@PostMapping(value = "/mail/retrieve" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> editToRetrieve(@RequestBody Map<String, Object> map){
		ServiceResult res = mailService.mailToRetrieve(map);
		map.put("res", res);
		return map;
	}
	
	@PreAuthorize("hasAuthority('MAIL')")
	@PostMapping(value = "/mail/erase" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> editToErase(@RequestBody Map<String, Object> map){
		ServiceResult res = mailService.mailToErase(map);
		map.put("res", res);
		return map;
	}
	
	@PreAuthorize("hasAuthority('MAIL')")
	@RequestMapping("/mail/temp")
	public ResponseEntity<ServiceResult> addTempMail(Email mail) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		mail.setSender(employee);
		System.out.println("파일"+mail.getCFiles());
		System.out.println("제목"+mail.getEmlTtl());
		System.out.println("내용"+mail.getEmlCn());
		System.out.println("상위"+mail.getUpEmlId());
		System.out.println("임시여부"+mail.getEmlTmprStrgYn());
		System.out.println("받는이"+mail.getCReceiver());
		
		ServiceResult res = mailService.tempMail(mail);
		
		if(res.equals(ServiceResult.NOTEXIST)) {
			return new ResponseEntity<ServiceResult>(ServiceResult.NOTEXIST,HttpStatus.OK);
		}else {
			return new ResponseEntity<ServiceResult>(ServiceResult.OK,HttpStatus.OK);
		}
	}
	
	
	
	
	
	
}
