package kr.or.everyware.everyware.chat.websocket.service;


import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;

import kr.or.everyware.everyware.chat.service.ChatService;
import kr.or.everyware.everyware.chat.service.EmpService;
import kr.or.everyware.everyware.chat.vo.Chatroom;
import kr.or.everyware.everyware.chat.vo.ChatroomUser;
import kr.or.everyware.everyware.chat.vo.Message;
import kr.or.everyware.everyware.chat.vo.RealTimeChatRoom;
import kr.or.everyware.everyware.chat.vo.WebsocketMessage;
import kr.or.everyware.login.vo.Employee;



@Service
public class WebsocketChatService {
	
	// 채팅방이 아닌 다른 기능을 사용중일 경우 내가 가진 모든 채팅방으로부터 메세지가 오면 알림을 띄우기 위한 맵
	// 로그인 되자마자 자신이 포함된 모든 방에 대해서 자신에 세션을 모두 넣어준다.
	private static Map<Integer, RealTimeChatRoom> rooms =new ConcurrentHashMap<Integer, RealTimeChatRoom>();
	
	// 실제 채팅방에 들어가 메세지를 보고있는 사람상태정보가 들어있는 맵
	private static Map<Integer, Set<String>> roomUserState =new ConcurrentHashMap<Integer, Set<String>>();
	
	@Inject
	private LoginStateService loginStateService;
	@Inject
	private ChatService chatService;
	@Inject
	private EmpService empService;
	
	public void chatroomUpdate(WebSocketSession session,WebsocketMessage messageVO) {
		
		String sender = messageVO.getSender();
		List<Chatroom> roomIdList= chatService.selectChatroomAndUser(sender);
		
		if(messageVO.getState().equals("login")) {	//로그인인경우
			for (Chatroom chatroom : roomIdList) {
				int roomId = chatroom.getRoomId();
				String roomName = chatroom.getRoomNm();
				if(rooms.containsKey(roomId)) {
					RealTimeChatRoom chatRoomVO = rooms.get(roomId);
					Map<String, WebSocketSession> roomSessions = chatRoomVO.getSessions();
					roomSessions.put(sender, session);
					chatRoomVO.setName(roomName);
					chatRoomVO.setSessions(roomSessions);
					rooms.put(roomId, chatRoomVO);
				}else {
					RealTimeChatRoom chatRoomVO = new RealTimeChatRoom();
					chatRoomVO.setName(roomName);
					HashMap<String, WebSocketSession> tmpMap = new HashMap<String, WebSocketSession>();
					tmpMap.put(sender, session);
					chatRoomVO.setSessions(tmpMap);
					rooms.put(roomId, chatRoomVO);
				}
			}
		}else {										//로그아웃인 경우
			for (Chatroom chatroom : roomIdList) {
				int roomId = chatroom.getRoomId();
				String roomName = chatroom.getRoomNm();
				if(rooms.containsKey(roomId)) {
					RealTimeChatRoom chatRoomVO = rooms.get(roomId);
					Map<String, WebSocketSession> roomSessions = chatRoomVO.getSessions();
					if(roomSessions.size()==1) {
						rooms.remove(roomId);
					}else {
						roomSessions.remove(sender);
						rooms.put(roomId, chatRoomVO);
					}
				}
				//실시간 roomState에서도 지워줘야함
				if(roomUserState.containsKey(roomId)) {
					Set<String> set = roomUserState.get(roomId);
					if(set.contains(sender)) {
						if(set.size()==1) {
							roomUserState.remove(roomId);
						}else {
							set.remove(sender);
							roomUserState.put(roomId, set);
						}
					}
				}
			}
			
			
			
			
			//db로 해당아이디의 로그아웃 기록 찍어야함
		}
		
	}

	


