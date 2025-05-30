package kr.or.everyware.everyware.document.status;

import lombok.Getter;

@Getter
public enum ApprovalStatus {
	DEFAULT(0, "기본값"),
	TEMP_SAVE(1, "임시저장"),
	RETRIEVED(2, "회수"),
	PENDING(3, "대기"),
    IN_PROGRESS(4, "진행"),
    APPROVED_PRELIMINARY(5, "승인(선결)"),
    APPROVED_FINAL(6, "승인(정상)"),
    REJECTED(7, "반려");
	
	private int code;
	private String status;

	ApprovalStatus(int code, String status) {
		this.code = code;
		this.status = status;
	}
}