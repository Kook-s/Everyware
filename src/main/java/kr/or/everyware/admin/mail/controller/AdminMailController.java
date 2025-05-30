package kr.or.everyware.admin.mail.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.admin.mail.service.AdminMailService;
import kr.or.everyware.admin.mail.vo.MailPaging;
import kr.or.everyware.admin.mail.vo.SearchInfo;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.everyware.mail.vo.BrowserPaging;
import kr.or.everyware.everyware.mail.vo.EmailDetail;
import kr.or.everyware.everyware.mail.vo.MailList;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;

@Controller
@RequestMapping("/everyware/admin")
public class AdminMailController {
	
	@Inject
	AdminMailService mailService;
	
	@PreAuthorize("hasAnyAuthority('MAIL_AD')")
    @RequestMapping(value = "/mail" , method = RequestMethod.GET)
	public String goMail(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		List<Department> deptList =  mailService.getDeptList(employee.getCustId());
		List<Position> posList = mailService.getPosList(employee.getCustId());
		
		model.addAttribute("deptList",deptList);
		model.addAttribute("posList",posList);
		
		return "admin/mail/mail";
	}
	
	
	
	@PreAuthorize("hasAuthority('MAIL_AD')")
	@PostMapping(value = "/mail/mailList" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public MailPaging<MailList> getMailList(@RequestBody SearchInfo searchInfo) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		System.out.println(searchInfo);
		
		MailPaging<MailList> mailPaging = new MailPaging<MailList>();
		
		//검색 기능 추가시 활용
		if(StringUtils.isNotBlank(searchInfo.getTitle())) {
			mailPaging.setTitle(searchInfo.getTitle());
		}
		if(StringUtils.isNotBlank(searchInfo.getName())) {
			mailPaging.setName(searchInfo.getName());
		}
		
		
		mailPaging.setIsLately(searchInfo.getIsLately());
		mailPaging.setCustId(employee.getCustId());
		mailPaging.setDeptId(searchInfo.getDeptId());
		mailPaging.setJbgdId(searchInfo.getJbgdId());
		String sdate=null;
		String edate=null;
		if(searchInfo.getSdate()!=null && !searchInfo.getSdate().equals("")) {
			sdate = searchInfo.getSdate().replaceAll("-", "/");
		}
		if(searchInfo.getEdate()!=null && !searchInfo.getEdate().equals("")) {
			edate = searchInfo.getEdate().replaceAll("-", "/");
		}
		mailPaging.setSdate(sdate);
		mailPaging.setEdate(edate);
		mailPaging.setCurrentPage(searchInfo.getPage());
		int totalRecord = mailService.selectMailCount(mailPaging);
		mailPaging.setTotalRecord(totalRecord); 
		List<MailList> dataList =mailService.selectMailList(mailPaging);
		mailPaging.setDataList(dataList);
		
		return mailPaging;
				
	}
	@PreAuthorize("hasAuthority('MAIL_AD')")
	@PostMapping(value = "/mail/detail" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public EmailDetail getMailDetail(@RequestBody Map<String, Object> map){

		String emlId = (String)map.get("emlId");
		
		EmailDetail emailDetail = mailService.getMailDetail(Integer.parseInt(emlId));
		
		return emailDetail;
	}
	
}
