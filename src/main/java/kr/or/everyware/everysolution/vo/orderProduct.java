package kr.or.everyware.everysolution.vo;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class orderProduct {

	private int ordrId;
	private String ordrDt;
	private String custId;
	private int pdtId;
	private String ordrBgngDt;
	private String ordrEndDt;
	private int ordrAmt;
	private int ordrPerson;

}
