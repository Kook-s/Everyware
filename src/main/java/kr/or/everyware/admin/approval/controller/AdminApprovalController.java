package kr.or.everyware.admin.approval.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.approval.service.IAdminApprovalService;
import kr.or.everyware.admin.approval.vo.ApprovalConfig;
import kr.or.everyware.everyware.document.controller.DocumentController;
import kr.or.everyware.everyware.document.vo.Document;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/everyware/admin")
@Slf4j
public class AdminApprovalController {
	
	@Autowired
	private IAdminApprovalService approvalService;
	@Autowired
	private Gson gson;
	@Autowired
	private DocumentController controller;
	
	@PreAuthorize("hasAnyAuthority('APPROVAL_AD')")
	@GetMapping("/approval/config")
	public String getOption(Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String custId = employee.getCustId();
		
		ApprovalConfig config = approvalService.getConfig(custId);
		model.addAttribute("config", config);
		
		return "admin/approval/config";
	}
	
	@PreAuthorize("hasAnyAuthority('APPROVAL_AD')")
	@PostMapping(value = "/approval/config")
	public String editConfig(ApprovalConfig config, Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String custId = employee.getCustId();
		config.setCustId(custId);
		
		ServiceResult result = approvalService.editConfig(config);
		
		config = approvalService.getConfig(custId);
		model.addAttribute("config", config);
		
		return "admin/approval/config";
	}
	
	@PreAuthorize("hasAnyAuthority('APPROVAL_AD')")
	@GetMapping("/approval/list")
	public String godocumentList() {
		return "admin/approval/list";
	}
	
	@PreAuthorize("hasAnyAuthority('APPROVAL_AD')")
	@PostMapping(value = "/approval/documents")
	@ResponseBody
	public String goList(@RequestBody Document doc) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String custId = employee.getCustId();
		doc.setCustId(custId);
		
		List<Document> docList = approvalService.getAllDocumentList(doc);
		String tbody = controller.generateTbody(docList);
		
		return tbody;
	}
	
}
