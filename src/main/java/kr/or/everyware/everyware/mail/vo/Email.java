package kr.or.everyware.everyware.mail.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;
import lombok.Data;

@Data
public class Email {
	 private int emlId;
	 private Date emlSndngDt;
	 private String emlCn;
	 private String emlTtl;
	 private int upEmlId;
	 private String emlTmprStrgYn;
	 private int atchFileNo;
	 
	 private Employee sender;
	 private List<Employee> receiver;
	 
	 private List<AttachFile> fileInfoList;
	 private List<MultipartFile> cFiles;
	 private List<String> fileType;
	 private List<String> cReceiver;
}
