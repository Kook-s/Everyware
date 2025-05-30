package kr.or.everyware.login.vo;

import java.util.Collection;
import java.util.Collections;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUserClient extends User {

	private Client client;
	
	public CustomUserClient(String username, String password, Collection<GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUserClient(Client client) {
		
		super(client.getCustId(), client.getCustPw(),
				client.getAuthMenuList().stream()
				.map(menu_auth -> new SimpleGrantedAuthority(menu_auth.getMenuId())).collect(Collectors.toList()));
		this.client = client;
	}
	
	public Client getClient() {
		return client;
	}
	public void setClient(Client client) {
		this.client=client;
	}
}
