package kr.or.everyware.admin.chat.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ImgChatLog {
	private int msgId;
	private Date msgCrtDt;
	private int roomId;
	private String empId;
	private String empName;
	private String atchFileNo;
	private String atchFileSeq;
	private String fileNm;
	private String fileSz;
	private String roomNm;
}
