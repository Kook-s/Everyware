package kr.or.everyware.everyware.alarm.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.alarm.mapper.AlarmMapper;
import kr.or.everyware.everyware.alarm.service.AlarmService;
import kr.or.everyware.everyware.chat.vo.Alarm;
import kr.or.everyware.everyware.chat.vo.Message;

@Service
public class AlarmServiceImpl implements AlarmService {

	@Inject
	AlarmMapper mapper;
	
	@Override
	public List<Alarm> getAlarmList(String empId) {
		// TODO Auto-generated method stub
		return mapper.getAlarmList(empId);
	}

	@Override
	public int unreadMessageCount(String empId) {
		// TODO Auto-generated method stub
		return mapper.unreadMessageCount(empId);
	}

	@Override
	public Message LastMessageDate(String empId) {
		// TODO Auto-generated method stub
		return mapper.LastMessageDate(empId);
	}

	@Override
	public ServiceResult deleteAlarm(int alarmId) {

		int num=mapper.deleteAlarm(alarmId);
		ServiceResult res= ServiceResult.getExecutionResult(num);
		return res;
	}

	@Override
	public ServiceResult deleteAllAlarm(String empId) {
		// TODO Auto-generated method stub
		return ServiceResult.getExecutionResult(mapper.deleteAllAlarm(empId));
	}

}
