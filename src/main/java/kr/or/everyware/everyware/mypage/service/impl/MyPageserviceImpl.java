package kr.or.everyware.everyware.mypage.service.impl;


import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.mypage.mapper.MyPageMapper;
import kr.or.everyware.everyware.mypage.service.MyPageservice;
import kr.or.everyware.everyware.mypage.vo.MyPage;
import kr.or.everyware.login.mapper.LoginMapper;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.login.vo.LoginLog;
import kr.or.everyware.util.fileUtils.UploadFileUtils;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MyPageserviceImpl implements MyPageservice {

	
	@Inject
	LoginMapper mapper;
	
	@Resource(name="uploadPath")
	private String resourcesPath;
	
	@Override
	public int updateMyPage(Employee emp) {
		log.info("updateMyPage");
		return mapper.updateMyPage(emp);
	}

	@Override
	public Employee getEmp(Employee emp) {
		// TODO Auto-generated method stub
		return mapper.getEmp(emp);
	}

	@Override
	public ServiceResult updateEmployee(Employee emp) {
		// TODO Auto-generated method stub
		MultipartFile file = emp.getProfileFile();
		if(file!=null) {
			try {
				String uploadFile = UploadFileUtils.uploadFile(resourcesPath, file.getOriginalFilename(), file.getBytes());
				emp.setEmpProfile(uploadFile);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ServiceResult.getExecutionResult(mapper.updateEmployee(emp));
	}

	@Override
	public Employee readByEmployeeId(String empId) {
		// TODO Auto-generated method stub
		return mapper.readByEmployeeId(empId);
	}

	@Override
	public Employee getEmployee(String empId) {
		// TODO Auto-generated method stub
		return mapper.getEmployee(empId);
	}

	@Override
	public List<LoginLog> getIpList(String empId) {
		// TODO Auto-generated method stub
		return mapper.getIpList(empId);
	}




}
