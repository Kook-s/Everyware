package kr.or.everyware.everyware.work.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.mapper.WorkMapper;
import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.Work;

@Service
public class WorkServiceImpl implements WorkService{

	@Inject
	private WorkMapper workMapper;
	
	@Override
	public List<Work> getList() {
		return workMapper.getList();
	}
	
	@Override
	public List<Work> selectWorkToday(String empId) {
		return workMapper.selectWorkToday(empId);
	}

//	총 근태기록 수
	@Override
	public int selectWorkCount(PaginationInfo<Work> pagingVO) {
		return workMapper.selectWorkCount(pagingVO);
	}

//	근태기록 페이징
	@Override
	public List<Work> selectWorkList(PaginationInfo<Work> pagingVO) {
		return workMapper.selectWorkList(pagingVO);
	}

//	출근
	@Override
	public ServiceResult insertWorkBgngDt(HttpServletRequest req, Work work) {
		ServiceResult result = null;
		int status = workMapper.insertWorkBgngDt(work);
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public ServiceResult updateWorkEndDt(HttpServletRequest req, Work work) {
		ServiceResult result = null;
		int status = workMapper.updateWorkEndDt(work);
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult selectWorkTodayCount(HttpServletRequest req, Work work) {
		ServiceResult result = null;
		int status = workMapper.selectWorkTodayCount(work);
		if(status > 0) {
			result = ServiceResult.FAILED;
		} else {
			result = ServiceResult.OK;
		}
		
		return result;
	}

//	근태현황
	@Override
	public int selectWorkNormalCount(PaginationInfo<Work> pagingVO) {
		return workMapper.selectWorkNormalCount(pagingVO);
	}

	@Override
	public int selectWorkExtensionCount(PaginationInfo<Work> pagingVO) {
		return workMapper.selectWorkExtensionCount(pagingVO);
	}

	@Override
	public int selectWorkLatenessCount(PaginationInfo<Work> pagingVO) {
		return workMapper.selectWorkLatenessCount(pagingVO);
	}

	@Override
	public int selectWorkLeaveEarlyCount(PaginationInfo<Work> pagingVO) {
		return workMapper.selectWorkLeaveEarlyCount(pagingVO);
	}

	@Override
	public int selectWorkVacationCount(PaginationInfo<Work> pagingVO) {
		return workMapper.selectWorkVacationCount(pagingVO);
	}

	////////////////////////////////////////////////////
	@Override
	public List<Work> getWorkList(Work work) {
		return workMapper.getWorkList(work);
	}
	
	@Override
	public List<Work> getWorkToday(String empId) {
		return workMapper.getWorkToday(empId);
	}

	@Override
	public int getWorkCount(Work work) {
		return workMapper.getWorkCount(work);
	}

	@Override
	public int getWorkNormalCount(Work work) {
		return workMapper.getWorkNormalCount(work);
	}

	@Override
	public int getWorkExtensionCount(Work work) {
		return workMapper.getWorkExtensionCount(work);
	}

	@Override
	public int getWorkLatenessCount(Work work) {
		return workMapper.getWorkLatenessCount(work);
	}

	@Override
	public int getWorkLeaveEarlyCount(Work work) {
		return workMapper.getWorkLeaveEarlyCount(work);
	}

	@Override
	public int getWorkVacationCount(Work work) {
		return workMapper.getWorkVacationCount(work);
	}

	@Override
	public Work getOneWork(int workNo) {
		return workMapper.getOneWork(workNo);
	}

	@Override
	public List<Work> getAllWork(String empId) {
		// TODO Auto-generated method stub
		return workMapper.getAllWork(empId);
	}

	@Override
	public int getTodayWork(Work work) {
		// TODO Auto-generated method stub
		return workMapper.getTodayWork(work);
	}

	@Override
	public void addTodayWork(Work work) {
		workMapper.addTodayWork(work);
		
	}

	@Override
	public void editTodayWork(Work work) {
		workMapper.editTodayWork(work);
		
	}

	@Override
	public WorkGroup getWorkGroup(int groupNo) {
		// TODO Auto-generated method stub
		return workMapper.getWorkGroup(groupNo);
	}

	@Override
	public Work getTodayWork2(String empId) {
		// TODO Auto-generated method stub
		return workMapper.getTodayWork2(empId);
	}


}

