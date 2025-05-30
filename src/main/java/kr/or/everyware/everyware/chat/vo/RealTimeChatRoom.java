package kr.or.everyware.everyware.chat.vo;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.WebSocketSession;

import lombok.Data;

@Data
public class RealTimeChatRoom {
	private String roomId;
    private String name;
    private Map<String,WebSocketSession> sessions = new ConcurrentHashMap<>();
    private List<String> users; 

    
}
