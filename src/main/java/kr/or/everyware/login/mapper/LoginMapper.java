package kr.or.everyware.login.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.login.vo.Client;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.login.vo.LoginLog;

@Mapper
public interface LoginMapper {

	Client readByClientId(String username);

	Employee readByEmployeeId(String username);

	public int updateMyPage(Employee emp);

	Employee getEmp(Employee emp);

	void inserLoginLog(LoginLog loginLog);

	int updateEmployee(Employee emp);

	Employee getEmployee(String empId);

	List<LoginLog> getIpList(String empId);

}
