package kr.or.everyware.everyware.alarm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.chat.vo.Alarm;
import kr.or.everyware.everyware.chat.vo.Message;
import kr.or.everyware.login.vo.Employee;

@Mapper
public interface AlarmMapper {

	List<Alarm> getAlarmList(String empId);

	int insertAlarm(Alarm alarm);

	Employee selectEmployee(String sndrNm);

	int unreadMessageCount(String empId);

	Message LastMessageDate(String empId);

	int deleteAlarm(int alarmId);

	List<Employee> selectEmployeeListByDeptId(int deptId);

	List<Employee> selectEmployeeListByCustId(String custId);

	int deleteAllAlarm(String empId);

}
