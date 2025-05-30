package kr.or.everyware.everyware.calendar.vo;

import java.util.Date;
import java.util.List;

import kr.or.everyware.login.vo.Employee;
import lombok.Data;

@Data
public class Schedule {
	private int schdlId;
	private String schdlTtl;
	private int schdlType;
	private String schdlCn;
	private Date schdlBgngDt;
	private Date schdlEndDt;
	private String empId;
	private String schdlColor;
	private String schdlAllday;
	private int deptId;
	private String deptNm;
	
	private int curCalendarDeptId;
	
	private List<Employee> memberList;
	private List<String> memberIdList;
}
