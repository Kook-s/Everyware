package kr.or.everyware.everyware.chat.vo;

import java.util.Date;

import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;
import lombok.Data;

@Data
public class Message {
	private int msgId;
	private String msgCn;
	private Date msgCrtDt;
	private int msgType;
	private int roomId;
	private String empId;
	private int atchFileNo;
	
	private String roomNm;
	private Employee employee;
}
