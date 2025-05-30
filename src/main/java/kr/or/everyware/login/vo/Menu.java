package kr.or.everyware.login.vo;

import lombok.Data;

@Data
public class Menu {
	private String menuId;
	private String upMenuId;
	private String menuSe;
	private String menuNm;
	private String useYn;
	private int menuOrd;
	private String menuUrl;
	private String menuIcon;
}
