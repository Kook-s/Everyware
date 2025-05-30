package kr.or.everyware.admin.fingerhr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.vo.Work;
import kr.or.everyware.login.vo.Employee;

@Mapper
public interface FingerMapper {

	public List<Employee> getFingerEmpList(String custId);

	public Employee getFingerEmp(String fingerId);

	public int getEmpWork(String fEmpId);

	public void addEmpWork(Work work);

	public void editEmpWork(Work work);

	public WorkGroup getWorkGroup(int groupNo);

	public Work getWork(String empId);

}
	