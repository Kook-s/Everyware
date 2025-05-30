package kr.or.everyware.everyware.contact.vo;

import java.util.List;

import com.google.gson.annotations.SerializedName;

import kr.or.everyware.login.vo.Employee;
import lombok.Data;

@Data
public class Department {
	private String deptId;
	private String deptNm;
	private String custId;
	private List<Employee> employees;
	
	private int aprvSn;
}
