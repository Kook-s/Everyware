package kr.or.everyware.everyware.alarm.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.chat.vo.Alarm;
import kr.or.everyware.everyware.chat.vo.Message;

public interface AlarmService {

	List<Alarm> getAlarmList(String empId);

	int unreadMessageCount(String empId);

	Message LastMessageDate(String empId);

	ServiceResult deleteAlarm(int alarmId);

	ServiceResult deleteAllAlarm(String empId);

}
