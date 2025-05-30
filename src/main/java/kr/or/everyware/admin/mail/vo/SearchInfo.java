package kr.or.everyware.admin.mail.vo;

import lombok.Data;

@Data
public class SearchInfo {
	
	private int deptId;
	private int jbgdId;
	private String title;
	private String name;
	private String sdate;
	private String edate;
	private String isLately;
	private int page;
}
