package kr.or.everyware.everyware.chat.vo;

import lombok.Data;

@Data
public class RealTimeLoginState {
	private String name;
	private String state;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "loginStateVO [name=" + name + ", state=" + state + "]";
	}
	
	
}
