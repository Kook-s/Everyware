package kr.or.everyware.admin.chat.vo;

import lombok.Data;

@Data
public class SearchInfo {
	private String roomName;
	private String sender;
	private String sdate;
	private String edate;
	private String content;
	private String isLately;
	private int page;
	private String fileName;
}
