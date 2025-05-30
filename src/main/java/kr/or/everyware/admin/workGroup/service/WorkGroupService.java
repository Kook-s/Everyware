package kr.or.everyware.admin.workGroup.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;

public interface WorkGroupService {

	public List<WorkGroup> getWorkGroup(String custId);

	public ServiceResult addWorkGorup(WorkGroup workGroup);

	public WorkGroup getOneWorkGroup(int groupNo);

	public ServiceResult editGroup(WorkGroup workGroup);

	public int delWorkGroup(int groupNo);

	public int getWorkGroupCount(String custId);


}
