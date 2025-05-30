package kr.or.everyware.login.vo;

import java.util.Date;

import lombok.Data;

@Data
public class LoginLog {
	private int logId;
	private Date lgnDt;
	private String lgnIpAddr;
	private String lgnDeptNm;
	private String lgnBro;
	private String empId;
	private String lgnArea;
}
