package kr.or.everyware.admin.work.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.work.vo.WorkAdmin;
import kr.or.everyware.everyware.work.vo.Work;

@Mapper
public interface WorkAdminMapper {

	public int getTotalRecord(WorkAdmin workAdmin);

	public List<WorkAdmin> getAdminWorkList(WorkAdmin workAdmin);

	// 현황
	public int getTotalWork(WorkAdmin workAdmin);

	public int getTotalNormal(WorkAdmin workAdmin);

	public int getWorkExtensionCount(WorkAdmin workAdmin);

	public int getWorkLatenessCount(WorkAdmin workAdmin);

	public int getWorkLeaveEarlyCount(WorkAdmin workAdmin);

	public int getWorkVacationCount(WorkAdmin workAdmin);

}
