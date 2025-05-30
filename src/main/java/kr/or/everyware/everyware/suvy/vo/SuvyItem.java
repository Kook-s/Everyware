package kr.or.everyware.everyware.suvy.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
// 설문항목
public class SuvyItem {
	public int siNo;		// 항목번호
	public int suvyNo;		// 설문번호
	public String siCn;		// 항목내용 
	public int atchFileNo;	// 통합첨부파일번호
	public int count;
}
