package kr.or.everyware.admin.workGroup.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.workGroup.mapper.WorkGroupMapper;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import lombok.extern.slf4j.Slf4j;
import sun.util.logging.resources.logging;

@Slf4j
@Service
public class WorkGroupServiceImpl implements WorkGroupService{
	
	@Inject
	private WorkGroupMapper workGroupMapper;
	
	@Override
	public List<WorkGroup> getWorkGroup(String custId) {
		return workGroupMapper.getWorkGroup(custId);
	}

	@Override
	public ServiceResult addWorkGorup(WorkGroup workGroup) {
		ServiceResult result = null;
		
		int status = workGroupMapper.addWorkGorup(workGroup);
		
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public WorkGroup getOneWorkGroup(int groupNo) {
		return workGroupMapper.getOneWorkGroup(groupNo);
	}

	@Override
	public ServiceResult editGroup(WorkGroup workGroup) {
		ServiceResult result = null;
		
		int status = workGroupMapper.editGroup(workGroup);
		
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public int delWorkGroup(int groupNo) {
		return workGroupMapper.delWorkGroup(groupNo);
	}

	@Override
	public int getWorkGroupCount(String custId) {
		return workGroupMapper.getWorkGroupCount(custId);
	}

}
