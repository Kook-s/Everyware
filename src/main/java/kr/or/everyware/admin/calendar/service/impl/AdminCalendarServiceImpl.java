package kr.or.everyware.admin.calendar.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.calendar.mapper.AdminCalendarMapper;
import kr.or.everyware.admin.calendar.service.AdminCalendarService;
import kr.or.everyware.everyware.calendar.vo.Schedule;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.login.vo.Employee;

@Service
public class AdminCalendarServiceImpl implements AdminCalendarService{

	@Inject
	AdminCalendarMapper mapper;
	
	@Override
	public List<Schedule> getAdminEventList(Employee employee) {
		// TODO Auto-generated method stub
		return mapper.getAdminEventList(employee);
	}

	@Override
	public List<Department> getDepartmentList(String custId) {
		// TODO Auto-generated method stub
		return mapper.getDepartmentList(custId);
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
	public ServiceResult insertEvent(Schedule schedule) {
		// TODO Auto-generated method stub
		
		int res = mapper.insertEvent(schedule);
		if(res>0) {
			List<String> idList = schedule.getMemberIdList();
			if(idList!=null && idList.size()>0) {
				int memRes=0;
				for (String empId : idList) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("empId",empId );
					map.put("schdlId", schedule.getSchdlId());
					int row = mapper.insertEventMember(map);
					memRes+=row;
				}
				
				if(memRes==idList.size()) {
					return ServiceResult.OK;
				}else {
					return ServiceResult.FAILED;
				}
			}else {
				return ServiceResult.OK;
			}
		}else {
			return ServiceResult.FAILED;
		}
		
	}

	@Override
	public ServiceResult updateEvent(Schedule schedule) {
		// TODO Auto-generated method stub
		int res = mapper.updateEvent(schedule);
		List<String> idList = schedule.getMemberIdList();
		int delRes = mapper.deleteScheduleMember(schedule.getSchdlId());
		if(idList!=null && idList.size()>0 ) {
			
			for (String empId : idList) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("empId", empId);
				map.put("schdlId", schedule.getSchdlId());
				int insRes = mapper.insertEventMember(map);
			}
		}
		
		return ServiceResult.getExecutionResult(res);
	}

	@Override
	public ServiceResult deleteEvent(Schedule schedule) {
		// TODO Auto-generated method stub
		int delRes = mapper.deleteScheduleMember(schedule.getSchdlId());
		
		int res = mapper.deleteEvent(schedule.getSchdlId());
		
		return ServiceResult.getExecutionResult(res);
	}

	@Override
	public ServiceResult updateOnlyEvent(Schedule schedule) {
		// TODO Auto-generated method stub
		int res = mapper.updateEvent(schedule);
		
		return ServiceResult.getExecutionResult(res);
	}

}
