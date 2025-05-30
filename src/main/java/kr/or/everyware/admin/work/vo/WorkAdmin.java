package kr.or.everyware.admin.work.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WorkAdmin extends WorkAdminPaging<WorkAdmin> {
	private int  workNo;		// 근무번호
	private String empId;		// 사원번호
	private String workDt;		// 근무일자
	private String workDw;		// 근무요일
	private String workBgngDt;	// 근무시작일시
	private String workEndDt;	// 근무종료일시
	private String workState;	// 근무상태
	
	private String custId;		// 고객사Id
	private String deptNm;		// 부서명
	private String jbgdNm;		// 직급명
}
