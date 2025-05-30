package kr.or.everyware.everyware.chat.websocket;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import kr.or.everyware.everyware.chat.vo.WebsocketMessage;
import kr.or.everyware.everyware.chat.websocket.service.AlarmService;
//import kr.or.everyware.everyware.chat.websocket.service.AlarmService;
import kr.or.everyware.everyware.chat.websocket.service.LoginStateService;
import kr.or.everyware.everyware.chat.websocket.service.WebsocketChatService;


@Controller
public class WebSocketHandler extends TextWebSocketHandler {
	
	@Inject
	LoginStateService loginStateService;
	@Inject
	WebsocketChatService websocketChatService;
	@Inject
	AlarmService alarmService;

	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		String msg = message.getPayload();
		Gson gson = new Gson();
		WebsocketMessage vo = gson.fromJson(msg, WebsocketMessage.class);
		System.out.println(vo);
		if(vo.getType().equals("l")) {	//로그인,로그아웃 상태 메세지
			
			loginStateService.loginState(session, vo);
			websocketChatService.chatroomUpdate(session, vo);
			
		}else if(vo.getType().equals("2")){ // 채팅메세지
			
			websocketChatService.sendMessage(session,vo);
			
		}else if(vo.getType().equals("in")){	//특정 채팅방 들어갔을 때(읽음처리)
			websocketChatService.inChatroom(session,vo);
		}else if(vo.getType().equals("out")){	//특정 채팅방 나갔을 때(이후부터 안읽음 처리 되도록)
			websocketChatService.outChatroom(session,vo);
		}else if(vo.getType().equals("1")) {
			websocketChatService.sendImageMessage(session,vo);
		}else if(vo.getType().equals("al")) {
			alarmService.alarmProccess(session,vo);
		}
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
	}
}