	public void sendMessage(WebSocketSession session, WebsocketMessage messageVO) throws IOException {
		
		String sender = messageVO.getSender();
		int roomId = Integer.parseInt(messageVO.getRoom());
		String messageContent = messageVO.getContent();
		String type = messageVO.getType();
		
		if(rooms.containsKey(roomId)){
			RealTimeChatRoom chatRoomVO = rooms.get(roomId);
			Map<String, WebSocketSession> roomSessions = chatRoomVO.getSessions();
			Chatroom chatroom = chatService.selectChatroomAndUserByRoomId(roomId);
			Message message = new Message();
			message.setEmpId(sender);
			message.setMsgCn(messageContent);
			message.setMsgType(Integer.parseInt(type));
			message.setRoomId(roomId);
			int res = chatService.insertMessage(message);
			if(res>0) {
				Set<String> set = roomUserState.get(roomId);
				for(String userId: set){
					chatService.updateLastMessage(userId,message.getMsgId(),roomId);
				}
				int unreadCount = chatroom.getChatroomUsers().size()-set.size();
				messageVO.setUnreadCount(unreadCount);
				Employee employee = empService.selectEmployeeById(sender);	//보낸이의 정보를 가져오기 위함
				Message messageFromDB = chatService.selectMessageById(message.getMsgId());			//직전에 넣은 메세지의 sysdate를 가져오기 위함
				messageVO.setEmployee(employee);
				messageVO.setMessage(messageFromDB);
				Gson gson = new Gson();
				String json = gson.toJson(messageVO);
				TextMessage tm = new TextMessage(json.getBytes());
				messageVO.setType("ca");
				String json2 = gson.toJson(messageVO);
				TextMessage tm2 = new TextMessage(json2.getBytes());
				for(ChatroomUser chatroomUser : chatroom.getChatroomUsers()){
					if(roomUserState.containsKey(roomId)){
						Set<String> roomSet = roomUserState.get(roomId);
						if(roomSet.contains(chatroomUser.getEmpId())) {
							Map<String, WebSocketSession> sessions = chatRoomVO.getSessions();
							WebSocketSession wss = sessions.get(chatroomUser.getEmpId());
							wss.sendMessage(tm);
						}else {
							if(roomSessions.containsKey(chatroomUser.getEmpId())) {
								Map<String, WebSocketSession> sessions = chatRoomVO.getSessions();
								WebSocketSession wss = sessions.get(chatroomUser.getEmpId());
								wss.sendMessage(tm2);
							}
						}
					}else {
						if(roomSessions.containsKey(chatroomUser.getEmpId())) {
							Map<String, WebSocketSession> sessions = chatRoomVO.getSessions();
							WebSocketSession wss = sessions.get(chatroomUser.getEmpId());
							wss.sendMessage(tm2);
						}
					}
				}
			}
			
		}else {	//메세지를 보냈는데 해당 roomid가 없다면 방을 생성하고 메세지를 모낸것 즉 rooms라는 map에는 적용안된상태
			Chatroom chatroom = chatService.selectChatroomAndUserByRoomId(roomId);
			RealTimeChatRoom chatRoomVO = new RealTimeChatRoom();
			Map<String, WebSocketSession> roomsSessions = new HashMap<String, WebSocketSession>();
			List<ChatroomUser> chatroomUsers = chatroom.getChatroomUsers();
			messageVO.setType("cr");
			messageVO.setChatroom(chatroom);
			Gson gson = new Gson();
			String json = gson.toJson(messageVO);
			TextMessage textMessage = new TextMessage(json.getBytes());
			for (ChatroomUser chatroomUser : chatroomUsers) {
				String memberEmpId = chatroomUser.getEmpId();
				if(LoginStateService.sessions.containsKey(memberEmpId)) {
					WebSocketSession wss = LoginStateService.sessions.get(memberEmpId);
					roomsSessions.put(memberEmpId, wss);
					if(!chatroomUser.getEmpId().equals(messageVO.getSender())) {
						wss.sendMessage(textMessage);
					}
				}
			}
			chatRoomVO.setSessions(roomsSessions);
			rooms.put(roomId, chatRoomVO);
			messageVO.setType("2");
			sendMessage(session, messageVO);
			
			
			
		}
		
	}

	public void inChatroom(WebSocketSession session, WebsocketMessage messageVO) throws IOException {
		String sender = messageVO.getSender();
		int roomId = Integer.parseInt(messageVO.getRoom());

		
		if(roomUserState.containsKey(roomId)){
			Set<String> set = roomUserState.get(roomId);
			set.add(sender);
			roomUserState.put(roomId,set);
		}else{
			Set<String> set = new HashSet<String>();
			set.add(sender);
			roomUserState.put(roomId,set);
		}
		
		Set<String> roomState = roomUserState.get(roomId);
		Message message = chatService.selectLastMessage(roomId);
		if(message!=null) {
			for (String empId : roomState) {
				
				chatService.updateLastMessage(empId, message.getMsgId(), roomId);
			}
		}
		Gson gson = new Gson();
		String json = gson.toJson(messageVO);
		TextMessage tm = new TextMessage(json.getBytes());
		
		RealTimeChatRoom chatRoomVO = rooms.get(roomId);
		if(chatRoomVO!=null) {
			Map<String, WebSocketSession> roomsSessions = chatRoomVO.getSessions();
			for (String empId : roomsSessions.keySet()) {
				if(roomState.contains(empId)&&!empId.equals(sender)) {
					WebSocketSession wss = roomsSessions.get(empId);
					wss.sendMessage(tm);
				}
			}
		}
	}
	public void outChatroom(WebSocketSession session, WebsocketMessage messageVO) {
		String sender = messageVO.getSender();
		int roomId = Integer.parseInt(messageVO.getRoom());

		if(roomUserState.containsKey(roomId)){
			Set<String> set = roomUserState.get(roomId);
			if(set.size()==1){
				roomUserState.remove(roomId);
			}else{
				set.remove(sender);
				roomUserState.put(roomId,set);
			}
		}
	}




