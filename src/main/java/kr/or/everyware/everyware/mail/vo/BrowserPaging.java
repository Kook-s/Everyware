package kr.or.everyware.everyware.mail.vo;

import lombok.Data;

@Data
public class BrowserPaging {
	private String menuName;
	private int page;
	private String searchKeyword;
	private String isLately;
	private boolean bookMark;
	private boolean attachment;
}
