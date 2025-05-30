package kr.or.everyware.everyware.work.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.mapper.WorkStatsMapper;
import kr.or.everyware.everyware.work.vo.Work;
import kr.or.everyware.login.vo.Employee;

@Service
public class WorkStatsServiceImpl implements WorkStatsService {
	
	@Inject
	private WorkStatsMapper workStatsMapper;
	
	@Override
	public WorkGroup getWorkGroup(String empId) {
		return workStatsMapper.getWorkGroup(empId);
	}

	@Override
	public Work getWorkToday(String empId) {
		return workStatsMapper.getWorkToday(empId);
	}

}