	public void sendImageMessage(WebSocketSession session, WebsocketMessage messageVO) throws IOException {
		
		String sender = messageVO.getSender();
		int roomId = Integer.parseInt(messageVO.getRoom());
		String type = messageVO.getType();
		int messageId = messageVO.getMessageId();
		
		if(rooms.containsKey(roomId)){
			RealTimeChatRoom chatRoomVO = rooms.get(roomId);
			Map<String, WebSocketSession> roomSessions = chatRoomVO.getSessions();
			Chatroom chatroom = chatService.selectChatroomAndUserByRoomId(roomId);

			
			Set<String> set = roomUserState.get(roomId);
			for(String userId: set){
				chatService.updateLastMessage(userId,messageId,roomId);
			}
			int unreadCount = chatroom.getChatroomUsers().size()-set.size();
			messageVO.setUnreadCount(unreadCount);
			Employee employee = empService.selectEmployeeById(sender);	//보낸이의 정보를 가져오기 위함
			Message messageFromDB = chatService.selectMessageById(messageId);			//직전에 넣은 메세지의 sysdate를 가져오기 위함
			messageVO.setEmployee(employee);
			messageVO.setMessage(messageFromDB);
			Gson gson = new Gson();
			String json = gson.toJson(messageVO);
			TextMessage tm = new TextMessage(json.getBytes());
			messageVO.setType("ca");
			String json2 = gson.toJson(messageVO);
			TextMessage tm2 = new TextMessage(json2.getBytes());
			for(ChatroomUser chatroomUser : chatroom.getChatroomUsers()){
				if(roomUserState.containsKey(roomId)){
					Set<String> roomSet = roomUserState.get(roomId);
					if(roomSet.contains(chatroomUser.getEmpId())) {
						Map<String, WebSocketSession> sessions = chatRoomVO.getSessions();
						WebSocketSession wss = sessions.get(chatroomUser.getEmpId());
						wss.sendMessage(tm);
					}else {
						if(roomSessions.containsKey(chatroomUser.getEmpId())) {
							Map<String, WebSocketSession> sessions = chatRoomVO.getSessions();
							WebSocketSession wss = sessions.get(chatroomUser.getEmpId());
							wss.sendMessage(tm2);
						}
					}
				}else {
					if(roomSessions.containsKey(chatroomUser.getEmpId())) {
						Map<String, WebSocketSession> sessions = chatRoomVO.getSessions();
						WebSocketSession wss = sessions.get(chatroomUser.getEmpId());
						wss.sendMessage(tm2);
					}
				}
			
			}
			
		}else {	//메세지를 보냈는데 해당 roomid가 없다면 방을 생성하고 메세지를 모낸것 즉 rooms라는 map에는 적용안된상태
			Chatroom chatroom = chatService.selectChatroomAndUserByRoomId(roomId);
			RealTimeChatRoom chatRoomVO = new RealTimeChatRoom();
			Map<String, WebSocketSession> roomsSessions = new HashMap<String, WebSocketSession>();
			List<ChatroomUser> chatroomUsers = chatroom.getChatroomUsers();
			messageVO.setType("cr");
			messageVO.setChatroom(chatroom);
			Gson gson = new Gson();
			String json = gson.toJson(messageVO);
			TextMessage textMessage = new TextMessage(json.getBytes());
			for (ChatroomUser chatroomUser : chatroomUsers) {
				String memberEmpId = chatroomUser.getEmpId();
				if(LoginStateService.sessions.containsKey(memberEmpId)) {
					WebSocketSession wss = LoginStateService.sessions.get(memberEmpId);
					roomsSessions.put(memberEmpId, wss);
					if(!chatroomUser.getEmpId().equals(messageVO.getSender())) {
						wss.sendMessage(textMessage);
					}
				}
			}
			chatRoomVO.setSessions(roomsSessions);
			rooms.put(roomId, chatRoomVO);
			messageVO.setType("f");
			sendMessage(session, messageVO);
			
			
			
		}
	}
}
