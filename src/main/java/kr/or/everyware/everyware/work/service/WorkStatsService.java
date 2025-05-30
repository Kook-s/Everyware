package kr.or.everyware.everyware.work.service;

import java.util.List;

import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.vo.Work;

public interface WorkStatsService {

	public WorkGroup getWorkGroup(String empId);

	public Work getWorkToday(String empId);

}
