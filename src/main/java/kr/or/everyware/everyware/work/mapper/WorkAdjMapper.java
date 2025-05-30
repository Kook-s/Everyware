package kr.or.everyware.everyware.work.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.WorkAdj;

@Mapper
public interface WorkAdjMapper {

	public List<WorkAdj> getWorkAdjList(WorkAdj workAdj);

	public int getTotalRecord(WorkAdj workAdj);

}
