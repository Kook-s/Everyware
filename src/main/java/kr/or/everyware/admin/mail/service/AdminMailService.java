package kr.or.everyware.admin.mail.service;

import java.util.List;

import kr.or.everyware.admin.mail.vo.MailPaging;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.everyware.mail.vo.EmailDetail;
import kr.or.everyware.everyware.mail.vo.MailList;

public interface AdminMailService {

	List<Department> getDeptList(String custId);

	List<Position> getPosList(String custId);

	int selectMailCount(MailPaging<MailList> mailPaging);

	List<MailList> selectMailList(MailPaging<MailList> mailPaging);

	EmailDetail getMailDetail(int emlId);

}
