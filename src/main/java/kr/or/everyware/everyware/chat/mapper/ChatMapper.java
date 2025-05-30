package kr.or.everyware.everyware.chat.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.chat.vo.Chatroom;
import kr.or.everyware.everyware.chat.vo.Message;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.vo.AttachFile;

@Mapper
public interface ChatMapper {
	int createChatroom(Chatroom chatroom);

	int createChatroomUser(Map<String, Object> map);

	List<Chatroom> selectChatroomAndUser(String empId);

	List<Message> selectMessages(int roomId);

	Chatroom selectChatroomAndUserByRoomId(int roomId);


	int insertMessage(Message message);

	void updateLastMessage(Map<String, Object> map);

	Message selectLastMessage(int roomId);

	Message selectmessageById(int messageId);

	
	List<Employee> selectEmployees(String empId);

	Employee selectEmployeeById(String empId);

	List<Employee> selectEmployees(Employee employee);

	int insertAttachFile(AttachFile attachFile);

	AttachFile selectAttachFile(int atchFileNo);

}
