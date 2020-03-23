package com.dev.erp.message.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.common.exception.MyException;
import com.dev.erp.common.util.Utils;
import com.dev.erp.message.model.service.MessageService;
import com.dev.erp.message.model.vo.Message;

@Controller
public class MessageController {

	private final static Logger logger = LoggerFactory.getLogger(MessageController.class);
	@Autowired
	MessageService messageService;
	
	@RequestMapping("/message/messageList.do")
	public ModelAndView messageList(ModelAndView mav,@RequestParam("empName") String empName) {
		try {
			mav.setViewName("message/messageList");
			
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/message/messageListPage.do")
	@ResponseBody
	public Map<String,Object> messageListPage(@RequestParam(defaultValue="1") int cPage,  @RequestParam("empName") String empName, HttpServletResponse rexsponse) {
		try {
			List<Message> list = new ArrayList<>();
			final int numPerPage = 7;
			int totalContents = 0;
			list = messageService.selectMessageAllList(cPage,numPerPage,empName);  
			totalContents = messageService.selectAllCountByAccountNo(empName); 
			String url = "messageListPage.do?empName="+empName;
			String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
			
			Map<String,Object> map = new HashMap<>();
			map.put("numPerPage",numPerPage);
			map.put("cPage",cPage);
			map.put("totalContents",totalContents);
			map.put("list",list);
			map.put("pageBar", pageBar);
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/message/messageConfirmPage.do")
	@ResponseBody
	public Map<String,Object> messageConfirmPage(@RequestParam(defaultValue="1") int cPage,  @RequestParam("empName") String empName, HttpServletResponse rexsponse) {
		try {
			List<Message> list = new ArrayList<>();
			final int numPerPage = 7;
			int totalContents = 0;
			list = messageService.messageConfirmPage(cPage,numPerPage,empName);  
			totalContents = messageService.selectAllCountmessageConfirmPage(empName); 
			String url = "messageConfirmPage.do?empName="+empName;
			String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
			
			Map<String,Object> map = new HashMap<>();
			map.put("numPerPage",numPerPage);
			map.put("cPage",cPage);
			map.put("totalContents",totalContents);
			map.put("list",list);
			map.put("pageBar", pageBar);
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/message/messageNoConfirmPage.do")
	@ResponseBody
	public Map<String,Object> messageNoConfirmPage(@RequestParam(defaultValue="1") int cPage,  @RequestParam("empName") String empName, HttpServletResponse rexsponse) {
		try {
			List<Message> list = new ArrayList<>();
			final int numPerPage = 7;
			int totalContents = 0;
			list = messageService.messageNoConfirmPage(cPage,numPerPage,empName);  
			totalContents = messageService.selectAllCountmessageNoConfirmPage(empName); 
			String url = "messageNoConfirmPage.do?empName="+empName;
			String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
			
			Map<String,Object> map = new HashMap<>();
			map.put("numPerPage",numPerPage);
			map.put("cPage",cPage);
			map.put("totalContents",totalContents);
			map.put("list",list);
			map.put("pageBar", pageBar);
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/message/messageSenderFormPage.do")
	@ResponseBody
	public Map<String,Object> messageSenderFormPage(@RequestParam(defaultValue="1") int cPage,  @RequestParam("empName") String empName, HttpServletResponse rexsponse) {
		
		try {
			List<Message> list = new ArrayList<>();
			final int numPerPage = 7;
			int totalContents = 0;
			list = messageService.messageSenderFormPage(cPage,numPerPage,empName);  
			totalContents = messageService.selectAllCountmessageSenderFormPage(empName); 
			String url = "messageSenderFormPage.do?empName="+empName;
			String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
			
			Map<String,Object> map = new HashMap<>();
			map.put("numPerPage",numPerPage);
			map.put("cPage",cPage);
			map.put("totalContents",totalContents);
			map.put("list",list);
			map.put("pageBar", pageBar);
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/message/insertMessageForm.do")
	public ModelAndView insertMessageForm(ModelAndView mav) {
		try {
			mav.setViewName("message/insertMessageForm");
			return mav;
		}catch(Exception e) {
			throw e;
		}
	}
	@RequestMapping("/message/messageSelectList.do")
	public ModelAndView messageSelectList(ModelAndView mav) {
		try {
			mav.setViewName("message/messageSelectList");
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/message/answerMessageForm.do")
	public ModelAndView answerMessage(ModelAndView mav, @RequestParam("sender") String sender) {
		try {
			mav.addObject("sender",sender);
			mav.setViewName("message/answerMessageForm");
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/message/insertMessage.do")
	@ResponseBody
	public Map<String,Object> insertMessage(@RequestParam("empName") String empName, @RequestParam("insertSender") String insertSender,
									@RequestParam("meTitle") String meTitle, @RequestParam("messageContent") String messageContent,HttpServletResponse rexsponse){
		try {
			Message message = new Message(0, meTitle,empName,insertSender,messageContent,"n",null);
			int result = messageService.insertMessage(message);
			Map<String,Object> map = new HashMap<>();
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/message/detailMessageForm.do")
	public ModelAndView detailMessageForm(ModelAndView mav, @RequestParam("meNo") int meNo, @RequestParam("empName") String empName) {
		try {
			Message message = new Message();
			message = messageService.detailMessage(meNo);
			if(message.getReciever().equals(empName)) {
				int result = messageService.updateMessage(meNo);
			}
			mav.addObject("message",message);
			mav.setViewName("message/detailMessageForm");
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
		
	@RequestMapping("/message/messageCount.do")
	@ResponseBody
	public Map<String,Integer> messageCount(@RequestParam("empName") String empName) {
		try {
			int messageCount = messageService.selectAllCountmessageNoConfirmPage(empName);
			Map<String, Integer> map = new HashMap<>();
			map.put("messageCount", messageCount);
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
}

