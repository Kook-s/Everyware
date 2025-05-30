package kr.or.everyware.admin.emp.service.impl;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.emp.mapper.AdminMapper;
import kr.or.everyware.admin.emp.service.IAdminService;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.login.vo.AuthMenu;
import kr.or.everyware.login.vo.AuthorityGroup;
import kr.or.everyware.login.vo.Employee;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Service
public class AdminServiceImpl implements IAdminService {
	@Inject
	private AdminMapper adminMapper;

	@Override
	public List<Employee> getEmployee(String custId) {
		return adminMapper.getEmployee(custId);
	}

	@Override
	public List<Department> getDepartment(String custId) {
		return adminMapper.getDepartment(custId);
	}

	@Override
	public ServiceResult addDepartment(Department dep) {
		ServiceResult res = null;
		int result = adminMapper.addDepartment(dep);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public ServiceResult addPosition(Position posi) {
		ServiceResult res = null;
		int result = adminMapper.addPosition(posi);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public ServiceResult editDepartment(Employee emp) {
		ServiceResult res = null;
		int result = adminMapper.editDepartment(emp);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public List<Position> getPosition(String custId) {
		return adminMapper.getPosition(custId);
	}

	@Override
	public ServiceResult editPosition(Employee emp) {
		ServiceResult res = null;
		int result = adminMapper.editPosition(emp);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public Employee getPopEmployee(String empId) {
		return adminMapper.getPopEmployee(empId);
	}

	@Override
	public ServiceResult editEmployee(Employee emp) {
		ServiceResult res = null;
		int result = adminMapper.editEmployee(emp);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public ServiceResult delDepartment(String deptId) {
		ServiceResult res = null;
		int result = adminMapper.delDepartment(deptId);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public ServiceResult delPosition(String jbgdId) {
		ServiceResult res = null;
		int result = adminMapper.delPosition(jbgdId);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public ServiceResult addNewEmp(Employee emp) {
		ServiceResult res = null;
		int result = adminMapper.addNewEmp(emp);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public ServiceResult addAuthGrop(AuthorityGroup authGroup) {
		ServiceResult res = null;
		int result = adminMapper.addAuthGrop(authGroup);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public ServiceResult addAuthMenu(String authrtId) {
		// TODO Auto-generated method stub
		ServiceResult res = null;
		int result = 0;

		result += adminMapper.addHome(authrtId);
		result += adminMapper.addMail(authrtId);
		result += adminMapper.addApproval(authrtId);
		result += adminMapper.addHr(authrtId);
		result += adminMapper.addAddressbook(authrtId);
		result += adminMapper.addCalendar(authrtId);
		result += adminMapper.addCloud(authrtId);
		result += adminMapper.addBoard(authrtId);
		result += adminMapper.addReservation(authrtId);
		result += adminMapper.addTodo(authrtId);
		result += adminMapper.addSuvy(authrtId);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public List<AuthorityGroup> getAuthList(String custId) {
		// TODO Auto-generated method stub
		return adminMapper.getAuthList(custId);
	}

	@Override
	public List<AuthMenu> getAuthMenu(String authrtId) {
		// TODO Auto-generated method stub
		return adminMapper.getAuthMenu(authrtId);
	}

	@Override
	public ServiceResult addAuthMenu(AuthMenu menu) {
		ServiceResult res = null;
		int result = adminMapper.addAuthMenu(menu);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public ServiceResult delAuthMenu(AuthMenu menu) {
		ServiceResult res = null;
		int result = adminMapper.delAuthMenu(menu);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public ServiceResult editAuth(Employee emp) {
		ServiceResult res = null;
		int result = adminMapper.editAuth(emp);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public int countAD(String authrtId) {
		// TODO Auto-generated method stub
		return adminMapper.countAD(authrtId);
	}

	@Override
	public void delHomeAD(String authrtId) {
		adminMapper.delHomeAD(authrtId);
		
	}

	@Override
	public int getHomeAD(String authrtId) {
		// TODO Auto-generated method stub
		return adminMapper.getHomeAD(authrtId);
	}

	@Override
	public void addHomeAD(String authrtId) {
		adminMapper.addHomeAD(authrtId);
		
	}

	@Override
	public List<WorkGroup> getWorkGroupList(String custId) {
		// TODO Auto-generated method stub
		return adminMapper.getWorkGroupList(custId);
	}

	@Override
	public ServiceResult editWorkGroup(Employee emp) {
		ServiceResult res = null;
		int result = adminMapper.editWorkGroup(emp);

		if (result > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}

		return res;
	}

	@Override
	public Employee getEmployeeOne(String empId) {
		// TODO Auto-generated method stub
		return adminMapper.getEmployeeOne(empId);
	}

}
