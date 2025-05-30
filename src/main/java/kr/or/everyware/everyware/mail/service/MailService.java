package kr.or.everyware.everyware.mail.service;

import java.util.List;
import java.util.Map;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.mail.vo.BrowserPaging;
import kr.or.everyware.everyware.mail.vo.Email;
import kr.or.everyware.everyware.mail.vo.EmailDetail;
import kr.or.everyware.everyware.mail.vo.MailList;
import kr.or.everyware.everyware.mail.vo.MailPaging;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;

public interface MailService {

	List<Employee> getProfileList(Employee employee);

	ServiceResult sendMail(Email mail);

	int selectMailCount(MailPaging<MailList> mailPaging);


	List<MailList> selectMailList(MailPaging<MailList> mailPaging);

	int selectUnreadMailCount(String empId);

	int modifyMailBookMark(Map<String, Object> map);

	void getMailTotal(MailPaging<MailList> mailPaging);

	EmailDetail getMailDetail(int parseInt);

	AttachFile getAttachFile(AttachFile attachFile);

	ServiceResult readMail(Map<String, Object> map);

	Email getMail(Map<String, Object> map);

	ServiceResult mailToTrash(Map<String, Object> map);

	ServiceResult mailToRetrieve(Map<String, Object> map);

	ServiceResult mailToErase(Map<String, Object> map);

	ServiceResult tempMail(Email mail);





}
