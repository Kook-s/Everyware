package kr.or.everyware.admin.workYear.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.workYear.vo.WorkYear;

@Mapper
public interface WorkYearMapper {

	public List<WorkYear> getWorkYear(String custId);

	public int addWorkYear(WorkYear workYear);

	public int delWorkYear(int wyNo);

	public int editWorkYear(WorkYear workYear);

}
