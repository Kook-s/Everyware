package kr.or.everyware.everyware.facility.status;

import lombok.Getter;

@Getter
public enum FacilityStatus {
	AVAILABLE(1, "정상"),
	REPAIR(2, "수리"),
    UNAVAILABLE(3, "사용불가"),
    REMOVED(4, "삭제");
	
	private int code;
	private String status;
	
	FacilityStatus(int code, String status) {
		this.code = code;
		this.status = status;
	}
}