package kr.or.everyware.everyware.vacation.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Vacation {
	private int aprvSn;
	private String empId;
	private String vacBgngDt;
	private String vacEndDt;
	private String vacReason;
	
	private int viNo;
	private String viType;
	private double viDay;
	private String viMemo;
	private String custId;
	
	private double restVacDay;
}
