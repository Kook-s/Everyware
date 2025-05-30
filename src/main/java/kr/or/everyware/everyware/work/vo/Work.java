package kr.or.everyware.everyware.work.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Work {
	private int  workNo;		// 근무번호
	private String empId;		// 사원번호
	private String workDt;		// 근무일자
	private String workDw;		// 근무요일
	private String workBgngDt;	// 근무시작일시
	private String workEndDt;	// 근무종료일시
	private String workState;	// 근무상태
	
	private String custId;		// 고객사Id
	private int page;
	
	// 검색
	private String searchStartDate;	// 검색 시작날짜 
	private String searchEndDate;	// 검색 끝날짜
	private String searchState; 	// 검색 상태
	
	// 사원현황
	private int totalWork;		// 사원의 근태 전체건수
	private int totalNormal;	// 사원의 근태 정상건수
	private int totalExtension;	// 사원의 근태 연장건수 
	private int totalLateness;	// 사원의 근태 지각건수
	private int totalLeaveEarly;// 사원의 근태 조퇴건수
	private int totalVacation;	// 사원의 휴가 건수
	
	private List<String> idList;			//주소록으로 선택된 대상자들 아이디리스트
	
	public Work() {}

}
