package kr.or.everyware.everyware.work.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.Work;

@Mapper
public interface WorkMapper {
	public List<Work> getList();
	public int selectWorkCount(PaginationInfo<Work> pagingVO);
	public List<Work> selectWorkList(PaginationInfo<Work> pagingVO);
	public int insertWorkBgngDt(Work work);
	public int updateWorkEndDt(Work work);
	public List<Work> selectWorkToday(String empId);
	public int selectWorkTodayCount(Work work);
	
	//	근태현황
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
	
	//메인페이지 그래프
	public List<Work> getAllWork(String empId);
	public int getTodayWork(Work work);
	public void addTodayWork(Work work);
	public void editTodayWork(Work work);
	public WorkGroup getWorkGroup(int groupNo);
	public Work getTodayWork2(String empId);

}
