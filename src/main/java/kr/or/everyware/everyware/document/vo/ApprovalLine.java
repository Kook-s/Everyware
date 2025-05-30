package kr.or.everyware.everyware.document.vo;

import lombok.Data;

@Data
public class ApprovalLine {
	private int aprvLineSn;
	private int aprvSn;
	private String empId;
	private int aprvOrder;
	private String atrzDt;
	private String atrzOpnn;
	private int prgrsSttsCd;	// 상태 code
	private int aprvSeCd;
	private String dcrbYn;
	private String prslDt;
	
	private String empName;
	private String empProfile;
	private String jbgdNm;
	private String deptNm;
	private String cocoNm;
	
	private String subYn;
}
