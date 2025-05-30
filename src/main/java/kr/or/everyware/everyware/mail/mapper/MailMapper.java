package kr.or.everyware.everyware.mail.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.mail.vo.Email;
import kr.or.everyware.everyware.mail.vo.EmailDetail;
import kr.or.everyware.everyware.mail.vo.MailList;
import kr.or.everyware.everyware.mail.vo.MailPaging;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;

@Mapper
public interface MailMapper {

	List<Employee> getProfileList(Employee employee);

	int insertEmail(Email mail);

	int insertAttachAndGetKey(AttachFile firstAttachFile);

	int insertAttach(AttachFile attachFile);

	void insertMailSender(Map<String, Object> map);

	void insertMailReceiver(Map<String, Object> map);

	int selectMailCount(MailPaging<MailList> mailPaging);

	List<MailList> selectMailList(MailPaging<MailList> mailPaging);

	int selectUnreadMailCount(String empId);

	int modifyMailBookMark(Map<String, Object> map);

	int getSendTotal(String empId);

	int receiveTotal(String empId);

	int tempTotal(String empId);

	int sendTrash(String empId);

	int receiveTrash(String empId);


	EmailDetail getMailInfo(int emlId);

	List<AttachFile> getMailFileList(int atchFileNo);

	List<MailList> getReplyMailList(EmailDetail emailDetail);

	AttachFile getAttachFile(AttachFile attachFile);

	int readMail(Map<String, Object> map);

	Email getMail(Map<String, Object> map);

	int mailToTrash(Map<String, Object> tempMap);

	int mailToRetrieve(Map<String, Object> tempMap);

	int mailToErase(Map<String, Object> tempMap);


	

}
