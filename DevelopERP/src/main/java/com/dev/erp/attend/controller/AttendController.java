package com.dev.erp.attend.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.attend.model.service.AttendService;
import com.dev.erp.attend.model.vo.Attend;
import com.dev.erp.common.exception.MyException;
import com.dev.erp.member.model.vo.Member;


@Controller
public class AttendController {
	@Autowired
	AttendService attendService;

	static final Logger logger 
	= LoggerFactory.getLogger(AttendController.class);

	@RequestMapping("/attend/attendList.do")
	public ModelAndView attendList(ModelAndView mav, HttpSession session, 
			  @SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn) {
		try {
			String email = Optional.ofNullable(memberLoggedIn).map(Member::getEmail)
						 .orElseThrow(IllegalStateException::new);
			List<Attend> list= attendService.attendShow(email);
			String content="";
			System.out.println("aaaaaaaaaaaaa"+list);
			for(Attend a:list) {
				if(a.getReason()!=null)
				if(a.getEarlyAttend()!=null)
				{
					content+=",{title:'*조퇴 사유 :"+a.getReason()+"',start:'"+a.getEarlyAttendForm()+"'}";
					content+=",{title:'*조퇴 시간 :"+a.getEarlyAttend().substring(11,16)+"',start:'"+a.getEarlyAttendForm()+"'}";
				}
				else if(a.getReason().equals("휴가"))
				{
					
					content+=",{title:'휴가',start:'"+a.getAttendStartForm()+"',end:'"+a.getAttendEndForm()+"'}";
				}
				if(a.getReason()==null) {
				if(a.getAttendStart()!=null)
					content+=",{title:'-출근 시간:"+a.getAttendStart().substring(11,16)+"',start:'"+a.getAttendStartForm()+"'}";
				if(a.getAttendEnd()!=null)
					content+=",{title:'-퇴근 시간:"+a.getAttendEnd().substring(11,16)+"',start:'"+a.getAttendEndForm()+"'}";
				}
			}
	
			mav.addObject("content",content);
			mav.setViewName("gw/attendCal");
			return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
//	@RequestMapping("/attend/attendShow.do")
//	@ResponseBody
//	public Map<String,String> attendShow(ModelAndView mav,@RequestParam String email) {
//		List<Attend> list= attendService.attendShow(email);
//		String content="";
//		for(Attend a:list) {
//			if(a.getAttendStart()!=null)
//				content+=",{title:'출근',start:'"+a.getAttendStartForm()+"'},{title:'"+a.getAttendStart()+"',start:'"+a.getAttendStartForm()+"'}";
//
//		}   	
//		System.out.println(content);
//		Map<String,String> map =new HashMap<>();
//		map.put("content",content);
//
//		return map;
//
//	}
	@RequestMapping("/attend/attendForm.do")
	public ModelAndView showAttendForm(ModelAndView mav, @RequestParam String date,@RequestParam String email
			) {
		try {
		Attend attend = new Attend(email, "",date,"","","","","","");
		Attend end=new Attend(email,"","","",date,"","","","");
		Attend early=new Attend(email,"","","","","",date,"","");
		Attend holiday=new Attend(email,"",date,"","","","","","");
		String attendDate=attendService.checkAttend(attend);
		String endDate=attendService.checkend(end);
		String earlyDate=attendService.checkearly(early);
		String holidayInfo=attendService.checkholiday(holiday);
		System.out.println("dfdf"+holidayInfo);
		mav.addObject("date",date);
		mav.addObject("attendDate",attendDate);
		mav.addObject("endDate",endDate);
		mav.addObject("earlyDate",earlyDate);
		mav.addObject("holidayInfo",holidayInfo);
		mav.setViewName("gw/attendForm");
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
		
		

	}
	@RequestMapping("/attend/attendant.do")
	public ModelAndView attendant(ModelAndView mav, @RequestParam String date,@RequestParam String email) {
		try {
		mav.addObject("loc", "/attend/attendList.do?email=${memberLoggedIn.email]");
		String script="";
		
			int result=attendService.attendant(email);
			script = "self.close(); opener.location.reload(true)";
			mav.addObject("msg", result>0?"출근 처리 완료!":"출근 처리 실패!");
			mav.addObject("script",script);
			mav.setViewName("common/msg");
		
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}

	}
	@RequestMapping("/attend/leave.do")
	public ModelAndView leave(ModelAndView mav, @RequestParam String date,@RequestParam String email) {
	try {
		String script = "self.close(); opener.location.reload(true)";
		mav.addObject("script",script);
		mav.addObject("loc", "/attend/attendList.do?email=${memberLoggedIn.email]");
		
			int result=attendService.leave(email);
			mav.addObject("msg", result>0?"퇴근 처리 완료!":"퇴근 처리 실패!");
			mav.setViewName("common/msg");
		return mav;
	}catch(Exception e) {
		throw new MyException("조회 실패! 관리자에게 문의하세요!");
	}

	}
	@RequestMapping("/attend/earlyleave.do")
	public ModelAndView earlyLeave(ModelAndView mav,@RequestParam String reason,@RequestParam String email) {
		try {
		Attend attend=new Attend(email,"","","","","","","",reason);
		int result=attendService.earlyLeave(attend);
		String script = "self.close(); opener.location.reload(true)";
		mav.addObject("script",script);
		mav.addObject("loc", "/attend/attendList.do?email=${memberLoggedIn.email]");
			mav.addObject("msg", result>0?"조퇴 처리 완료!":"조퇴 처리 실패!");
			mav.setViewName("common/msg");
		
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/attend/test.do")
	public ModelAndView test(ModelAndView mav) {
		try {
		mav.setViewName("gw/test");
		
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
}
