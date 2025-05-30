package kr.or.everyware.login.vo;

import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AuthorityGroup {
	private String authrtId;
	private String authrtNm;
	private String custId;
	
	private List<AuthMenu> authMenuList;
}
