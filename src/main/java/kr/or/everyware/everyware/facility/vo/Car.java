package kr.or.everyware.everyware.facility.vo;

import lombok.Data;

@Data
public class Car {
	private int carSn;
	private String vhrNo;
	private String carMdlNm;
	private int carYr;
	private int totalMile;
	private String fcltStts;
	private String custId;
	private String carDtlCn;
}
