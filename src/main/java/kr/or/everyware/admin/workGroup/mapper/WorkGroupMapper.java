package kr.or.everyware.admin.workGroup.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.workGroup.vo.WorkGroup;

@Mapper
public interface WorkGroupMapper {

	public List<WorkGroup> getWorkGroup(String custId);

	public int addWorkGorup(WorkGroup workGroup);

	public WorkGroup getOneWorkGroup(int groupNo);

	public int editGroup(WorkGroup workGroup);

	public int delWorkGroup(int groupNo);

	public int getWorkGroupCount(String custId);

}
