package kr.or.everyware.util.attachment.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AttachFile {
	 private int atchFileNo;
	 private int atchFileSeq;
	 private int bizType;
	 private String filePath;
	 private String fileNm;
	 private long fileSz;
	 private String custId;
	 private Date fileCrtDt;
	 private String fileSavedNm;
	 private String fileType;
}
