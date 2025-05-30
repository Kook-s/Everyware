package kr.or.everyware.login.vo;

import lombok.Data;

@Data
public class AuthMenu {
	private int authrtId;
	private String menuId;
	
	private Menu menu; 
}
