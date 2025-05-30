package kr.or.everyware.admin.approval.vo;

import lombok.Data;

@Data
public class ApprovalConfig {
	private String custId;
	private String likeCondition;
	
	private String agreeUseYn;
	private String preUseYn;
	private String dcrbUseYn;
	private String subUseYn;
	private String viewUseYn;
	private String refUseYn;
	private String agreeOrder;
	private String modifyer;
	private String modifyTime;
	private String retTime;
	private String shareUseYn;
	private String verifUseYn;
	private String numberingTime;
	private String numberingReg;
}
