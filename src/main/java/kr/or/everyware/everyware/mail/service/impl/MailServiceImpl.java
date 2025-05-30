package kr.or.everyware.everyware.mail.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.mail.mapper.MailMapper;
import kr.or.everyware.everyware.mail.service.MailService;
import kr.or.everyware.everyware.mail.vo.Email;
import kr.or.everyware.everyware.mail.vo.EmailDetail;
import kr.or.everyware.everyware.mail.vo.MailList;
import kr.or.everyware.everyware.mail.vo.MailPaging;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.AttachFileValidate;
import kr.or.everyware.util.attachment.vo.AttachFile;
import kr.or.everyware.util.fileUtils.UploadFileUtils;

@Service
public class MailServiceImpl implements MailService {

	@Inject
	MailMapper mapper;

	@Resource(name = "uploadPath")
	private String resourcePath;

	@Override
	public List<Employee> getProfileList(Employee employee) {
		// TODO Auto-generated method stub
		return mapper.getProfileList(employee);
	}

	@Inject
	AttachFileValidate attachService;

	@Override
	public ServiceResult sendMail(Email mail) {
		System.out.println("들어옴");
		ServiceResult result = null;
		String custId = mail.getSender().getCustId();
		if(mail.getCFiles()!=null && mail.getCFiles().size()>0) {
			if (ServiceResult.FAILED.equals(attachService.validate(custId, mail.getCFiles()))) {
				return ServiceResult.NOTEXIST;
			}
		}
		int res = 0;
		try {
			List<MultipartFile> cFiles = mail.getCFiles();
			AttachFile firstAttachFile = null;
			AttachFile attachFileRef =null;
			List<AttachFile> fileInfo = mail.getFileInfoList();
			System.out.println("인포리스트: "+fileInfo);
			int seq=1;
			if(fileInfo!=null) {
				seq=fileInfo.size()+1;
			}
			
			if (cFiles != null && cFiles.size() > 0) {

				MultipartFile file = cFiles.get(0);
				String realSavedName;

				realSavedName = UploadFileUtils.uploadFile(resourcePath, file.getOriginalFilename(), file.getBytes());
				firstAttachFile = new AttachFile();
				firstAttachFile.setAtchFileSeq(seq);
				firstAttachFile.setBizType(2);
				firstAttachFile.setFileNm(file.getOriginalFilename());
				firstAttachFile.setFileSz(file.getSize());
				firstAttachFile.setCustId(custId);
				firstAttachFile.setFilePath(resourcePath);
				firstAttachFile.setFileSavedNm(realSavedName);
				firstAttachFile.setFileType(mail.getFileType().get(0));

				res = mapper.insertAttachAndGetKey(firstAttachFile);

				if (res > 0) {
					for (int i = 1; i < cFiles.size(); i++) {
						MultipartFile file2 = cFiles.get(i);
						String realSavedName2 = UploadFileUtils.uploadFile(resourcePath, file2.getOriginalFilename(), file2.getBytes());
						AttachFile attachFile = new AttachFile();
						attachFile.setAtchFileNo(firstAttachFile.getAtchFileNo());
						attachFile.setAtchFileSeq(seq + i);
						attachFile.setBizType(2);
						attachFile.setFileNm(file2.getOriginalFilename());
						attachFile.setFileSz(file2.getSize());
						attachFile.setCustId(custId);
						attachFile.setFilePath(resourcePath);
						attachFile.setFileSavedNm(realSavedName2);
						attachFile.setFileType(mail.getFileType().get(i));
						res = mapper.insertAttach(attachFile);
						if (res == 0) {
							result = ServiceResult.FAILED;
						}
					}
				}

			}
			if(fileInfo!=null && fileInfo.size()>0) {
				System.out.println("파일인포 분기");
				if(firstAttachFile!=null) {
					System.out.println("파일인포 널분기");
					for (int i=0; i<fileInfo.size(); i++) {
						AttachFile obj = fileInfo.get(i);
						obj.setAtchFileNo(firstAttachFile.getAtchFileNo());
						obj.setAtchFileSeq(i+1);
						obj.setBizType(2);
						obj.setCustId(custId);
						res=mapper.insertAttach(obj);
						
					}
				}else {
					System.out.println("파일인포 else분기");
					attachFileRef= new AttachFile();
					attachFileRef.setAtchFileSeq(1);
					attachFileRef.setBizType(2);
					attachFileRef.setFileNm(fileInfo.get(0).getFileNm());
					attachFileRef.setFileSz(fileInfo.get(0).getFileSz());
					attachFileRef.setCustId(custId);
					attachFileRef.setFilePath(resourcePath);
					attachFileRef.setFileSavedNm(fileInfo.get(0).getFileSavedNm());
					attachFileRef.setFileType(fileInfo.get(0).getFileType());
					res = mapper.insertAttachAndGetKey(attachFileRef);
					if (res > 0) {
						for (int i = 1; i < fileInfo.size(); i++) {
							
							AttachFile attachFile = new AttachFile();
							attachFile.setAtchFileNo(attachFileRef.getAtchFileNo());
							attachFile.setAtchFileSeq(1 + i);
							attachFile.setBizType(2);
							attachFile.setFileNm(fileInfo.get(i).getFileNm());
							attachFile.setFileSz(fileInfo.get(i).getFileSz());
							attachFile.setCustId(custId);
							attachFile.setFilePath(fileInfo.get(i).getFilePath());
							attachFile.setFileSavedNm(fileInfo.get(i).getFileSavedNm());
							attachFile.setFileType(fileInfo.get(i).getFileType());
							res = mapper.insertAttach(attachFile);
							if (res == 0) {
								result = ServiceResult.FAILED;
							}
						}
					}
					
				}
			}

			if (result != ServiceResult.FAILED) {
				mail.setEmlSndngDt(new Date());// 예약기능 만들시 이부분 변경
				if (firstAttachFile != null && firstAttachFile.getAtchFileNo() != 0) {
					mail.setAtchFileNo(firstAttachFile.getAtchFileNo());
				}else if(attachFileRef != null && attachFileRef.getAtchFileNo() != 0) {
					mail.setAtchFileNo(attachFileRef.getAtchFileNo());
				}
				res = mapper.insertEmail(mail);
				Map<String, Object> map = new HashedMap();
				map.put("empId", mail.getSender().getEmpId());
				map.put("emlId", mail.getEmlId());
				mapper.insertMailSender(map);
				List<String> receiverList = mail.getCReceiver();
				if(receiverList!=null) {
					for (String receiver : receiverList) {
						Map<String, Object> map2 = new HashedMap();
						map2.put("empId", receiver);
						map2.put("emlId", mail.getEmlId());
						mapper.insertMailReceiver(map2);
					}
				}
			}

			if (res > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
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
	public int selectUnreadMailCount(String empId) {
		// TODO Auto-generated method stub
		return mapper.selectUnreadMailCount(empId);
	}

	@Override
	public int modifyMailBookMark(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.modifyMailBookMark(map);
	}

	@Override
	public void getMailTotal(MailPaging<MailList> mailPaging) {
		// TODO Auto-generated method stub
		String empId = mailPaging.getEmpId();

		int sendTotal = mapper.getSendTotal(empId);
		int receiveTotal = mapper.receiveTotal(empId);
		int tempTotal = mapper.tempTotal(empId);
		int sendTrash = mapper.sendTrash(empId);
		int receiveTrash = mapper.receiveTrash(empId);
		int trashTotal = sendTrash + receiveTrash;
		int allTotal = sendTotal + receiveTotal;

		mailPaging.setSendTotal(sendTotal);
		mailPaging.setReceiveTotal(receiveTotal);
		mailPaging.setAllTotal(allTotal);
		mailPaging.setTempTotal(tempTotal);
		mailPaging.setTrashTotal(trashTotal);
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
		
		List<MailList> replyList = mapper.getReplyMailList(emailDetail);
		emailDetail.setReplyList(replyList);
		
		return emailDetail;
	}

	@Override
	public AttachFile getAttachFile(AttachFile attachFile) {
		// TODO Auto-generated method stub
		return mapper.getAttachFile(attachFile);
	}



	@Override
	public ServiceResult readMail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		return ServiceResult.getExecutionResult(mapper.readMail(map));
	}



	@Override
	public Email getMail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return mapper.getMail(map);
	}



	@Override
	public ServiceResult mailToTrash(Map<String, Object> map) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		map.put("empId", employee.getEmpId());
		List<Object> emlIdList = (List<Object>)map.get("emlIdList");
		List<Object> typeList = (List<Object>)map.get("typeList");
		int size=emlIdList.size();
		
		int res=0;
		for (int i=0; i<emlIdList.size(); i++) {
			Map<String, Object> tempMap = new HashMap<String, Object>();
			tempMap.put("empId", employee.getEmpId());
			tempMap.put("emlId", emlIdList.get(i));
			tempMap.put("type", typeList.get(i));
			res += mapper.mailToTrash(tempMap);
		}
		
		System.out.println("res"+res);
		System.out.println("size"+size);
		if(size==res) {
			return ServiceResult.OK;
		}else {
			return ServiceResult.FAILED;
		}
	}



