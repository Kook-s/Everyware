package kr.or.everyware.everyware.facility.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Reservation {
	private int rsvtNo;
	private int carSn;
	private String empId;
	private Date rcptDt;
	private Date rsvtDt;
	private String custId;
}
