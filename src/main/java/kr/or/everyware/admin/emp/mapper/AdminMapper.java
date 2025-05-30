package kr.or.everyware.admin.emp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.login.vo.AuthMenu;
import kr.or.everyware.login.vo.AuthorityGroup;
import kr.or.everyware.login.vo.Employee;

@Mapper
public interface AdminMapper {
    public List<Employee> getEmployee(String custId);

    public List<Department>  getDepartment(String custId);

    public  int addDepartment(Department dep);
    
    public int addPosition(Position posi);

    public  int editDepartment(Employee emp);

    public  List<Position> getPosition(String custId);

    public  int editPosition(Employee emp);

    public Employee getPopEmployee(String empId);

    public int editEmployee(Employee emp);

	public int delDepartment(String deptId);

	public int delPosition(String jbgdId);

	public int addNewEmp(Employee emp);

	public int addAuthGrop(AuthorityGroup authGroup);



	public int addHome(String authrtId);

	public int addMail(String authrtId);

	public int addApproval(String authrtId);

	public int addHr(String authrtId);

	public int addAddressbook(String authrtId);

	public int addCalendar(String authrtId);

	public int addCloud(String authrtId);

	public int addBoard(String authrtId);

	public int addReservation(String authrtId);

	public int addTodo(String authrtId);

	public int addSuvy(String authrtId);

	public List<AuthorityGroup> getAuthList(String custId);

	public List<AuthMenu> getAuthMenu(String authrtId);

	public int addAuthMenu(AuthMenu menu);

	public int delAuthMenu(AuthMenu menu);

	public int editAuth(Employee emp);

	public int countAD(String authrtId);

	public void delHomeAD(String authrtId);

	public int getHomeAD(String authrtId);

	public void addHomeAD(String authrtId);

	public List<WorkGroup> getWorkGroupList(String custId);

	public int editWorkGroup(Employee emp);

	public Employee getEmployeeOne(String empId);

	

}
