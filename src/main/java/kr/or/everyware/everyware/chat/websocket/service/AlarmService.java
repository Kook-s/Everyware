package kr.or.everyware.everyware.chat.websocket.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;

import kr.or.everyware.everyware.alarm.mapper.AlarmMapper;
import kr.or.everyware.everyware.chat.vo.Alarm;
import kr.or.everyware.everyware.chat.vo.WebsocketMessage;
import kr.or.everyware.login.vo.Employee;

@Service
public class AlarmService {

	@Inject
	AlarmMapper mapper;
	
	public void alarmProccess(WebSocketSession session, WebsocketMessage vo) throws IOException {
		// TODO Auto-generated method stub
		System.out.println(vo.getAlarm());
		Map<String, WebSocketSession> loginUsers=LoginStateService.sessions;
		Alarm alarm = vo.getAlarm();
		if(alarm.getAlarmType()==1) {
			if(alarm.getEmpId()!=null) {
				Employee sender = mapper.selectEmployee(alarm.getSndrNm());
				int res = mapper.insertAlarm(alarm);
				alarm.setSender(sender);
				alarm.setType("al");
				if(loginUsers.containsKey(alarm.getEmpId())) {
					WebSocketSession wss = loginUsers.get(alarm.getEmpId());
					Gson gson = new Gson();
					String json = gson.toJson(alarm);
					TextMessage tm = new TextMessage(json.getBytes());
					wss.sendMessage(tm);
				}
			}else if(alarm.getEmpIdList()!=null) {
				Employee sender = mapper.selectEmployee(alarm.getSndrNm());
				alarm.setType("al");
				for (String empId : alarm.getEmpIdList()) {
					alarm.setEmpId(empId);
					int res = mapper.insertAlarm(alarm);
					alarm.setSender(sender);
					if(loginUsers.containsKey(empId)) {
						WebSocketSession wss = loginUsers.get(alarm.getEmpId());
						Gson gson = new Gson();
						String json = gson.toJson(alarm);
						TextMessage tm = new TextMessage(json.getBytes());
						wss.sendMessage(tm);
					}
				}
			}else {
				System.out.println("받는사람 없는 에러");
			}
			
		}else if(alarm.getAlarmType()==7) {
			if(alarm.getCustId()!=null) { //회사일정 등록 발생시
				List<Employee> list = mapper.selectEmployeeListByCustId(alarm.getCustId());
				alarm.setType("al");
				for (Employee employee : list) {
					String empId = employee.getEmpId();
					alarm.setEmpId(empId);
					int res = mapper.insertAlarm(alarm);
					
					alarm.setEmpId("");
					if(loginUsers.containsKey(empId)) {
						WebSocketSession wss = loginUsers.get(empId);
						Gson gson = new Gson();
						String json = gson.toJson(alarm);
						TextMessage tm = new TextMessage(json.getBytes());
						wss.sendMessage(tm);
					}
				}

			}else {							//부서일정 등록 발생시
				List<Employee> list = mapper.selectEmployeeListByDeptId(alarm.getDeptId());
				alarm.setType("al");
				for (Employee employee : list) {
					String empId = employee.getEmpId();
					alarm.setEmpId(empId);
					int res = mapper.insertAlarm(alarm);
					
					alarm.setEmpId("");
					if(loginUsers.containsKey(empId)) {
						WebSocketSession wss = loginUsers.get(empId);
						Gson gson = new Gson();
						String json = gson.toJson(alarm);
						TextMessage tm = new TextMessage(json.getBytes());
						wss.sendMessage(tm);
					}
				}
			}
		}else if(alarm.getAlarmType()==8) {
			if(alarm.getCustId()!=null) { //회사일정 변경 발생시
				List<Employee> list = mapper.selectEmployeeListByCustId(alarm.getCustId());
				alarm.setType("al");
				for (Employee employee : list) {
					String empId = employee.getEmpId();
					alarm.setEmpId(empId);
					int res = mapper.insertAlarm(alarm);
					
					alarm.setEmpId("");
					if(loginUsers.containsKey(empId)) {
						WebSocketSession wss = loginUsers.get(empId);
						Gson gson = new Gson();
						String json = gson.toJson(alarm);
						TextMessage tm = new TextMessage(json.getBytes());
						wss.sendMessage(tm);
					}
				}
			}else {							//부서일정 변경 발생시
				List<Employee> list = mapper.selectEmployeeListByDeptId(alarm.getDeptId());
				alarm.setType("al");
				for (Employee employee : list) {
					String empId = employee.getEmpId();
					alarm.setEmpId(empId);
					int res = mapper.insertAlarm(alarm);
					
					alarm.setEmpId("");
					if(loginUsers.containsKey(empId)) {
						WebSocketSession wss = loginUsers.get(empId);
						Gson gson = new Gson();
						String json = gson.toJson(alarm);
						TextMessage tm = new TextMessage(json.getBytes());
						wss.sendMessage(tm);
					}
				}
			}
		}else if(alarm.getAlarmType()==9) {
			List<String> empIdList = alarm.getEmpIdList();
			alarm.setType("al");
			for (String empId : empIdList) {
				alarm.setEmpId(empId);
				int res = mapper.insertAlarm(alarm);
				if(loginUsers.containsKey(empId)) {
					WebSocketSession wss = loginUsers.get(alarm.getEmpId());
					Gson gson = new Gson();
					String json = gson.toJson(alarm);
					TextMessage tm = new TextMessage(json.getBytes());
					wss.sendMessage(tm);
				}
			}
		}
		
	}

}
