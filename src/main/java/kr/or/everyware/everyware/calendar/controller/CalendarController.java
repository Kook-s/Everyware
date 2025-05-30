package kr.or.everyware.everyware.calendar.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.calendar.service.CalendarService;
import kr.or.everyware.everyware.calendar.vo.Schedule;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;

@Controller
@RequestMapping(value = "/everyware")
public class CalendarController {
	
	@Inject
	CalendarService calendarService;
	
	@PreAuthorize("hasAnyAuthority('CALENDAR')")
	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public String calendarMain(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		List<Schedule> eventList = calendarService.getEventList(employee);
		List<Schedule> list = calendarService.getDeactiveEventList(employee.getEmpId());
		Gson gson = new Gson();
		String json = gson.toJson(eventList);
		model.addAttribute("eventList",json);
		model.addAttribute("undoEventList",list);
		model.addAttribute("employee",employee);
		model.addAttribute("calendarActive","active");
		return "everyware/calendar/calendar";
	}
	@PreAuthorize("hasAnyAuthority('CALENDAR')")
	@RequestMapping(value = "/calendar/register", method = RequestMethod.POST)
	public ResponseEntity<Integer> addSchedule(Schedule schedule, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		schedule.setEmpId(employee.getEmpId());
		schedule.setDeptId(employee.getDeptId());
		System.out.println("dept_id는 다음:"+schedule);
		int res = calendarService.insertSchedule(schedule);
		return new ResponseEntity<Integer>(res,HttpStatus.OK);
	}
	@PreAuthorize("hasAnyAuthority('CALENDAR')")
	@RequestMapping(value = "/calendar/delete", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteSchedule(Integer schdlId,Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		ResponseEntity<Integer> result = null;
		ServiceResult res = null;
		res = calendarService.deleteSchedule(schdlId);
		List<Schedule> eventList = calendarService.getEventList(employee);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", res);
		map.put("eventList", eventList);
		return new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);
	}
	
	@PreAuthorize("hasAnyAuthority('CALENDAR')")
	@RequestMapping(value = "/calendar/modify", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> editSchedule(Schedule schedule,Model model) {
		ResponseEntity<Integer> result = null;
		ServiceResult res = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		schedule.setEmpId(employee.getEmpId());
		System.out.println("이건 schedule:"+schedule);
		System.out.println("이건 리스트"+schedule.getMemberList());
		System.out.println("이건 리스트id"+schedule.getMemberIdList());
		res = calendarService.modifySchedule(schedule);
		List<Schedule> eventList = calendarService.getEventList(employee);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", res);
		map.put("eventList", eventList);
		System.out.println(eventList);
		return new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);
	}
	
	@PreAuthorize("hasAnyAuthority('CALENDAR')")
	@RequestMapping(value = "/calendar/empName", method = RequestMethod.POST, produces = "html/text;charset=utf-8")
	public ResponseEntity<String> getEmpName(@RequestParam String empId) {

		String res = calendarService.getEmpNameById(empId);
		
		return new ResponseEntity<String>(res,HttpStatus.OK);
	}
	
	@PreAuthorize("hasAuthority('MAIL')")
	@RequestMapping("/calendar/deptProfileList")
	public ResponseEntity<List<Employee>> getDeptProfileList() {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		List<Employee> profileList = calendarService.getDeptProfileList(employee);
		
		return new ResponseEntity<List<Employee>>(profileList,HttpStatus.OK);
				
	}
	@PreAuthorize("hasAuthority('MAIL')")
	@RequestMapping("/calendar/allProfileList")
	public ResponseEntity<List<Employee>> getAllProfileList() {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		List<Employee> profileList = calendarService.getAllProfileList(employee);
		
		return new ResponseEntity<List<Employee>>(profileList,HttpStatus.OK);
				
	}
}
