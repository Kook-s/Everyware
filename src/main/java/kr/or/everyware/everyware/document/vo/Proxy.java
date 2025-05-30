package kr.or.everyware.everyware.document.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Proxy {
	private int proxyId;
	private String empId;
	private String agtId;
	private String bgngDt;
	private String endDt;
	private String reason;
	private String stngYmd;
	
	private String empName;
}
