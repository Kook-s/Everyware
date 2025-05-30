package kr.or.everyware.everyware.document.vo;

import lombok.Data;

@Data
public class Template {
	private int tmpltCd;
	private String tmpltNm;
	private String tmpltCn;
	private String useYn;
	
	private String icon;
	private String backgroundColor;
	
	private String serviceClassNm;
	private String itemMethodNm;
}
