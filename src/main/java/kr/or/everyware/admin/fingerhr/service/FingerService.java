package kr.or.everyware.admin.fingerhr.service;

import java.util.List;

import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.vo.Work;
import kr.or.everyware.login.vo.Employee;

public interface FingerService {

	List<Employee> getFingerEmpList(String custId);

	Employee getFingerEmp(String fingerId);

	int getEmpWork(String fEmpId);

	void addEmpWork(Work work);

	void editEmpWork(Work work);

	WorkGroup getWorkGroup(int groupNo);

	Work getWork(String empId);


}
