package kr.or.everyware.everyware.document.status;

import lombok.Getter;

@Getter
public enum ApprovalLineStatus {
	DEFAULT(0, "기본값"),
	SCHEDULED(1, "예정"),
    PENDING(2, "대기"),
    APPROVED(3, "승인"),
    REJECTED(4, "반려"),
    POST_APPROVAL_PENDING(5, "후결대기"),
    DELEGATED_PRELIMINARY(6, "대결위임"),
    DELEGATED_FINAL(7, "전결위임");
    
	private int code;
    private String status;

	ApprovalLineStatus(int code, String status) {
		this.code = code;
		this.status = status;
	}
}
