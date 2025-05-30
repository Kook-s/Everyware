package kr.or.everyware.everyware.work.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.vo.Work;

@Mapper
public interface WorkStatsMapper {

	public WorkGroup getWorkGroup(String empId);

	public Work getWorkToday(String empId);

}
