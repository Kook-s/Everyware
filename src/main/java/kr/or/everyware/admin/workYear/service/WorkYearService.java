package kr.or.everyware.admin.workYear.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.workYear.vo.WorkYear;

public interface WorkYearService {

	public List<WorkYear> getWorkYear(String custId);

	public ServiceResult addWorkYear(WorkYear workYear);

	public int delWorkYear(int wyNo);

	public ServiceResult editWorkYear(WorkYear workYear);

}
