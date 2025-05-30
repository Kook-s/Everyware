package kr.or.everyware.admin.emp.service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.login.vo.AuthMenu;
import kr.or.everyware.login.vo.AuthorityGroup;
import kr.or.everyware.login.vo.Employee;

import java.util.List;

import org.springframework.http.ResponseEntity;

public interface IAdminService {
    public List<Employee> getEmployee(String custId);

    public  List<Department>  getDepartment(String custId);

    public  ServiceResult addDepartment(Department dep);

    public  ServiceResult editDepartment(Employee emp);

    public  List<Position> getPosition(String custId);

    public  ServiceResult editPosition(Employee emp);

    public  Employee getPopEmployee(String empId);

    public ServiceResult editEmployee(Employee emp);

	public ServiceResult addPosition(Position posi);

	public ServiceResult delDepartment(String deptId);

	public ServiceResult delPosition(String jbgdId);

	public ServiceResult addNewEmp(Employee emp);

	public ServiceResult addAuthGrop(AuthorityGroup authGroup);

	public ServiceResult addAuthMenu(String authrtId);

	public List<AuthorityGroup> getAuthList(String custId);

	public List<AuthMenu> getAuthMenu(String authrtId);

	public ServiceResult addAuthMenu(AuthMenu menu);

	public ServiceResult delAuthMenu(AuthMenu menu);

	public ServiceResult editAuth(Employee emp);

	public int countAD(String authrtId);

	public void delHomeAD(String authrtId);

	public int getHomeAD(String authrtId);

	public void addHomeAD(String authrtId);

	public List<WorkGroup> getWorkGroupList(String custId);

	public ServiceResult editWorkGroup(Employee emp);

	public Employee getEmployeeOne(String empId);

}
