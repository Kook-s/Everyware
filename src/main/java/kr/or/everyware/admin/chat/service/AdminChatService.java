package kr.or.everyware.admin.chat.service;

import java.util.List;

import kr.or.everyware.admin.chat.vo.ChatLog;
import kr.or.everyware.admin.chat.vo.ChatLogPaging;
import kr.or.everyware.admin.chat.vo.ImgChatLog;
import kr.or.everyware.admin.chat.vo.ImgChatLogPaging;
import kr.or.everyware.everyware.chat.vo.Message;

public interface AdminChatService {

	int selectChatLogCount(ChatLogPaging<ChatLog> chatLogPaging);

	List<ChatLog> selectChatLogList(ChatLogPaging<ChatLog> chatLogPaging);

	int selectImgChatLogCount(ImgChatLogPaging<ImgChatLog> chatLogPaging);

	List<ImgChatLog> selectImgChatLogList(ImgChatLogPaging<ImgChatLog> chatLogPaging);

	List<Message> selectRoomLogs(int msgId);

}
