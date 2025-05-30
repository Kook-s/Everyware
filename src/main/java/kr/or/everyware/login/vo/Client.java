package kr.or.everyware.login.vo;

import java.util.List;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Client {
	private String custId;
	private String custPw;
	private String conm;
	private String bplcNm;
	private String brno;
	private String bplcZip;
	private String bplcAddr;	
	private String bplcDaddr;
	private String bplcTelno;
	private String picNm;
	private String picTelno;
	private String enabled;
	private String auth;
	private boolean passwordFlag;
	
	private List<AuthMenu> authMenuList;
}
