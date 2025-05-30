package kr.or.everyware.everyware.contact.vo;

import java.util.List;

import kr.or.everyware.login.vo.Employee;
import lombok.Data;

@Data
public class Folder {
	private int folSn;
	private String empId;
	private int upFolSn;
	private String folNm;
	private List<Folder> folders;
	private int addrBookCd;
	private int depth;
	private List<Employee> contacts;
	
	public void calculateDepth() {
		 calculateDepth(this, 0);
	}
	
	private void calculateDepth(Folder folder, int depth) {
        folder.setDepth(depth);
        for (Folder subFolder : folder.getFolders()) {
            calculateDepth(subFolder, depth + 1);
        }
    }
}
