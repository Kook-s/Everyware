package kr.or.everyware.everyware.contact.status;

import lombok.Getter;

@Getter
public enum FolderType {
	IN_COMPANY(1, "사내주소록"),
    OUT_COMPANY(2, "사외주소록");
    
	private int code;
    private String status;

    FolderType(int code, String status) {
		this.code = code;
		this.status = status;
	}
}
