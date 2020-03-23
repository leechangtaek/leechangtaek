package com.dev.erp.messenger.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.common.exception.MyException;
import com.dev.erp.common.util.Utils;
import com.dev.erp.member.model.vo.Member;
import com.dev.erp.messenger.model.service.MessengerService;
import com.dev.erp.messenger.model.vo.ChatRoom;
import com.dev.erp.messenger.model.vo.Msg;

@Controller
public class MessengerController {

static final Logger logger = LoggerFactory.getLogger(MessengerController.class);
	
	@Autowired
	MessengerService messengerService;
	
	/**
	 * 인자로 전달될 길이의 임의의 문자열을 생성하는 메소드
	 * 영대소문자/숫자의 혼합.
	 * 
	 * @param len
	 * @return
	 */
	private String getRandomChatId(int len){
		try {
			Random rnd = new Random();
			StringBuffer buf =new StringBuffer();
			buf.append("chat_");
			for(int i=0;i<len;i++){
				//임의의 참거짓에 따라 참=>영대소문자, 거짓=> 숫자
			    if(rnd.nextBoolean()){
			    	boolean isCap = rnd.nextBoolean();
			        buf.append((char)((int)(rnd.nextInt(26))+(isCap?65:97)));
			    }
			    else{
			        buf.append((rnd.nextInt(10))); 
			    }
			}
			return buf.toString();
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	/**
	 * - @MessageMapping 을 통해 메세지를 받고,
	 * - @SendTo 를 통해 메세지 전달. 작성된 주소를 구독하고 있는 client에게 메세지 전송
	 * 
	 * @param fromMessage
	 * @return
	 */
	@MessageMapping("/hello")
	@SendTo("/hello")
	public Msg stomp(Msg fromMessage,
					 @Header("simpSessionId") String sessionId,//WesocketSessionId값을 가져옴.
					 SimpMessageHeaderAccessor headerAccessor//HttpSessionHandshakeInterceptor빈을 통해 httpSession의 속성에 접근 가능함.
					 ){
		try {
			//httpSession속성 가져오기 테스트: 필요에 따라 httpSession속성을 사용할 수 있다. 
			String sessionIdFromHeaderAccessor = headerAccessor.getSessionId();//@Header sessionId와 동일
			Map<String,Object> httpSessionAttr = headerAccessor.getSessionAttributes();
			Member member = (Member)httpSessionAttr.get("memberLoggedIn");
			String httpSessionId = (String)httpSessionAttr.get("HTTP.SESSION.ID");//비회원인 경우 memberId로 사용함.
			
			return fromMessage; 
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	@MessageMapping("/chat/{chatId}")
	@SendTo(value={"/chat/{chatId}","/chat/{email}"})
	public Msg sendEcho(Msg fromMessage, 
						@DestinationVariable String chatId, 
						@Header("simpSessionId") String sessionId){
		try {
			messengerService.insertChatLog(fromMessage);
			return fromMessage; 
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	

	/**
	 * 읽음 여부 확인을 위해 최종 focus된 시각정보를 수집한다.
	 * 
	 * @param fromMessage
	 * @return
	 */
	@MessageMapping("/lastCheck")
	@SendTo(value={"/chat/{chatId}"})
	public Msg lastCheck(@RequestBody Msg fromMessage){
		try {
			messengerService.updateLastCheck(fromMessage);
			
			return fromMessage; 
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("messenger/messengerSelectList.do")
	public ModelAndView messengerSelectList(ModelAndView mav) {
		try {
			mav.setViewName("messenger/messengerSelectList");
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
		
	}
	
	@GetMapping("/messenger/messengerList.do")
	public void messengerList(Model model, 
					  HttpSession session, 
					  @SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn){
		try {
			String email = Optional.ofNullable(memberLoggedIn).map(Member::getEmail)
																 .orElseThrow(IllegalStateException::new);
			List<Map<String,String>> chatIdList = messengerService.findChatIdList(email);
			List<Map<String, String>> recentList =new ArrayList<>();
			List<Map<String, String>> sumList =new ArrayList<>();
			for(int i=0; i<chatIdList.size(); i++) {
				String chatId = ((Map<String,String>)chatIdList.get(i)).get("CHATID");
				Map<String,String> param = new HashMap<>();
				param.put("email", email);
				param.put("chatId", chatId);
				recentList = messengerService.findRecentList(param);
				if(recentList.size()>0) {
					sumList.add(recentList.get(0));
				}
			}
			model.addAttribute("recentList", sumList);
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
		
	}
	
	@GetMapping("/messenger/{chatId}/messengerChat.do")
	public String messengerChat(@PathVariable("chatId") String chatId, Model model, HttpSession session, 
			  @SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn){
		try {
			String email = Optional.ofNullable(memberLoggedIn).map(Member::getEmail)
					 .orElseThrow(IllegalStateException::new);
			List<Map<String,String>> chatList = messengerService.findChatListByChatId(chatId);
			Msg fromMessage = new Msg(0,chatId,email,"",0, null);
			int result = messengerService.updateLastCheckLog(fromMessage);
			
			model.addAttribute("chatList", chatList);
			logger.debug("chatList={}",chatList);
			return "messenger/messengerChat";
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	@RequestMapping("/messenger/messengerListPage.do")
	@ResponseBody
	public Map<String,Object> messengerListPage(@RequestParam(defaultValue="1") int cPage,  HttpServletResponse rexsponse,
										HttpSession session, @SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn) {
		
		try {
			List<Map<String,String>> list = new ArrayList<>();
			final int numPerPage = 7;
			int totalContents = 0;
			String email = Optional.ofNullable(memberLoggedIn).map(Member::getEmail)
					 .orElseThrow(IllegalStateException::new);
			
			list = messengerService.selectMemberList(cPage,numPerPage, email);  
			totalContents = messengerService.selectAllCountByAccountNo(); 
			String url = "messengerListPage.do?";
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
	@RequestMapping("/messenger/makeChatRoom.do")
	@ResponseBody
	public Map<String,Object> makeChatRoom(@RequestParam("email") String email,
									HttpSession session, HttpServletResponse rexsponse, 
			  @SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn) {
		
		try {
			String sessionEmail = Optional.ofNullable(memberLoggedIn).map(Member::getEmail)
					 .orElseThrow(IllegalStateException::new);
			String chatId=null;
			chatId = getRandomChatId(15);//chat_randomToken -> jdbcType=char(20byte)
			
			List<ChatRoom> list = new ArrayList<>();
			list.add(new ChatRoom(chatId, email, 0, "Y", null, null));
			list.add(new ChatRoom(chatId, sessionEmail,0, "Y", null, null));
			messengerService.insertChatRoom(list);
			Map<String,Object> map = new HashMap<>();
			map.put("chatId",chatId);
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/messenger/messengerCount.do")
	@ResponseBody
	public Map<String,Integer> messengerCount(HttpSession session, 
			  @SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn){
		try {
			String email = Optional.ofNullable(memberLoggedIn).map(Member::getEmail)
							 .orElseThrow(IllegalStateException::new);
			List<Map<String,String>> chatIdList = messengerService.findChatIdList(email);
			List<Integer> recentList =new ArrayList<>();
			int messengerCount=0;
			for(int i=0; i<chatIdList.size(); i++) {
				String chatId = ((Map<String,String>)chatIdList.get(i)).get("CHATID");
				Map<String,String> param = new HashMap<>();
				param.put("email", email);
				param.put("chatId", chatId);
				recentList = messengerService.messengerCount(param);
				for(int j=0; j<recentList.size(); j++) {
					messengerCount += (Integer)recentList.get(j);
				}
			}
			Map<String,Integer> map = new HashMap<>();
			map.put("messengerCount",messengerCount);
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	
	
	
	
	
	
	
	
	
}
