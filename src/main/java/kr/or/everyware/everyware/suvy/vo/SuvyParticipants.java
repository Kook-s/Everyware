package kr.or.everyware.everyware.suvy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
// 설문 참여자
public class SuvyParticipants {
	public int suvyNo;		// 설문번호
	public String empId;	// 설문참여자
	private String partYn;
}
