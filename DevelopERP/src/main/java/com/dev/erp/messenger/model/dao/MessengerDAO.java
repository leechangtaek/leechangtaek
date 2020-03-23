package com.dev.erp.messenger.model.dao;

import java.util.List;
import java.util.Map;

import com.dev.erp.messenger.model.vo.ChatRoom;
import com.dev.erp.messenger.model.vo.Msg;

public interface MessengerDAO {

	List<Map<String, String>> findRecentList(Map<String,String> param );

	String findChatIdByEmail(String email);

	int insertChatRoom(ChatRoom chatRoom);

	List<Map<String,String>> findChatListByChatId(String chatId);

	int insertChatLog(Msg fromMessage);

	int updateLastCheck(Msg fromMessage);

	List<Map<String, String>> selectMemberList(int cPage, int numPerPage, String email);

	int selectAllCountByAccountNo();

	int deleteChatRoom(String chatId);

	List<Map<String, String>> findChatIdList(String email);

	int updateLastCheckLog(Msg fromMessage);

	List<Integer> messengerCount(Map<String, String> param);


}
