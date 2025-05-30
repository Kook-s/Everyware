package kr.or.everyware.admin.work.service;

import java.util.List;

import kr.or.everyware.admin.work.vo.WorkAdmin;

public interface WorkAdminService {

	public int getTotalRecord(WorkAdmin workAdmin);

	public List<WorkAdmin> getAdminWorkList(WorkAdmin workAdmin);

	public int getTotalWork(WorkAdmin workAdmin);

	public int getTotalNormal(WorkAdmin workAdmin);

	public int getWorkExtensionCount(WorkAdmin workAdmin);

	public int getWorkLatenessCount(WorkAdmin workAdmin);

	public int getWorkLeaveEarlyCount(WorkAdmin workAdmin);

	public int getWorkVacationCount(WorkAdmin workAdmin);

}
