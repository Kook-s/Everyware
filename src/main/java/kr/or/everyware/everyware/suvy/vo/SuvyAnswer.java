package kr.or.everyware.everyware.suvy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
// 설문답변
public class SuvyAnswer {
	public int saNo;		// 설문답변번호
	public int suvyNo;		// 설문번호
	public int siNo;		// 항목번호
	public String empId;	// 설문참여자
	public String saMemo;	// 비고
}
