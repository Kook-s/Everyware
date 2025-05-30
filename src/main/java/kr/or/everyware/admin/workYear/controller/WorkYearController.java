package kr.or.everyware.admin.workYear.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.workYear.service.WorkYearService;
import kr.or.everyware.admin.workYear.vo.WorkYear;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware/admin")
public class WorkYearController {
	
	@Inject
	private WorkYearService workYearService;
	
	/**
	 * goWorkYear
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR_AD')")
	@GetMapping(value = "/workYear")
	public String goWorkYear() {
		log.info("goWorkYear()");
		return "admin/workYear/workYear";
	}
	
	/**
	 * 목록
	 * getWorkYear
	 * @param authentication
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/workYear/workYearList", produces = "application/json; charset=utf-8")
	public Map<String, Object> getWorkYear(
			Authentication authentication
			, Model model){
		log.info("getWorkYear()");
		
		// security User
		authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		log.info("employee : " + employee);
		
		HashMap<String, Object> workYearMap = new HashMap<String, Object>();
		
		List<WorkYear> workYear = workYearService.getWorkYear(employee.getCustId());
		log.info("workYear : " + workYear);
		
		workYearMap.put("workYear", workYear);
		
		
		return workYearMap;
	}
	
	/**
	 * 추가
	 * addWorkYear
	 * @param workYear
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/workYear/addWorkYear", produces = "application/json; charset=utf-8")
	public String addWorkYear(
			@RequestBody WorkYear workYear
			, Model model) {
		log.info("addWorkYear()");
		String resTxt = "";
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		workYear.setCustId(employee.getCustId());
		log.info("workYear : " + workYear);
		
		ServiceResult result = workYearService.addWorkYear(workYear);
		log.info("result : " + result);
		
		if(result.equals(ServiceResult.OK)) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
	
	/**
	 * 삭제
	 * delWorkYear
	 * @param wyNo
	 * @return
	 */
	@ResponseBody
	@DeleteMapping(value = "/workYear/delWorkYear/{wyNo}", produces = "application/json; charset=utf-8")
	public String delWorkYear(@PathVariable("wyNo") int wyNo) {
		log.info("delWorkYear()");
		log.info("wyNo :" + wyNo);
		String resTxt = "";
		
		int result = workYearService.delWorkYear(wyNo);
		log.info("result :" + result);
		
		if(result > 0) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
	
	/**
	 * 수정
	 * editWorkYear
	 * @param workYear
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PutMapping(value = "/workYear/editWorkYear", produces = "application/json; charset=utf-8")
	public String editWorkYear(
			@RequestBody WorkYear workYear
			, Model model) {
		log.info("editWorkYear()");
		log.info("workYear : " + workYear);
		String resTxt = "";
		
		ServiceResult result = workYearService.editWorkYear(workYear);
		log.info("result : " + result);
		
		if(result.equals(ServiceResult.OK)) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
	
	
}
