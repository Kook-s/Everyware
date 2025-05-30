package kr.or.everyware.admin.fingerhr.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.admin.fingerhr.mapper.FingerMapper;
import kr.or.everyware.admin.fingerhr.service.FingerService;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.work.vo.Work;
import kr.or.everyware.login.vo.Employee;

@Service
public class FingerServiceImpl implements FingerService{

	@Inject
	private FingerMapper fingerMapper;
	
	@Override
	public List<Employee> getFingerEmpList(String custId) {
		// TODO Auto-generated method stub
		return fingerMapper.getFingerEmpList(custId);
	}

	@Override
	public Employee getFingerEmp(String fingerId) {
		// TODO Auto-generated method stub
		return fingerMapper.getFingerEmp(fingerId);
	}

	@Override
	public int getEmpWork(String fEmpId) {
		// TODO Auto-generated method stub
		return fingerMapper.getEmpWork(fEmpId);
	}

	@Override
	public void addEmpWork(Work work) {
		// TODO Auto-generated method stub
		fingerMapper.addEmpWork(work);
	}

	@Override
	public void editEmpWork(Work work) {
		fingerMapper.editEmpWork(work);
		
	}

	@Override
	public WorkGroup getWorkGroup(int groupNo) {
		// TODO Auto-generated method stub
		return fingerMapper.getWorkGroup(groupNo);
	}

	@Override
	public Work getWork(String empId) {
		// TODO Auto-generated method stub
		return fingerMapper.getWork(empId);
	}

}
