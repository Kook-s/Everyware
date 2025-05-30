package kr.or.everyware.admin.vacation.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class VacItem {
	private int viNo;		// 휴가항목번호 
	private String viType;	// 휴가구분
	private float viDay;		// 차감일수
	private String viMemo;	// 비고
	private String custId;	// 고객사 id
}
