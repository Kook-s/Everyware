package kr.or.everyware.admin.calendar.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.calendar.vo.Schedule;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.login.vo.Employee;

public interface AdminCalendarService {

	List<Schedule> getAdminEventList(Employee employee);

	List<Department> getDepartmentList(String custId);

	List<Employee> getDeptProfileList(Employee employee);

	List<Employee> getAllProfileList(Employee employee);

	ServiceResult insertEvent(Schedule schedule);

	ServiceResult updateEvent(Schedule schedule);

	ServiceResult deleteEvent(Schedule schedule);

	ServiceResult updateOnlyEvent(Schedule schedule);

}
