package kr.or.everyware.everyware.mypage.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.login.vo.LoginLog;

public interface MyPageservice {

	int updateMyPage(Employee emp);

	Employee getEmp(Employee employee);

	ServiceResult updateEmployee(Employee emp);

	Employee readByEmployeeId(String empId);

	Employee getEmployee(String empId);

	List<LoginLog> getIpList(String empId);


}
