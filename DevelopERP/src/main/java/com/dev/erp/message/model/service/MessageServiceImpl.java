package com.dev.erp.message.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.message.model.dao.MessageDAO;
import com.dev.erp.message.model.vo.Message;

@Service
public class MessageServiceImpl implements MessageService {

	@Autowired
	MessageDAO messageDAO;

	@Override
	public List<Map<String, Object>> selectMessageList(String empName) {
		return messageDAO.selectMessageList(empName);
	}

	@Override
	public List<Message> selectMessageAllList(int cPage, int numPerPage,String empName) {
		return messageDAO.selectMessageAllList(cPage,numPerPage,empName);
	}

	@Override
	public int selectAllCountByAccountNo(String empName) {
		return messageDAO.selectAllCountByAccountNo(empName);
	}

	@Override
	public int insertMessage(Message message) {
		return messageDAO.insertMessage(message);
	}

	@Override
	public Message detailMessage(int meNo) {
		return messageDAO.detailMessage(meNo);
	}

	@Override
	public int updateMessage(int meNo) {
		return messageDAO.updateMessage(meNo);
	}

	@Override
	public List<Message> messageConfirmPage(int cPage, int numPerPage, String empName) {
		return messageDAO.messageConfirmPage(cPage,numPerPage,empName);
	}

	@Override
	public int selectAllCountmessageConfirmPage(String empName) {
		return messageDAO.selectAllCountmessageConfirmPage(empName);
	}
	@Override
	public List<Message> messageNoConfirmPage(int cPage, int numPerPage, String empName) {
		return messageDAO.messageNoConfirmPage(cPage,numPerPage,empName);
	}
	
	@Override
	public int selectAllCountmessageNoConfirmPage(String empName) {
		return messageDAO.selectAllCountmessageNoConfirmPage(empName);
	}

	@Override
	public List<Message> messageSenderFormPage(int cPage, int numPerPage, String empName) {
		return messageDAO.messageSenderFormPage(cPage,numPerPage,empName);
	}

	@Override
	public int selectAllCountmessageSenderFormPage(String empName) {
		return messageDAO.selectAllCountmessageSenderFormPage(empName);
	}

}
