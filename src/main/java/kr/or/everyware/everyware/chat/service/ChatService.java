package kr.or.everyware.everyware.chat.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.chat.vo.Chatroom;
import kr.or.everyware.everyware.chat.vo.Message;
import kr.or.everyware.util.attachment.vo.AttachFile;

public interface ChatService {

	int createChatroom(Map<String, Object> map);

	List<Chatroom> selectChatroomAndUser(String empId);

	List<Message> selectMessages(int roomId);

	Chatroom selectChatroomAndUserByRoomId(int roomId);
	

	int insertMessage(Message message);

	void updateLastMessage(String empId, int messageId, int roomId);

	Message selectLastMessage(int roomId);

	Message selectMessageById(int messageId);

	Integer imageMessageProcess(MultipartFile file, String sender, int roomId, String fileType) throws IOException;

	AttachFile selectAttachFile(int atchFileNo);

}
