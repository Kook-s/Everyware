package kr.or.everyware.admin.mail.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.mail.vo.MailPaging;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.everyware.mail.vo.EmailDetail;
import kr.or.everyware.everyware.mail.vo.MailList;
import kr.or.everyware.util.attachment.vo.AttachFile;

@Mapper
public interface AdminMailMapper {

	List<Department> getDeptList(String custId);

	List<Position> getPosList(String custId);

	int selectMailCount(MailPaging<MailList> mailPaging);

	List<MailList> selectMailList(MailPaging<MailList> mailPaging);

	EmailDetail getMailInfo(int emlId);

	List<AttachFile> getMailFileList(int atchFileNo);

}
