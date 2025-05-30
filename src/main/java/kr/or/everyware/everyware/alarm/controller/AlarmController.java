package kr.or.everyware.everyware.alarm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.alarm.service.AlarmService;
import kr.or.everyware.everyware.chat.vo.Alarm;
import kr.or.everyware.everyware.chat.vo.Message;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;

@Controller
@RequestMapping("/everyware/alarm")
public class AlarmController {

	@Inject
	AlarmService alarmService;
	
	@PostMapping(value = "/alarmList",produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String,Object> getAlarmList(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		String empId = employee.getEmpId();
		Map<String, Object> map = new HashMap<String, Object>();
		List<Alarm> list = alarmService.getAlarmList(empId);
		int messageUnreadCount=alarmService.unreadMessageCount(empId);
		Message message = alarmService.LastMessageDate(empId);
		map.put("alarmList", list);
		map.put("messageUnreadCount", messageUnreadCount);
		map.put("lastMessage", message);
		return map;
	}
	
	@PostMapping(value = "/remove",produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String,Object> deleteAlarmList(@RequestBody Map<String, Object> map){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		String str = map.get("alarmId").toString();
		
		ServiceResult res = alarmService.deleteAlarm(Integer.parseInt(str));
		map.put("res", res);
		return map;
	}
	
	@PostMapping(value = "/removeAll",produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String,Object> deleteAlarmListAll(){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		ServiceResult res = alarmService.deleteAllAlarm(employee.getEmpId());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res", res);
		return map;
	}
}
