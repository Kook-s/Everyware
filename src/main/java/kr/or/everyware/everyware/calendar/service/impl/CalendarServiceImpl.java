package kr.or.everyware.everyware.calendar.service.impl;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.calendar.mapper.CalendarMapper;
import kr.or.everyware.everyware.calendar.service.CalendarService;
import kr.or.everyware.everyware.calendar.vo.Schedule;
import kr.or.everyware.login.vo.Employee;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Inject
	CalendarMapper mapper;
	

	@Override
	public List<Schedule> getEventList(Employee employee) {
		// TODO Auto-generated method stub
		return mapper.getEventList(employee);
	}


	@Override
	public List<Schedule> getDeactiveEventList(String empId) {
		// TODO Auto-generated method stub
		return mapper.getDeactiveEventList(empId);
	}


	@Override
	public int insertSchedule(Schedule schedule) {
		int res = mapper.insertSchedule(schedule);
		if(res>0) {
			return schedule.getSchdlId();
		}else {
			return 0;
		}
	}


	@Override
	public ServiceResult deleteSchedule(int schdlId) {
		// TODO Auto-generated method stub
		ServiceResult res = null;
		int deleteScheduleMember = mapper.deleteScheduleMember(schdlId);
		int result = mapper.deleteSchedule(schdlId);
		if(result>0) {
			res=ServiceResult.OK;
		}else {
			res=ServiceResult.FAILED;
		}
		return res;
	}


	@Override
	public ServiceResult modifySchedule(Schedule schedule) {
		// TODO Auto-generated method stub
		ServiceResult res = null;
		int result = 1;
		List<String> memberIdList = schedule.getMemberIdList();
		int delRes=mapper.deleteScheduleMember(schedule.getSchdlId());
		
		if(memberIdList!=null&&memberIdList.size()>0) {
			for (String empId : memberIdList) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("empId", empId);
				map.put("schdlId", schedule.getSchdlId());
				result = mapper.insertScheduleMember(map);
				if(result==0) {
					return ServiceResult.FAILED;
				}
			}
			
		}

		result = mapper.modifySchedule(schedule);
		if(result>0) {
			res=ServiceResult.OK;
		}else {
			res=ServiceResult.FAILED;
		}
		return res;
	}



	private int insertScheduleMember(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.insertScheduleMember(map);
	}


	@Override
	public String getEmpNameById(String empId) {
		// TODO Auto-generated method stub
		return mapper.getEmpNameById(empId);
	}


	@Override
	public List<Employee> getDeptProfileList(Employee employee) {
		// TODO Auto-generated method stub
		return mapper.getDeptProfileList(employee);
	}


	@Override
	public List<Employee> getAllProfileList(Employee employee) {
		// TODO Auto-generated method stub
		return mapper.getAllProfileList(employee);
	}


	@Override
	public List<Schedule> getCompanyEventList(String custId) {
		// TODO Auto-generated method stub
		return mapper.getCompanyEventList(custId);
	}


	@Override
	public int getWeekEventCount(Employee employee) {
		// TODO Auto-generated method stub
		LocalDate now = LocalDate.now();
		LocalDate start = now.with(DayOfWeek.MONDAY);
		LocalDate end = now.with(DayOfWeek.SUNDAY);
		System.out.println(start);
		System.out.println(end);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("custId", employee.getCustId());
		map.put("empId", employee.getEmpId());
		map.put("deptId", employee.getDeptId());
		map.put("start", start.toString().replace("-", "/"));
		map.put("end", end.toString().replace("-", "/"));
		
		
		return mapper.getWeekEventCount(map);
	}


	@Override
	public int getTodayEventCount(Employee employee) {
		LocalDate now = LocalDate.now();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("custId", employee.getCustId());
		map.put("empId", employee.getEmpId());
		map.put("deptId", employee.getDeptId());
		map.put("today", now.toString().replace("-", "/"));
		return mapper.getTodayEventCount(map);
	}


	@Override
	public int getTomorrowEevntCount(Employee employee) {
		// TODO Auto-generated method stub
		LocalDate now = LocalDate.now();
		LocalDate tomorrow = now.plus(1,ChronoUnit.DAYS);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("custId", employee.getCustId());
		map.put("empId", employee.getEmpId());
		map.put("deptId", employee.getDeptId());
		map.put("tomorrow", tomorrow.toString().replace("-", "/"));
		return mapper.getTomorrowEevntCount(map);
	}

}
