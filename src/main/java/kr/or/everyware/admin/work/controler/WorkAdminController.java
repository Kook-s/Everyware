package kr.or.everyware.admin.work.controler;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.admin.work.service.WorkAdminService;
import kr.or.everyware.admin.work.vo.WorkAdmin;
import kr.or.everyware.admin.work.vo.WorkAdminPaging;
import kr.or.everyware.everyware.work.vo.Work;
import kr.or.everyware.login.vo.Client;
import kr.or.everyware.login.vo.CustomUserClient;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/everyware/admin")
public class WorkAdminController {
	
	@Inject
	private WorkAdminService workAdminService;
	
	/**
	 * goWrokAdmin
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR_AD')")
	@GetMapping(value = "/work")
	public String goWrokAdmin(Model model) {
		log.info("goWrokAdmin");
		return "admin/work/workAdmin";
	}
	/**
	 * 목록
	 * @param workAdmin
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR_AD')")
	@ResponseBody
	@PostMapping(value = "/work/getWorkAdminList", produces = "application/json; charset=utf-8")
	public Map<String, Object> getAdminWorkList(
			@RequestBody WorkAdmin workAdmin
			, Model model
			){
		log.info("getAdminWorkList()");
		log.info("workAdmin : " + workAdmin);
		
		Map<String, Object> workAdminMap = new HashMap<String, Object>();
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		log.info("employee : " + employee);
		
		workAdmin.setEmpId(employee.getEmpId());
		workAdmin.setCustId(employee.getCustId());
		workAdmin.setCurrentPage(workAdmin.getPage());
		log.info("workAdmin : " + workAdmin);
		
		// 
		int totalRecord = workAdminService.getTotalRecord(workAdmin);	// 전체 
		workAdmin.setTotalRecord(totalRecord);
		
		// 근태현황
		int totalWork = workAdminService.getTotalWork(workAdmin);				// 전체건
		workAdminMap.put("totalWork", totalWork);
		int totalNormal = workAdminService.getTotalNormal(workAdmin);			// 정상건
		workAdminMap.put("totalNormal", totalNormal);
		int totalExtension = workAdminService.getWorkExtensionCount(workAdmin);	// 연장건
		workAdminMap.put("totalExtension", totalExtension);
		int totalLateness = workAdminService.getWorkLatenessCount(workAdmin);	// 지각건
		workAdminMap.put("totalLateness", totalLateness);
		int totalLeaveEarly = workAdminService.getWorkLeaveEarlyCount(workAdmin);// 조퇴건
		workAdminMap.put("totalLeaveEarly", totalLeaveEarly);
		int totalVacation = workAdminService.getWorkVacationCount(workAdmin);	// 휴가건
		workAdminMap.put("totalVacation", totalVacation);
		
		// 목록
		List<WorkAdmin> dataList = workAdminService.getAdminWorkList(workAdmin);
		workAdmin.setDataList(dataList);
		workAdminMap.put("dataList", dataList);
		workAdminMap.put("workAdmin", workAdmin);
		
		log.info("dataList : " + dataList);
		log.info("workAdminMap : " + workAdminMap);
		
//		model.addAttribute("workActive", "active");
		return workAdminMap;
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
