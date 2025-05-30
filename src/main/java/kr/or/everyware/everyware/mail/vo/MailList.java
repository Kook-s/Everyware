package kr.or.everyware.everyware.mail.vo;

import java.util.Date;
import java.util.List;

import kr.or.everyware.login.vo.Employee;
import lombok.Data;

@Data
public class MailList {
	private String emlBookMark;
	private int emlId;
	private Date emlSndngDt;
	private String emlTtl;
	private int upEmlId;
	private int atchFileNo;
	private String senderId;
	private String senderName;
	private String senderMail;
	private String senderProfile;
	private String senderJbgdNm;
	private String senderDeptNm;
	private Date emlReadDt;
	
	private List<Employee> receiver;
}
