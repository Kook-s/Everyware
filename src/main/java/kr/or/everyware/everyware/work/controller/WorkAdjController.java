package kr.or.everyware.everyware.work.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.everyware.work.service.WorkAdjService;
import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.WorkAdj;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware")
public class WorkAdjController {

	@Inject
	private WorkAdjService workAdjService;
	
	/**
	 * goWorkAdj
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@GetMapping(value = "/workAdj")
	public String goWorkAdj() {
		log.info("goWorkAdj()");
		return "everyware/work/workAdj";
	}
	
	/**
	 * 목록
	 * @param currentPage
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@ResponseBody
	@PostMapping(value = "/workAdj/getWorkAdjList", produces = "application/json; charset=utf-8")
	public Map<String, Object> getWorkAdjList(
			@RequestBody WorkAdj workAdj
			, Model model
			) {
		log.info("getWorkAdjList()");
		log.info("WorkAdj(페이징) : " + workAdj);
		
		Map<String, Object> workAdjMap = new HashMap<String, Object>();
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		workAdj.setEmpId(employee.getEmpId());
		workAdj.setCustId(employee.getCustId());
		workAdj.setCurrentPage(workAdj.getPage());
		
		//
		int totalRecode = workAdjService.getTotalRecord(workAdj);	// 전체
		workAdj.setTotalRecord(totalRecode);
		
		// 근태조정현황
		List<WorkAdj> dataList = workAdjService.getWorkAdjList(workAdj);
		workAdj.setDataList(dataList);
		workAdjMap.put("dataList", dataList);
		workAdjMap.put("workAdj", workAdj);
		
		log.info("dataList : " + dataList);
		log.info("workAdjMap : " + workAdjMap);
		
//		model.addAttribute("suvyActive", "active");
		return workAdjMap;
	}
	
	
	
}
