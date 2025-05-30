package kr.or.everyware.everyware.chat.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Chatroom {
	private int roomId;
	private String roomNm;
	private Date roomCrtDt;
	
	private List<ChatroomUser> chatroomUsers;
	private Message lastMessage;
	private int unreadCount;
	private String lastMessageEmpName;
	private List<Message> messageLogs;
}
