package com.dev.erp.message.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dev.erp.message.model.vo.Message;

@Repository
public class MessageDAOImpl implements MessageDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, Object>> selectMessageList(String empName) {
		return sqlSession.selectList("message.selectMessageList",empName);
	}

	@Override
	public List<Message> selectMessageAllList(int cPage, int numPerPage,String empName) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("message.selectMessageAllList",empName,rowBounds);
	}

	@Override
	public int selectAllCountByAccountNo(String empName) {
		return sqlSession.selectOne("message.selectAllCountByAccountNo",empName);
	}

	@Override
	public int insertMessage(Message message) {
		return sqlSession.insert("message.insertMessage",message);
	}

	@Override
	public Message detailMessage(int meNo) {
		return sqlSession.selectOne("message.detailMessage",meNo);
	}

	@Override
	public int updateMessage(int meNo) {
		return sqlSession.update("message.updateMessage",meNo);
	}

	@Override
	public List<Message> messageConfirmPage(int cPage, int numPerPage, String empName) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("message.messageConfirmPage",empName,rowBounds);
	}

	@Override
	public int selectAllCountmessageConfirmPage(String empName) {
		return sqlSession.selectOne("message.selectAllCountmessageConfirmPage",empName);
	}
	
	@Override
	public List<Message> messageNoConfirmPage(int cPage, int numPerPage, String empName) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("message.messageNoConfirmPage",empName,rowBounds);
	}
	
	@Override
	public int selectAllCountmessageNoConfirmPage(String empName) {
		return sqlSession.selectOne("message.selectAllCountmessageNoConfirmPage",empName);
	}

	@Override
	public List<Message> messageSenderFormPage(int cPage, int numPerPage, String empName) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("message.messageSenderFormPage",empName,rowBounds);
	}

	@Override
	public int selectAllCountmessageSenderFormPage(String empName) {
		return sqlSession.selectOne("message.selectAllCountmessageSenderFormPage",empName);
	}
}
