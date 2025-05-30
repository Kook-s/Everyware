package kr.or.everyware.everyware.chat.websocket.service;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kr.or.everyware.everyware.chat.vo.WebsocketMessage;


@Service
public class LoginStateService {
	public static Map<String, WebSocketSession> sessions = new ConcurrentHashMap<String, WebSocketSession>();
	
	public void loginState(WebSocketSession session,WebsocketMessage message) {
		
		// 상태가 로그인인 경우, sessions에 해당 유저아이디와 웹소켓 삽입
		if(message.getState().equals("login")) {
			sessions.put(message.getSender(),session);
		}else {//로그아웃인 경우, sessions에 해당 유저아이디 삭제
			if(sessions.containsKey(message.getSender())) {
				sessions.remove(message.getSender());
			}
		}
		JsonObject jo = new JsonObject();				//ol: 한명에 대한 로그인로그아웃 정보 ex){type:ol, sender:"a001", state:"login"~~}이런식
		jo.addProperty("type", "ol");					//이미 본인이 접속중일 때 다른사람이 로그인,로그아웃하면 본인 화면에 반영되도록 해야함
		jo.addProperty("sender", message.getSender());
		jo.addProperty("state", message.getState());
		TextMessage tm = new TextMessage(jo.toString().getBytes());
		JsonObject jo2 = new JsonObject();				//nl: 여러명에 대한 로그인 로그아웃 정보, 그냥 sessions의 keyset(접속한 유저id들이 key값이다)을 갖다주면됨
		jo2.addProperty("type", "nl");					//ex){type:nl, sender:"a001", ~~, loginUsers:["a001", "b001", "c001"]}이런식
		jo2.addProperty("sender", message.getSender());	//본인이 로그인 했을때 이미 접속해 있는 모든사람의 로그인,로그아웃 정보를 반영해야함
		jo2.addProperty("state", message.getState());	//로그인했을때 이 메세지를 받을것이며, 해당 loginUsers에 있는 아이디들은 초록불, 그외 빨간불 설정
		Gson gson = new Gson();
		Set<String> userIds = sessions.keySet();
		jo2.add("loginUsers",gson.toJsonTree(userIds) );
		TextMessage tm2 = new TextMessage(jo2.toString().getBytes());
		for(String key : sessions.keySet()) {
			WebSocketSession wss = sessions.get(key);
			try {
				if(wss==session) {				//나한테 보내는 메세지
					wss.sendMessage(tm2);
				}else {
					wss.sendMessage(tm);		//그외
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
}
