package kr.or.everyware.login.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.everyware.work.vo.Work;
import lombok.Data;

@Data
public class Employee {
	private String empId;
	private String empPw;
	private int deptId;
	private int jbgdId;
	private String empName;
	private String empBirth;
	private String empTel;
	private String empMail;
	private String empPost;
	private String empAddr1;
	private String empAddr2;
	private String empDate;
	private String empIdno;
	private int empVac;
	private String empProfile;
	private int groupNo;
	private String custId;
	private String empFid;
	
	private String jbgdNm;
	private String deptNm;
	private String conm;
	private int authrtId;
	private AuthorityGroup authorityGroup;
	private List<AuthMenu> authMenuList;

/*	private List<Department> departmentList;
	private List<Position> positionList;*/

	private Department department;
	private Position position; 
	private Work work; 
	private WorkGroup workGroup;
	private MultipartFile profileFile;
	private boolean passwordFlag;
}
