package kr.or.everyware.admin.chat.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ChatLog {
	private String roomNm;
	private String empName;
	private String empProfile;
	private String msgCn;
	private Date msgCrtDt;
	private int msgId;
	private int msgType;
	private String empId;
	private int roomId;
	
}
