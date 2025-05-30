package kr.or.everyware.everyware.todo.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Todo {
	private int tdNo;			// todo번호
	private String empId;		// 사원번호
	private String tdTtl;	// todo 제목	
	private String tdCn;		// todo 내용
	private String tdState;	// todo 상태
	
}
