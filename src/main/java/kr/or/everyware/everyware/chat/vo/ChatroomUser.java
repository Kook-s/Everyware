package kr.or.everyware.everyware.chat.vo;

import kr.or.everyware.login.vo.Employee;
import lombok.Data;

@Data
public class ChatroomUser {
	private int roomId;
	private String empId;
	private String lastReadMsgId;
	
	private Employee employee;
}
