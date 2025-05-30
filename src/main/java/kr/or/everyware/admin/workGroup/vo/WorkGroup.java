package kr.or.everyware.admin.workGroup.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WorkGroup {
	private int groupNo;
	private String custId;
	private String groupNm;
	private String groupWorkBgngDt;
	private String groupWorkEndDt;
	private String groupRestBgngDt;
	private String groupRestEndDt;
	
	private int headCount;
}
