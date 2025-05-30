package kr.or.everyware.everyware.document.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.document.service.IApprovalService;
import kr.or.everyware.everyware.document.vo.ApprovalLine;
import kr.or.everyware.everyware.document.vo.Proxy;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/everyware/approval")
@Slf4j
public class ApprovalController {
//	
//	@Autowired
//	private IApprovalService approvalService;
//	@Autowired
//	private Gson gson;
//	
//	@PreAuthorize("hasAuthority('APPROVAL')")
//	@PostMapping(value = "/proxy", produces = "application/json; charset=utf8")
//	@ResponseBody
//	public String addProxy(@RequestBody List<Proxy> proxyList) {
//		
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
//		Employee employee = customUser.getEmployee();
//
//		String empId = employee.getEmpId();
//		
//		for(Proxy proxy : proxyList) {
//			proxy.setEmpId(empId);
//		}
//		
//		ServiceResult result = approvalService.addProxy(proxyList);
//		
//		String jsonData = gson.toJson(proxyList);
//		
//		return jsonData;
//	}
//	
//	@PreAuthorize("hasAuthority('APPROVAL')")
//	@GetMapping(value = "/proxy", produces = "application/json; charset=utf8")
//	@ResponseBody
//	public String getProxyList() {
//		
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
//		Employee employee = customUser.getEmployee();
//		
//		String empId = employee.getEmpId();
//		
//		List<Proxy> list = approvalService.getProxyList(empId);
//		String jsonData = gson.toJson(list);
//		
//		return jsonData;
//	}
//	
//	@PreAuthorize("hasAuthority('APPROVAL')")
//	@PatchMapping(value = "/proxy")
//	@ResponseBody
//	public String deleteProxy(@RequestBody int proxyId) {
//		ServiceResult result = approvalService.deleteProxy(proxyId);
//		return "";
//	}
//	
//	
//	@PreAuthorize("hasAuthority('APPROVAL')")
//	@PostMapping(value = "/approval-process")
//	@ResponseBody
//	public String approvalProcess(@RequestBody ApprovalLine aprvLine) {
//		log.info("결재합니다~");
//		// TODO 결재자 검증 로직 추가
//		log.info(aprvLine.toString());
//		
//		ServiceResult result = approvalService.confirmProcess(aprvLine);
//		
//		return aprvLine.getAprvSn() + "";
//	}
//	
//	@PreAuthorize("hasAuthority('APPROVAL')")
//	@GetMapping("/sign")
//	public String goImage() {
//		return "everyware/document/signImageModal";
//	}
}
