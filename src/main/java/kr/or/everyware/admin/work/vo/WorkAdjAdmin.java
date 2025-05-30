package kr.or.everyware.admin.work.vo;

import kr.or.everyware.everyware.document.vo.Document;
import kr.or.everyware.everyware.work.vo.Work;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WorkAdjAdmin extends WorkAdminPaging<WorkAdjAdmin> {
	private int aprvSn;			// 근태조정번호
	private int workNo;			// 근무번호
	private String waBgngDt;	// 조정근무시작일시
	private String waEndDt;		// 조정근무종료일시
	private String waReason;	// 근태사유
	
	private String empId;		// 사원번호
	private String custId;		// 사원번호
	private Document document;	// 문서
	
}
