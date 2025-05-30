package kr.or.everyware.everyware.work.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.everyware.work.mapper.WorkAdjMapper;
import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.WorkAdj;

@Service
public class WorkAdjServiceImpl implements WorkAdjService {

	@Inject
	private WorkAdjMapper workAdjMapper;

	@Override
	public List<WorkAdj> getWorkAdjList(WorkAdj workAdj) {
		return workAdjMapper.getWorkAdjList(workAdj);
	}

	@Override
	public int getTotalRecord(WorkAdj workAdj) {
		return workAdjMapper.getTotalRecord(workAdj);
	}

	
}
