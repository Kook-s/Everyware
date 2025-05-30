package kr.or.everyware.everyware.facility.vo;

import java.util.Date;

import lombok.Data;

@Data
public class DrivingRecord {
	private int drvRecSn;
	private int carSn;
	private String empId;
	private Date useDt;
	private int bfrMile;
	private int aftrMile;
	private int drvMile;
	private int comtMile;
	private int workMile;
	private String rmrkCn;
	private String custId;
}
