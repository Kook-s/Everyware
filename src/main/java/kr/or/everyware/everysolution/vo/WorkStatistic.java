package kr.or.everyware.everysolution.vo;

import lombok.Data;

@Data
public class WorkStatistic {
	private String workDate;
	private int normalCount;
	private int abnormalCount;
}
