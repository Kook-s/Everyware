package kr.or.everyware.admin.chat.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.admin.chat.mapper.AdminChatMapper;
import kr.or.everyware.admin.chat.service.AdminChatService;
import kr.or.everyware.admin.chat.vo.ChatLog;
import kr.or.everyware.admin.chat.vo.ChatLogPaging;
import kr.or.everyware.admin.chat.vo.ImgChatLog;
import kr.or.everyware.admin.chat.vo.ImgChatLogPaging;
import kr.or.everyware.everyware.chat.vo.Message;
@Service
public class AdminChatServiceImpl implements AdminChatService{

	
	@Inject
	AdminChatMapper mapper;
	
	@Override
	public int selectChatLogCount(ChatLogPaging<ChatLog> chatLogPaging) {
		// TODO Auto-generated method stub
		return mapper.selectChatLogCount(chatLogPaging);
	}

	@Override
	public List<ChatLog> selectChatLogList(ChatLogPaging<ChatLog> chatLogPaging) {
		// TODO Auto-generated method stub
		return mapper.selectChatLogList(chatLogPaging);
	}

	@Override
	public int selectImgChatLogCount(ImgChatLogPaging<ImgChatLog> chatLogPaging) {
		// TODO Auto-generated method stub
		return mapper.selectImgChatLogCount(chatLogPaging);
	}

	@Override
	public List<ImgChatLog> selectImgChatLogList(ImgChatLogPaging<ImgChatLog> chatLogPaging) {
		// TODO Auto-generated method stub
		return mapper.selectImgChatLogList(chatLogPaging);
	}

	@Override
	public List<Message> selectRoomLogs(int msgId) {
		// TODO Auto-generated method stub
		return mapper.selectRoomLogs(msgId);
	}

}
