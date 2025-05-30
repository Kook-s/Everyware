package kr.or.everyware.admin.chat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.chat.vo.ChatLog;
import kr.or.everyware.admin.chat.vo.ChatLogPaging;
import kr.or.everyware.admin.chat.vo.ImgChatLog;
import kr.or.everyware.admin.chat.vo.ImgChatLogPaging;
import kr.or.everyware.everyware.chat.vo.Message;

@Mapper
public interface AdminChatMapper {

	int selectChatLogCount(ChatLogPaging<ChatLog> chatLogPaging);

	List<ChatLog> selectChatLogList(ChatLogPaging<ChatLog> chatLogPaging);

	int selectImgChatLogCount(ImgChatLogPaging<ImgChatLog> chatLogPaging);

	List<ImgChatLog> selectImgChatLogList(ImgChatLogPaging<ImgChatLog> chatLogPaging);

	List<Message> selectRoomLogs(int msgId);

}
