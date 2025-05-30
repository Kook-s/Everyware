package kr.or.everyware.everyware.chat.service;

import java.util.List;

import kr.or.everyware.login.vo.Employee;

public interface EmpService {


	Employee selectEmployeeById(String empId);

	List<Employee> selectEmployees(Employee employee);

}
