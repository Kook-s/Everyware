package kr.or.everyware.admin.calendar.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.calendar.vo.Schedule;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.login.vo.Employee;

@Mapper
public interface AdminCalendarMapper {

	List<Schedule> getAdminEventList(Employee employee);

	List<Department> getDepartmentList(String custId);

	List<Employee> getDeptProfileList(Employee employee);

	List<Employee> getAllProfileList(Employee employee);

	int insertEvent(Schedule schedule);

	int insertEventMember(Map<String, Object> map);

	int updateEvent(Schedule schedule);

	int deleteScheduleMember(int i);

	int deleteEvent(int schdlId);

}
