package kr.or.everyware.everyware.calendar.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.calendar.vo.Schedule;
import kr.or.everyware.login.vo.Employee;

public interface CalendarService {

	List<Schedule> getEventList(Employee employee);

	List<Schedule> getDeactiveEventList(String empId);

	int insertSchedule(Schedule schedule);

	ServiceResult deleteSchedule(int schdlId);

	ServiceResult modifySchedule(Schedule schedule);

	String getEmpNameById(String empId);

	List<Employee> getDeptProfileList(Employee employee);

	List<Employee> getAllProfileList(Employee employee);

	List<Schedule> getCompanyEventList(String custId);

	int getWeekEventCount(Employee employee);

	int getTodayEventCount(Employee employee);

	int getTomorrowEevntCount(Employee employee);

}
