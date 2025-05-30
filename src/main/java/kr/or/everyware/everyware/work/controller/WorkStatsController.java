package kr.or.everyware.everyware.work.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.service.WorkStatsService;
import kr.or.everyware.everyware.work.vo.Work;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware")
public class WorkStatsController {

	@Inject
	private WorkStatsService workStatsService;
	
	/**
	 * goWorkStats
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@GetMapping(value = "/workStats")
	public String goWorkStats() {
		log.info("goWorkStats()");
		return "everyware/work/workStats";
	}
	
	/**
	 * 근로제 그룹
	 * getWorkGroup 
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/workStats/getWorkGroup", produces = "application/json; charset=utf-8")
	public WorkGroup getWorkGroup(Model model){
		log.info("getWorkGroup()");
		Employee employee = new Employee();
		
		// security User
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		log.info("empId : " + empId);
		employee.setEmpId(empId);
		
		WorkGroup workGroupList = workStatsService.getWorkGroup(empId);
		log.info("workGroupList : " + workGroupList);
		
		if(workGroupList == null) {
			workGroupList = new WorkGroup();
			workGroupList.setGroupNm("소속된 근로 그룹이 없습니다.");
			workGroupList.setGroupWorkBgngDt("00:00:00");
			workGroupList.setGroupWorkEndDt("00:00:00");
			workGroupList.setGroupRestBgngDt("00:00:00");
			workGroupList.setGroupRestEndDt("00:00:00");
		}
		
		return workGroupList;
	}
	
	/**
	 * 오늘의 출퇴근
	 * getWorkToday
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/workStats/getWorkToday", produces = "application/json; charset=utf-8")
	public Work getWorkToday(Model model) {
		log.info("getWorkToday()");
		
		// security User
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		log.info("empId : " + empId);
		
		Work workToday = workStatsService.getWorkToday(empId);
		
		if(workToday == null) {
			workToday = new Work();
			workToday.setWorkBgngDt("00:00:00");
			workToday.setWorkEndDt("00:00:00");
			
		} else {
			if(workToday.getWorkEndDt() == null) {
				workToday.setWorkEndDt("00:00:00");
			}
			
		}
//		
		log.info("workToday : " + workToday);
		return workToday;
	}
}
