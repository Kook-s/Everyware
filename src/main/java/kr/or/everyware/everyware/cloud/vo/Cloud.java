package kr.or.everyware.everyware.cloud.vo;

import lombok.Data;

@Data
public class Cloud {

	private String cldNm;            // 이름      
	private String cldPath;          // 이름 제외 경로
	private String cldTotalNm;       //이름.형식    
	private String cldTotalPath;     // 전체 경로   
	private String cldType;          // 형식	   
	private long cldSize;            // 사이즈     
}
