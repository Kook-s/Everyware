package kr.or.everyware.everyware.document.vo;

import java.util.List;

import kr.or.everyware.admin.approval.vo.ApprovalConfig;
import kr.or.everyware.everyware.contact.vo.Department;
import lombok.Data;

@Data
public class Document {
	private int aprvSn;
	private String aprvNo;
	private int tmpltCd;
	private String clsfNm;
	private String tmpltNm;
	private String custId;
	private String empId;
	private String atrzDmndDt;
	private String atrzCmptnDt;
	private String aprvTtl;
	private String aprvCn;
	private String prgrsSttsCd;  // 문서 현재 상태(enum)
	
	private Template template;
	private ApprovalConfig config;
	
	private String empName;
	private int deptId;
	private String deptNm;
	private String conm;
	
	private String currentEmpId;
	private List<ApprovalLine> myPermission;
	
	private int scrapSn;
	private String dlvrId;
	
	private List<ApprovalLine> approvalLine;
	private List<ApprovalLine> viewers;
	private List<Department> destinations;
	
	// 검색조건
	private String dmndStartDate;
	private String dmndEndDate;
	
	// 후처리용 JSON Object
	private String jsonObject;
}
