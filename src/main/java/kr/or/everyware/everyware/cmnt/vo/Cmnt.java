package kr.or.everyware.everyware.cmnt.vo;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Cmnt  implements Comparable<Cmnt> {

	private int cmntId;
	private String empId;
	private int pstId;
	private String cmntCn;
	private LocalDate cmntDt;

	private String empName;
	private String empProfile;
	private String deptNm;
	private String jbgdNm;

	@Override
	public int compareTo(Cmnt other) {
		return Integer.compare(this.getCmntId(), other.getPstId());
	}
}