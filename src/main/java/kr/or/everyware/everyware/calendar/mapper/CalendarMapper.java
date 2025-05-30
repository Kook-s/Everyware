package kr.or.everyware.everyware.calendar.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.calendar.vo.Schedule;
import kr.or.everyware.login.vo.Employee;

@Mapper
public interface CalendarMapper {

	List<Schedule> getEventList(Employee employee);

	List<Schedule> getDeactiveEventList(String empId);

	int insertSchedule(Schedule schedule);

	int deleteSchedule(int schdlId);

	int modifySchedule(Schedule schedule);

	String getEmpNameById(String empId);

	List<Employee> getAllProfileList(Employee employee);

	List<Employee> getDeptProfileList(Employee employee);

	int insertScheduleMember(Map<String, Object> map);

	int deleteScheduleMember(int schdlId);

	List<Schedule> getCompanyEventList(String custId);

	int getWeekEventCount(Map<String, Object> map);

	int getTodayEventCount(Map<String, Object> map);

	int getTomorrowEevntCount(Map<String, Object> map);

}
