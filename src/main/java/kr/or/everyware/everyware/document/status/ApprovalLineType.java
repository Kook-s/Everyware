package kr.or.everyware.everyware.document.status;

import lombok.Getter;

@Getter
public enum ApprovalLineType {
	DEFAULT(0, "기본값"),
	NORMAL(1, "정상"),
    SUBSTITUTE(2, "대결"),
    CONSENSUS(3, "합의"),
    REFERENCE(4, "참조"),
    VIEW(5, "열람");
	
	private int code;
	private String type;
	
	ApprovalLineType(int code, String type) {
		this.code = code;
		this.type = type;
	}
	
	public static ApprovalLineType valueOfCode(int code) {
        for (ApprovalLineType type : values()) {
            if (type.code == code) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid ApprovalLineType code: " + code);
    }
}