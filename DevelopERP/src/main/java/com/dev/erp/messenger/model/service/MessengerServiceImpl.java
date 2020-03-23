package com.dev.erp.messenger.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.messenger.model.dao.MessengerDAO;
import com.dev.erp.messenger.model.vo.ChatRoom;
import com.dev.erp.messenger.model.vo.Msg;

@Service
public class MessengerServiceImpl implements MessengerService {

	@Autowired
	MessengerDAO messengerDAO;

	@Override
	public String findChatIdByEmail(String email) {
		return messengerDAO.findChatIdByEmail(email);
	}
	
	@Override
	public int insertChatRoom(List<ChatRoom> list) {
		int result = 0;
		for(ChatRoom chatRoom: list){
			result += messengerDAO.insertChatRoom(chatRoom);
		}
		return result;
	}

	@Override
	public List<Map<String,String>> findChatListByChatId(String chatId) {
		return messengerDAO.findChatListByChatId(chatId);
	}

	
	@Override
	public List<Map<String, String>> findRecentList(Map<String,String> param ) {
		return messengerDAO.findRecentList(param);
	}

	@Override
	public int insertChatLog(Msg fromMessage) {
		updateLastCheck(fromMessage);
		return messengerDAO.insertChatLog(fromMessage);
		
	}

	@Override
	public int updateLastCheck(Msg fromMessage) {
		return messengerDAO.updateLastCheck(fromMessage);
		
	}

	@Override
	public List<Map<String, String>> selectMemberList(int cPage, int numPerPage, String email) {
		return messengerDAO.selectMemberList(cPage,numPerPage, email);
	}

	@Override
	public int selectAllCountByAccountNo() {
		return messengerDAO.selectAllCountByAccountNo();
	}

	@Override
	public int deleteChatRoom(String chatId) {
		return messengerDAO.deleteChatRoom(chatId);
	}

	@Override
	public List<Map<String, String>> findChatIdList(String email) {
		return messengerDAO.findChatIdList(email);
	}

	@Override
	public int updateLastCheckLog(Msg fromMessage) {
		return messengerDAO.updateLastCheckLog(fromMessage);
	}

	@Override
	public List<Integer> messengerCount(Map<String, String> param) {
		return messengerDAO.messengerCount(param);
	}


}
