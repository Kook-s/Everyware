package kr.or.everyware.everyware.work.service;

import java.util.List;

import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.WorkAdj;

public interface WorkAdjService {

	public List<WorkAdj> getWorkAdjList(WorkAdj workAdj);
	
	public int getTotalRecord(WorkAdj workAdj);



}
