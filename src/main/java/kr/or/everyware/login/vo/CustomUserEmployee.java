package kr.or.everyware.login.vo;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUserEmployee extends User {

	private Employee employee;
	
	public CustomUserEmployee(String username, String password, Collection<GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUserEmployee(Employee employee) {	
		super(employee.getEmpId(), employee.getEmpPw(),
				/*employee.getEmpAuthority().getAuthorityGroup().getAuthMenuList().stream()
				.map(auth_menu -> new SimpleGrantedAuthority(auth_menu.getMenuId())).collect(Collectors.toList()));*/
				employee.getAuthMenuList().stream()
				.map(auth_menu -> new SimpleGrantedAuthority(auth_menu.getMenuId())).collect(Collectors.toList()));
		this.employee = employee;
	}
	
	public Employee getEmployee() {
		return employee;
	}
	
	public void setEmployee(Employee employee) {
		this.employee=employee;
	}
}
