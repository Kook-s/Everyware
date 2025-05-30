package kr.or.everyware.everyware.suvy.vo;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@JsonAutoDetect
// 설문
public class Suvy extends SuvyPaging<Suvy> {
	// Suvy
	private int suvyNo;				// 설문번호
	private int siNo;				// 항목번호
	private int saNo;				// 답변번호
	
	private int page;
	
	private String empId;			// 설문작성자
	private String empName;
	private String suvyTtl;			// 설문제목
	private String suvyCn;			// 설문내용
	private String suvyDt;			// 설문작성일
	
	private String partYn;			// 참여 여부
	
	private String subject;
	
	private String suvyBgngDt;		// 설문시작일시
	private String suvyEndDt;		// 설문종료일시
	private int suvyState;			// 설문진행상태코드
	private String suvySigned;		// 익명여부	Y:익명, N:
	private String suvyDuplicate;	// 다중선택여부 Y:다중선택, N:
	
	private List<SuvyItem> suvyItemList;		// 설문항목리스트
//	private List<SuvyAnswer> suvyAnswerList;	// 설문답변리스트
	private List<String> idList;			//주소록으로 선택된 대상자들 아이디리스트
	
	private List<Integer> siNoList;			//내가 이 설문에서 찍은것들을 sino만 추려낸 리스트
	
	private List<SuvyAnswer> answers;		//내가답한 답변목록
	  private String sdate;
	  private String edate;
}
