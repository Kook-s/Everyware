package kr.or.everyware.admin.chat.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.admin.chat.service.AdminChatService;
import kr.or.everyware.admin.chat.vo.ChatLog;
import kr.or.everyware.admin.chat.vo.ChatLogPaging;
import kr.or.everyware.admin.chat.vo.ImgChatLog;
import kr.or.everyware.admin.chat.vo.ImgChatLogPaging;
import kr.or.everyware.admin.chat.vo.SearchInfo;
import kr.or.everyware.everyware.chat.vo.Chatroom;
import kr.or.everyware.everyware.chat.vo.Message;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;

@Controller
@RequestMapping("/everyware/admin")
public class AdminChatController {
	
	@Inject
	AdminChatService chatService;
	
	@PreAuthorize("hasAuthority('CHAT_AD')")
	@GetMapping("/chat")
	public String goAdminChat() {
		
		return "admin/chat/chat";
	}
	
	@PreAuthorize("hasAuthority('CHAT_AD')")
	@PostMapping(value = "/chat/chatList" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public ChatLogPaging<ChatLog> getChatList(@RequestBody SearchInfo searchInfo) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		System.out.println(searchInfo);
		
		ChatLogPaging<ChatLog> chatLogPaging = new ChatLogPaging<ChatLog>();
		
		//검색 기능 추가시 활용
		if(StringUtils.isNotBlank(searchInfo.getContent())) {
			chatLogPaging.setContent(searchInfo.getContent());
		}
		
		
		chatLogPaging.setIsLately(searchInfo.getIsLately());
		chatLogPaging.setCustId(employee.getCustId());
		String sdate=null;
		String edate=null;
		if(searchInfo.getSdate()!=null && !searchInfo.getSdate().equals("")) {
			sdate = searchInfo.getSdate().replaceAll("-", "/");
		}
		if(searchInfo.getEdate()!=null && !searchInfo.getEdate().equals("")) {
			edate = searchInfo.getEdate().replaceAll("-", "/");
		}
		chatLogPaging.setSdate(sdate);
		chatLogPaging.setEdate(edate);
		chatLogPaging.setRoomName(searchInfo.getRoomName());
		chatLogPaging.setName(searchInfo.getSender());
		chatLogPaging.setCurrentPage(searchInfo.getPage());
		int totalRecord = chatService.selectChatLogCount(chatLogPaging);
		chatLogPaging.setTotalRecord(totalRecord); 
		List<ChatLog> dataList =chatService.selectChatLogList(chatLogPaging);
		chatLogPaging.setDataList(dataList);
		
		return chatLogPaging;
				
	}
	
	@PreAuthorize("hasAuthority('CHAT_AD')")
	@PostMapping(value = "/chat/imgChatList" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public ImgChatLogPaging<ImgChatLog> getImgChatList(@RequestBody SearchInfo searchInfo) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		System.out.println(searchInfo);
		
		ImgChatLogPaging<ImgChatLog> chatLogPaging = new ImgChatLogPaging<ImgChatLog>();
		
		
		chatLogPaging.setIsLately(searchInfo.getIsLately());
		chatLogPaging.setCustId(employee.getCustId());
		String sdate=null;
		String edate=null;
		if(searchInfo.getSdate()!=null && !searchInfo.getSdate().equals("")) {
			sdate = searchInfo.getSdate().replaceAll("-", "/");
		}
		if(searchInfo.getEdate()!=null && !searchInfo.getEdate().equals("")) {
			edate = searchInfo.getEdate().replaceAll("-", "/");
		}
		chatLogPaging.setSdate(sdate);
		chatLogPaging.setEdate(edate);
		chatLogPaging.setFileName(searchInfo.getFileName());
		chatLogPaging.setRoomName(searchInfo.getRoomName());
		chatLogPaging.setName(searchInfo.getSender());
		chatLogPaging.setCurrentPage(searchInfo.getPage());
		int totalRecord = chatService.selectImgChatLogCount(chatLogPaging);
		chatLogPaging.setTotalRecord(totalRecord); 
		List<ImgChatLog> dataList =chatService.selectImgChatLogList(chatLogPaging);
		chatLogPaging.setDataList(dataList);
		
		return chatLogPaging;
				
	}
	@PreAuthorize("hasAuthority('CHAT_AD')")
	@PostMapping(value = "/chat/roomLog" ,produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<Message> getRoomLog(@RequestBody Message message) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		System.out.println(message);
		
		List<Message> logs = chatService.selectRoomLogs(message.getMsgId());
		
		
		
		return logs;
				
	}
	
}
