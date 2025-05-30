package kr.or.everyware.admin.workYear.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WorkYear {
	private int wyNo;		// 근속연속번호
	private String custId;	// 고객사id	
	private int wyYear;		// 근속연수
	private int wyHldy;		// 휴가일수
	private String wyMemo;	// 비고
	private int rownum;		// 행번호
}
