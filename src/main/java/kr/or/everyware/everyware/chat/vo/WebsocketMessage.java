package kr.or.everyware.everyware.chat.vo;

import java.util.Set;

import kr.or.everyware.login.vo.Employee;
import lombok.Data;

@Data
public class WebsocketMessage {
	private String content;
	private String sender;
	private String room;
	private String state;
	private String type;
	private String[] reciever;
	private Set<String> loginUsers;
	private int unreadCount;
	private int messageId;
	
	private Alarm alarm;
	private Employee employee;
	private Message message;
	private Chatroom chatroom;
	
}
