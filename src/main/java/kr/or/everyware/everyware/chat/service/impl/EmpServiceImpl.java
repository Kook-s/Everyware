package kr.or.everyware.everyware.chat.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.everyware.chat.mapper.ChatMapper;
import kr.or.everyware.everyware.chat.service.EmpService;
import kr.or.everyware.login.vo.Employee;



@Service
public class EmpServiceImpl implements EmpService {
	
	@Inject
	private ChatMapper mapper;
	
	@Override
	public List<Employee> selectEmployees(Employee employee) {
		// TODO Auto-generated method stub
		return mapper.selectEmployees(employee);
	}

	@Override
	public Employee selectEmployeeById(String empId) {
		// TODO Auto-generated method stub
		return mapper.selectEmployeeById(empId);
	}


}
