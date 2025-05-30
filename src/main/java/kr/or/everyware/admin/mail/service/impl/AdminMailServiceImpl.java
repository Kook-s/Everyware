package kr.or.everyware.admin.mail.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.everyware.admin.mail.mapper.AdminMailMapper;
import kr.or.everyware.admin.mail.service.AdminMailService;
import kr.or.everyware.admin.mail.vo.MailPaging;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.everyware.contact.vo.Position;
import kr.or.everyware.everyware.mail.vo.EmailDetail;
import kr.or.everyware.everyware.mail.vo.MailList;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;

@Service
public class AdminMailServiceImpl implements AdminMailService{

	@Inject
	AdminMailMapper mapper;
	
	@Override
	public List<Department> getDeptList(String custId) {
		// TODO Auto-generated method stub
		return mapper.getDeptList(custId);
	}

	@Override
	public List<Position> getPosList(String custId) {
		// TODO Auto-generated method stub
		return mapper.getPosList(custId);
	}

	@Override
	public int selectMailCount(MailPaging<MailList> mailPaging) {
		// TODO Auto-generated method stub
		return mapper.selectMailCount(mailPaging);
	}

	@Override
	public List<MailList> selectMailList(MailPaging<MailList> mailPaging) {
		// TODO Auto-generated method stub
		return mapper.selectMailList(mailPaging);
	}

	@Override
	public EmailDetail getMailDetail(int emlId) {
		// TODO Auto-generated method stub
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
			Employee employee = customUser.getEmployee();
			System.out.println(emlId);
			EmailDetail emailDetail = mapper.getMailInfo(emlId);
			emailDetail.setEmpId(employee.getEmpId());
			List<AttachFile> fileList=null;
			if(emailDetail.getAtchFileNo()>0) {
				fileList = mapper.getMailFileList(emailDetail.getAtchFileNo());
			}
			emailDetail.setFileList(fileList);
			
			
			return emailDetail;
	}

}
