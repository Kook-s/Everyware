package kr.or.everyware.everyware.board.vo;

import lombok.Data;
import java.time.LocalDate;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.util.attachment.vo.AttachFile;

@Data
public class Board implements Comparable<Board> {
	private int pstId;
	private String pstTtl;
	private String pstCn;
	private LocalDate pstgBgngDt;
	private int pstCnt;
	private String empId;
	private String ctgryNo;
	private String ctgryNM;
	private int atchFileNo;
	private List<AttachFile> fileInfoList;
	private MultipartFile file;

	@Override
	public int compareTo(Board other) {
		return Integer.compare(this.getPstId(), other.getPstId());
	}

}
