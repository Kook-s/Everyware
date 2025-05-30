package kr.or.everyware.admin.calendar.controller;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.calendar.service.AdminCalendarService;
import kr.or.everyware.everyware.calendar.vo.Schedule;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.login.vo.Client;
import kr.or.everyware.login.vo.CustomUserClient;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;

@Controller
@RequestMapping("/everyware/admin")
public class AdminCalendarController {
	
	@Inject
	AdminCalendarService calendarService;
	
	@PreAuthorize("hasAnyAuthority('CALENDAR_AD')")
    @RequestMapping(value = "/calendar" , method = RequestMethod.GET)
	public String goCalendar(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		Employee emp = new Employee();
		emp.setCustId(employee.getCustId());
		emp.setDeptId(0);
		List<Schedule> eventList = calendarService.getAdminEventList(emp);
		List<Department> departmentList = calendarService.getDepartmentList(employee.getCustId());
		Gson gson = new Gson();
		String json = gson.toJson(eventList);
		model.addAttribute("eventList",json);
		model.addAttribute("departmentList",departmentList);
		return "admin/calendar/calendar";
	}
	
	@PreAuthorize("hasAuthority('CALENDAR_AD')")
	@RequestMapping("/calendar/deptProfileList")
	public ResponseEntity<List<Employee>> getDeptProfileList(@RequestParam int deptId) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		System.out.println("deptId: "+deptId);
		Employee emp = new Employee();
		emp.setCustId(employee.getCustId());
		emp.setDeptId(deptId);
		List<Employee> profileList = calendarService.getDeptProfileList(emp);
		
		return new ResponseEntity<List<Employee>>(profileList,HttpStatus.OK);
				
	}
	@PreAuthorize("hasAuthority('CALENDAR_AD')")
	@RequestMapping("/calendar/allProfileList")
	public ResponseEntity<List<Employee>> getAllProfileList() {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		List<Employee> profileList = calendarService.getAllProfileList(employee);
		
		return new ResponseEntity<List<Employee>>(profileList,HttpStatus.OK);
				
	}
	@PreAuthorize("hasAuthority('CALENDAR_AD')")
	@PostMapping(value = "/calendar/deptEvent",produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> addEvent(@RequestBody Map<String, Object> map) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		System.out.println(map);
		int deptId = Integer.parseInt(map.get("deptId").toString());
		Employee emp = new Employee();
		emp.setCustId(employee.getCustId());
		emp.setDeptId(deptId);
		List<Schedule> eventList = calendarService.getAdminEventList(emp);
		map.put("eventList", eventList);
		
		return map;
				
	}
	
	
	
	
	
	@PreAuthorize("hasAuthority('CALENDAR_AD')")
	@PostMapping(value = "/calendar/update",produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> editEvent(@RequestBody Schedule schedule) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		System.out.println(schedule);
		
		ServiceResult res = calendarService.updateEvent(schedule);
		Employee emp = new Employee();
		emp.setCustId(employee.getCustId());
		emp.setDeptId(schedule.getCurCalendarDeptId());
		List<Schedule> eventList = calendarService.getAdminEventList(emp);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", res);
		map.put("eventList", eventList);
		return map;
				
	}
	
	
	@PreAuthorize("hasAuthority('CALENDAR_AD')")
	@PostMapping(value = "/calendar/register",produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> addEvent(@RequestBody Schedule schedule) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		System.out.println(schedule);
		schedule.setEmpId(employee.getEmpId());
		ServiceResult res = calendarService.insertEvent(schedule);
		Employee emp = new Employee();
		emp.setCustId(employee.getCustId());
		emp.setDeptId(schedule.getCurCalendarDeptId());
		List<Schedule> eventList = calendarService.getAdminEventList(emp);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", res);
		map.put("eventList", eventList);
		return map;
				
	}
	
	
	@PreAuthorize("hasAuthority('CALENDAR_AD')")
	@PostMapping(value = "/calendar/delete",produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> deleteEvent(@RequestBody Schedule schedule) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		System.out.println(schedule);
		
		ServiceResult res = calendarService.deleteEvent(schedule);
		Employee emp = new Employee();
		emp.setCustId(employee.getCustId());
		emp.setDeptId(schedule.getCurCalendarDeptId());
		List<Schedule> eventList = calendarService.getAdminEventList(emp);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", res);
		map.put("eventList", eventList);
		return map;
				
	}
	
	@PreAuthorize("hasAuthority('CALENDAR_AD')")
	@PostMapping(value = "/calendar/dragChange",produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> editDragChange(@RequestBody Schedule schedule) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		System.out.println(schedule);
		
		ServiceResult res = calendarService.updateOnlyEvent(schedule);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", res);
		return map;
				
	}
}
