package kr.or.everyware.everyware.chat.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.chat.service.ChatService;
import kr.or.everyware.everyware.chat.service.EmpService;
import kr.or.everyware.everyware.chat.vo.Chatroom;
import kr.or.everyware.everyware.chat.vo.ChatroomUser;
import kr.or.everyware.everyware.chat.vo.Message;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;
import kr.or.everyware.util.fileUtils.MediaUtils;


@Controller
@RequestMapping("/everyware/chat")
@PreAuthorize("hasAnyAuthority('CALENDAR','MAIL','HOME','APPROVAL','HR','ADDRESSBOOK','CLOUD','BOARD','RESERVATION','TODO','SUVY')")
public class ChatController {
	

	@Inject
	private ChatService chatService; 
	
	@Inject 
	private EmpService empService;
	

/*	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		List<Employee> empList = empService.selectEmployees();
		model.addAttribute("empList",empList);
		return "chat";
	}
*/
	@RequestMapping(value = "/messengerInfo", method = RequestMethod.GET)
	public ResponseEntity<String> empList() {//원렌 세션에서 꺼내야함. 테스트로 입력받으려고 받는 empId
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		List<Employee> empList = empService.selectEmployees(employee);
		
		List<Chatroom> chatroomList = chatService.selectChatroomAndUser(employee.getEmpId());
		Gson gson = new Gson();
		JsonObject jo = new JsonObject();
		JsonElement je = gson.toJsonTree(empList);
		JsonElement jr = gson.toJsonTree(chatroomList);
		jo.add("empList", je);
		jo.add("chatroomList", jr);
		String json = gson.toJson(jo);
		return new ResponseEntity<String>(json,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/chatroom/create", method = RequestMethod.POST,produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> roomCreate(@RequestBody Map<String, Object> map){
		String json="";
		int roomId =chatService.createChatroom(map);
		if(roomId>0) {
			Chatroom chatroom = chatService.selectChatroomAndUserByRoomId(roomId);
			Gson gson = new Gson();
			json = gson.toJson(chatroom);
			
		}
		return new ResponseEntity<String>(json,HttpStatus.OK);
	}
	

	@RequestMapping(value = "/roomDetail/{roomId}", method = RequestMethod.POST,produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> roomDetail(@PathVariable int roomId){

		List<Message> messageList = chatService.selectMessages(roomId);
		Chatroom chatroomInfo = chatService.selectChatroomAndUserByRoomId(roomId);

		JsonObject jo = new JsonObject();
		Gson gson = new Gson();
		JsonElement jml = gson.toJsonTree(messageList);
		JsonElement jci = gson.toJsonTree(chatroomInfo);
		jo.add("messageList", jml);
		jo.add("chatroomInfo", jci);
		String json = gson.toJson(jo);
		System.out.println(messageList);
		return new ResponseEntity<String>(json,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/chatImgRead/{messageId}", method = RequestMethod.GET)
	public ResponseEntity<byte[]> chatImgRead(@PathVariable("messageId") int messageId) {
		InputStream is=null;
		ResponseEntity<byte[]> entity = null;
		
		try {
			Message selectMessageById = chatService.selectMessageById(messageId);
			AttachFile fileInfo = chatService.selectAttachFile(selectMessageById.getAtchFileNo());
			String savedFileName=fileInfo.getFileSavedNm();
			String front = savedFileName.substring(0,12); 	// /2023/06/07 폴더
			String end = savedFileName.substring(12);		// 뒤 파일 명
			String fileName= front+"s_"+end;
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMeMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			is = new FileInputStream(fileInfo.getFilePath()+fileName);
			if(mType!=null) {
				headers.setContentType(mType);
			}else {
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; fileName=\""+new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is),headers,HttpStatus.CREATED);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/originChatImgRead/{messageId}", method = RequestMethod.GET)
	public ResponseEntity<byte[]> originChatImgRead(@PathVariable("messageId") int messageId) {
		InputStream is=null;
		ResponseEntity<byte[]> entity = null;
		
		try {
			Message selectMessageById = chatService.selectMessageById(messageId);
			AttachFile fileInfo = chatService.selectAttachFile(selectMessageById.getAtchFileNo());
			String fileName=fileInfo.getFileSavedNm();
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMeMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			is = new FileInputStream(fileInfo.getFilePath()+fileName);
			if(mType!=null) {
				headers.setContentType(mType);
			}else {
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; fileName=\""+new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is),headers,HttpStatus.CREATED);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return entity;
	}
	
	
	@RequestMapping(value = "/chatroom/unreadUpdate/{roomId}", method = RequestMethod.POST)
	public ResponseEntity<String> unreadUpdate(@PathVariable("roomId") int roomId){
		Chatroom chatroom = chatService.selectChatroomAndUserByRoomId(roomId);
		List<ChatroomUser> chatroomUsers = chatroom.getChatroomUsers();
		Gson gson = new Gson();
		String json = gson.toJson(chatroomUsers);
		return new ResponseEntity<String>(json,HttpStatus.OK);
	}

	@RequestMapping(value = "/imageMessage", method = RequestMethod.POST)
	public ResponseEntity<Integer> imageMessage(MultipartFile file, String sender, int roomId,String fileType){//시큐리티 설정시 세션유저로 꺼낼것임
		
		Integer res=null;
		try {
			res = chatService.imageMessageProcess(file,sender,roomId,fileType);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return new ResponseEntity<Integer>(res,HttpStatus.OK);
	}
	
}
