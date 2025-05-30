package kr.or.everyware.everyware.chat.vo;

import java.util.Date;
import java.util.List;

import kr.or.everyware.login.vo.Employee;
import lombok.Data;

@Data
public class Alarm {
	private int alarmId;
	private String sndrNm;
	private int alarmType;
	private String urlAddr;
	private String empId;
	private List<String> empIdList;
	private Date crtDt;
	
	private String custId;
	private int deptId;
	
	private String type;
	
	private Employee sender;
	private Employee receiver;
}
