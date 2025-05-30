package kr.or.everyware.everyware.chat.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.chat.mapper.ChatMapper;
import kr.or.everyware.everyware.chat.service.ChatService;
import kr.or.everyware.everyware.chat.vo.Chatroom;
import kr.or.everyware.everyware.chat.vo.Message;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.AttachFileValidate;
import kr.or.everyware.util.attachment.vo.AttachFile;
import kr.or.everyware.util.fileUtils.UploadFileUtils;

@Service
public class ChatServiceImpl implements ChatService {

	
	@Resource(name="uploadPath")
	private String resourcesPath;
	
	@Inject
	private ChatMapper mapper;

	@Inject
	private AttachFileValidate attachService;
	
	@Override
	public int createChatroom(Map<String, Object> map) {
		boolean flag=false;	// true되면 에러 있는거
		List<String> selectedList = (List<String>)map.get("selectedList");
		String roomName = (String)map.get("roomName");
		
		Chatroom chatroom = new Chatroom();
		chatroom.setRoomNm(roomName);
		int res = mapper.createChatroom(chatroom);
		if(res>0) {
			
			for (String empId : selectedList) {
				Map<String, Object> tempMap = new HashMap<String, Object>();
				tempMap.put("roomId", chatroom.getRoomId());
				tempMap.put("empId", empId);
				res = mapper.createChatroomUser(tempMap);
				if(res==0) {
					flag = true;
				}
			}
			
		}else {
			flag=true;
		}
		
		if(flag) {
			return 0;
		}else {
			return chatroom.getRoomId();
		}
	}

	@Override
	public List<Chatroom> selectChatroomAndUser(String empId) {
		// TODO Auto-generated method stub
		return mapper.selectChatroomAndUser(empId);
	}

	@Override
	public List<Message> selectMessages(int roomId) {
		// TODO Auto-generated method stub
		return mapper.selectMessages(roomId);
	}

	@Override
	public Chatroom selectChatroomAndUserByRoomId(int roomId) {
		// TODO Auto-generated method stub
		return mapper.selectChatroomAndUserByRoomId(roomId);
	}


	@Override
	public int insertMessage(Message message) {
		// TODO Auto-generated method stub
		return mapper.insertMessage(message);
	}

	@Override
	public void updateLastMessage(String empId, int messageId, int roomId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empId", empId);
		map.put("msgId", messageId);
		map.put("roomId", roomId);
		mapper.updateLastMessage(map);
	}

	@Override
	public Message selectLastMessage(int roomId) {
		// TODO Auto-generated method stub
		return mapper.selectLastMessage(roomId);
	}

	@Override
	public Message selectMessageById(int messageId) {
		// TODO Auto-generated method stub
		return mapper.selectmessageById(messageId);
	}

	@Override
	public Integer imageMessageProcess(MultipartFile file, String sender, int roomId,String fileType) throws IOException {
		// TODO Auto-generated method stub
		
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		String custId = employee.getCustId();
		
		 List<MultipartFile> list = new ArrayList<MultipartFile>();
		 list.add(file);
		if (ServiceResult.FAILED.equals(attachService.validate(custId,list))) {
			return 0;
		}
		
		String realSavedName = UploadFileUtils.uploadFile(resourcesPath, file.getOriginalFilename(), file.getBytes());
		AttachFile attachFile = new AttachFile();
		attachFile.setAtchFileSeq(1);
		attachFile.setBizType(1);
		attachFile.setFileNm(file.getOriginalFilename());
		attachFile.setFileSz(file.getSize());
		attachFile.setCustId(custId);
		attachFile.setFilePath(resourcesPath);
		attachFile.setFileSavedNm(realSavedName);
		attachFile.setFileType(fileType);
		int res = mapper.insertAttachFile(attachFile);
		if(res>0) {
			Message message=new Message();
			message.setAtchFileNo(attachFile.getAtchFileNo());
			message.setEmpId(employee.getEmpId());
			message.setMsgType(1);
			message.setMsgCn("");
			message.setRoomId(roomId);
			res = mapper.insertMessage(message);
			return message.getMsgId();
		}else {
			return 0;
		}
	}

	@Override
	public AttachFile selectAttachFile(int atchFileNo) {
		// TODO Auto-generated method stub
		return mapper.selectAttachFile(atchFileNo);
	}
	


	
	
	

		

}
