package kr.or.everyware.admin.work.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.admin.work.mapper.WorkAdminMapper;
import kr.or.everyware.admin.work.vo.WorkAdmin;
import kr.or.everyware.admin.work.vo.WorkAdminPaging;
import kr.or.everyware.everyware.work.vo.Work;
import kr.or.everyware.login.vo.Employee;

@Service
public class WorkAdminServiceImpl implements WorkAdminService{
	
	@Inject
	private WorkAdminMapper workAdminMapper;

	@Override
	public int getTotalRecord(WorkAdmin workAdmin) {
		return workAdminMapper.getTotalRecord(workAdmin);
	}

	@Override
	public List<WorkAdmin> getAdminWorkList(WorkAdmin workAdmin) {
		return workAdminMapper.getAdminWorkList(workAdmin);
	}

	@Override
	public int getTotalWork(WorkAdmin workAdmin) {
		return workAdminMapper.getTotalWork(workAdmin);
	}

	@Override
	public int getTotalNormal(WorkAdmin workAdmin) {
		return workAdminMapper.getTotalNormal(workAdmin);
	}

	@Override
	public int getWorkExtensionCount(WorkAdmin workAdmin) {
		return workAdminMapper.getWorkExtensionCount(workAdmin);
	}

	@Override
	public int getWorkLatenessCount(WorkAdmin workAdmin) {
		return workAdminMapper.getWorkLatenessCount(workAdmin);
	}

	@Override
	public int getWorkLeaveEarlyCount(WorkAdmin workAdmin) {
		return workAdminMapper.getWorkLeaveEarlyCount(workAdmin);
	}

	@Override
	public int getWorkVacationCount(WorkAdmin workAdmin) {
		return workAdminMapper.getWorkVacationCount(workAdmin);
	}

}