	@Override
	public ServiceResult mailToRetrieve(Map<String, Object> map) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		map.put("empId", employee.getEmpId());
		List<Object> emlIdList = (List<Object>)map.get("emlIdList");
		List<Object> typeList = (List<Object>)map.get("typeList");
		int size=emlIdList.size();
		
		int res=0;
		for (int i=0; i<emlIdList.size(); i++) {
			Map<String, Object> tempMap = new HashMap<String, Object>();
			tempMap.put("empId", employee.getEmpId());
			tempMap.put("emlId", emlIdList.get(i));
			tempMap.put("type", typeList.get(i));
			res += mapper.mailToRetrieve(tempMap);
		}
		
		System.out.println("res"+res);
		System.out.println("size"+size);
		if(size==res) {
			return ServiceResult.OK;
		}else {
			return ServiceResult.FAILED;
		}
	}



	@Override
	public ServiceResult mailToErase(Map<String, Object> map) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		map.put("empId", employee.getEmpId());
		List<Object> emlIdList = (List<Object>)map.get("emlIdList");
		List<Object> typeList = (List<Object>)map.get("typeList");
		int size=emlIdList.size();
		
		int res=0;
		for (int i=0; i<emlIdList.size(); i++) {
			Map<String, Object> tempMap = new HashMap<String, Object>();
			tempMap.put("empId", employee.getEmpId());
			tempMap.put("emlId", emlIdList.get(i));
			tempMap.put("type", typeList.get(i));
			res += mapper.mailToErase(tempMap);
		}
		
		System.out.println("res"+res);
		System.out.println("size"+size);
		if(size==res) {
			return ServiceResult.OK;
		}else {
			return ServiceResult.FAILED;
		}
	}

	
	
	
	@Override
	public ServiceResult tempMail(Email mail) {
		System.out.println("들어옴");
		ServiceResult result = null;
		String custId = mail.getSender().getCustId();
		if(mail.getCFiles()!=null && mail.getCFiles().size()>0) {
			if (ServiceResult.FAILED.equals(attachService.validate(custId, mail.getCFiles()))) {
				return ServiceResult.NOTEXIST;
			}
		}
		int res = 0;
		try {
			List<MultipartFile> cFiles = mail.getCFiles();
			AttachFile firstAttachFile = null;
			if (cFiles != null && cFiles.size() > 0) {

				MultipartFile file = cFiles.get(0);
				String realSavedName;

				realSavedName = UploadFileUtils.uploadFile(resourcePath, file.getOriginalFilename(), file.getBytes());
				firstAttachFile = new AttachFile();
				firstAttachFile.setAtchFileSeq(1);
				firstAttachFile.setBizType(2);
				firstAttachFile.setFileNm(file.getOriginalFilename());
				firstAttachFile.setFileSz(file.getSize());
				firstAttachFile.setCustId(custId);
				firstAttachFile.setFilePath(resourcePath);
				firstAttachFile.setFileSavedNm(realSavedName);

				res = mapper.insertAttachAndGetKey(firstAttachFile);

				if (res > 0) {
					for (int i = 1; i < cFiles.size(); i++) {
						MultipartFile file2 = cFiles.get(i);
						String realSavedName2 = UploadFileUtils.uploadFile(resourcePath, file2.getOriginalFilename(), file2.getBytes());
						AttachFile attachFile = new AttachFile();
						attachFile.setAtchFileNo(firstAttachFile.getAtchFileNo());
						attachFile.setAtchFileSeq(i + 1);
						attachFile.setBizType(2);
						attachFile.setFileNm(file2.getOriginalFilename());
						attachFile.setFileSz(file2.getSize());
						attachFile.setCustId(custId);
						attachFile.setFilePath(resourcePath);
						attachFile.setFileSavedNm(realSavedName2);
						res = mapper.insertAttach(attachFile);
						if (res == 0) {
							result = ServiceResult.FAILED;
						}
					}
				}

			}

			if (result != ServiceResult.FAILED) {
				mail.setEmlSndngDt(new Date());// 예약기능 만들시 이부분 변경
				if (firstAttachFile != null && firstAttachFile.getAtchFileNo() != 0) {
					mail.setAtchFileNo(firstAttachFile.getAtchFileNo());
				}
				res = mapper.insertEmail(mail);
				Map<String, Object> map = new HashedMap();
				map.put("empId", mail.getSender().getEmpId());
				map.put("emlId", mail.getEmlId());
				mapper.insertMailSender(map);
				List<String> receiverList = mail.getCReceiver();
				for (String receiver : receiverList) {
					Map<String, Object> map2 = new HashedMap();
					map2.put("empId", receiver);
					map2.put("emlId", mail.getEmlId());
					mapper.insertMailReceiver(map2);
				}
			}

			if (res > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}


}
