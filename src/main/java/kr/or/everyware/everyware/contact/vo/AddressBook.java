package kr.or.everyware.everyware.contact.vo;

import kr.or.everyware.util.toExcel.ExcelFieldName;
import kr.or.everyware.util.toExcel.ExcelFileName;
import lombok.Data;

@Data
@ExcelFileName(value = "주소록")
public class AddressBook {
	private int contactSn;
	private String empId;
	private int folSn;
	@ExcelFieldName(value = "소속", order = 1)
	private String ogdpInstNm;
	@ExcelFieldName(value = "이름", order = 2)
	private String name;
	private String alias;
	@ExcelFieldName(value = "전화번호", order = 4)
	private String telno1;
	private String telno2;
	@ExcelFieldName(value = "이메일", order = 3)
	private String emlAddr;
	private String bookmarkYn;
}
