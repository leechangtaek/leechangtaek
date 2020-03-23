package com.dev.erp.messenger.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dev.erp.messenger.model.vo.ChatRoom;
import com.dev.erp.messenger.model.vo.Msg;

@Repository
public class MessengerDAOImpl implements MessengerDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public String findChatIdByEmail(String email) {
		return sqlSession.selectOne("messenger.findChatIdByEmail",email);
	}

	@Override
	public int insertChatRoom(ChatRoom chatRoom) {
		return sqlSession.insert("messenger.insertChatRoom", chatRoom);
	}

	@Override
	public List<Map<String,String>> findChatListByChatId(String chatId) {
		return sqlSession.selectList("messenger.findChatListByChatId", chatId);
	}

	@Override
	public List<Map<String, String>> findRecentList(Map<String,String> param ) {
		return sqlSession.selectList("messenger.findRecentList", param);
	}

	@Override
	public int insertChatLog(Msg fromMessage) {
		return sqlSession.insert("messenger.insertChatLog", fromMessage);
	}

	@Override
	public int updateLastCheck(Msg fromMessage) {
		return sqlSession.update("messenger.updateLastCheck", fromMessage);	
	}

	@Override
	public List<Map<String, String>> selectMemberList(int cPage, int numPerPage, String email) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("messenger.selectMemberList",email,rowBounds);
	}

	@Override
	public int selectAllCountByAccountNo() {
		return sqlSession.selectOne("messenger.selectAllCountByAccountNo");
	}

	@Override
	public int deleteChatRoom(String chatId) {
		return sqlSession.update("messenger.deleteChatRoom", chatId);
	}

	@Override
	public List<Map<String, String>> findChatIdList(String email) {
		return sqlSession.selectList("messenger.findChatIdList", email);
	}

	@Override
	public int updateLastCheckLog(Msg fromMessage) {
		return sqlSession.update("messenger.updateLastCheckLog", fromMessage);	
	}

	@Override
	public List<Integer> messengerCount(Map<String, String> param) {
		return sqlSession.selectList("messenger.messengerCount", param);
	}

	
}
