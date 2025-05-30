package kr.or.everyware.everysolution.vo;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Product {

	private int pdt_id;
	private String pdtNm;
	private int dftPrice;
	private int dftPerson;
	private int addPrice;
	private int addFileSz;
	private int addCldSz;
	private int addDftPerson;

}
