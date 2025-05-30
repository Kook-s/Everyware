package kr.or.everyware.everyware.work.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.userdetails.User;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.Work;

public interface WorkService {
	public List<Work> getList();
	public int selectWorkCount(PaginationInfo<Work> pagingVO);
	public List<Work> selectWorkList(PaginationInfo<Work> pagingVO);
	public ServiceResult insertWorkBgngDt(HttpServletRequest req, Work work);
	public ServiceResult updateWorkEndDt(HttpServletRequest req, Work work);
	public List<Work> selectWorkToday(String empId);
	public ServiceResult selectWorkTodayCount(HttpServletRequest req, Work work);
	
	// 근태현황
	public int selectWorkNormalCount(PaginationInfo<Work> pagingVO);
	public int selectWorkExtensionCount(PaginationInfo<Work> pagingVO);
	public int selectWorkLatenessCount(PaginationInfo<Work> pagingVO);
	public int selectWorkLeaveEarlyCount(PaginationInfo<Work> pagingVO);
	public int selectWorkVacationCount(PaginationInfo<Work> pagingVO);
	
	// 근태현황
	public List<Work> getWorkList(Work work);
	public List<Work> getWorkToday(String empId);
	public int getWorkCount(Work work);
	public int getWorkNormalCount(Work work);
	public int getWorkExtensionCount(Work work);
	public int getWorkLatenessCount(Work work);
	public int getWorkLeaveEarlyCount(Work work);
	public int getWorkVacationCount(Work work);
	public Work getOneWork(int workNo);
	public List<Work> getAllWork(String empId);
	public int getTodayWork(Work work);
	public void addTodayWork(Work work);
	public void editTodayWork(Work work);
	public WorkGroup getWorkGroup(int groupNo);
	public Work getTodayWork2(String empId);

}

