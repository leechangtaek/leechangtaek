package com.dev.erp.message.model.service;

import java.util.List;
import java.util.Map;

import com.dev.erp.message.model.vo.Message;

public interface MessageService {

	List<Map<String, Object>> selectMessageList(String empName);

	List<Message> selectMessageAllList(int cPage, int numPerPage,String empName);

	int selectAllCountByAccountNo(String empName);

	int insertMessage(Message message);

	Message detailMessage(int meNo);

	int updateMessage(int meNo);

	List<Message> messageConfirmPage(int cPage, int numPerPage, String empName);

	int selectAllCountmessageConfirmPage(String empName);

	List<Message> messageNoConfirmPage(int cPage, int numPerPage, String empName);

	int selectAllCountmessageNoConfirmPage(String empName);

	List<Message> messageSenderFormPage(int cPage, int numPerPage, String empName);

	int selectAllCountmessageSenderFormPage(String empName);

}
