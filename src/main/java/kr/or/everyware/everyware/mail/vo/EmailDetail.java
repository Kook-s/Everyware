package kr.or.everyware.everyware.mail.vo;

import java.util.Date;
import java.util.List;

import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;
import lombok.Data;

@Data
public class EmailDetail {
	 private int emlId;
	 private Date emlSndngDt;
	 private String emlCn;
	 private String emlTtl;
	 private int upEmlId;
	 private String emlTmprStrgYn;
	 private int atchFileNo;
	 
	 private String empId;
	 
	 private Employee sender;
	 private List<Employee> receiver;
	 
	 private List<AttachFile> fileList;
	 private List<MailList> replyList;
}
