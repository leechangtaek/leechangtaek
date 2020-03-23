package com.dev.erp.schedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.common.exception.MyException;
import com.dev.erp.member.model.vo.Member;
import com.dev.erp.schedule.model.service.ScheduleService;
import com.dev.erp.schedule.model.vo.Schedule;

@Controller
public class ScheduleController {
	static final Logger logger = LoggerFactory.getLogger(ScheduleController.class);
	@Autowired ScheduleService scheduleService;

	@RequestMapping("schedule/schedule.do")
	public ModelAndView schedule(ModelAndView mav,@RequestParam String date) {
		try {
		mav.addObject("date",date);
		mav.setViewName("main/schedule");
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("schedule/scheduleInsert.do")
	public ModelAndView insertSchedule(ModelAndView mav,Schedule schedule) {
		try {
		System.out.println("fdsaf"+schedule);
		String date=schedule.getEndScheduleTime()+" "+schedule.getEndTime();
		schedule.setEndScheduleTime(date);
		date=schedule.getStartScheduleTime()+" "+schedule.getStartTime();
		schedule.setStartScheduleTime(date);
		int result=scheduleService.insertSchedule(schedule);

		mav.addObject("loc", "/main/main.do?email="+schedule.getEmail());
		
			mav.addObject("msg", result>0?"등록 성공!":"등록 실패!");
			mav.setViewName("common/msg");
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	@RequestMapping("schedule/schedulList.do")
	@ResponseBody
	public List<Schedule> scheduleList(ModelAndView mav,@RequestParam String date,@RequestParam String email) {
		try {
		System.out.println("aaaaaaadffffffffsadf"+date);
		System.out.println("aaaaaaadffffffffsadf"+email);
		Map<String,Object> map = new HashMap<>();
		map.put("date",date);
		map.put("email",email);
		List<Schedule> list=scheduleService.scheduleList(map);
		System.out.println("SADdddddddd"+list);
	
		return list;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("schedule/scheduleManage.do")
	public ModelAndView scheduleManage(ModelAndView mav,@RequestParam String date) {
		try {
		mav.addObject("date",date);
		mav.setViewName("main/scheduleManage");
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("/schedule/scheduleManageList.do")
	@ResponseBody
	public List<Schedule> scheduleManageList(ModelAndView mav,@RequestParam String date,@RequestParam String email) {
		try {
		System.out.println("fazdfdfdf"+date);
		System.out.println("aaaaaaadffffffffsadf"+email);
		Map<String,Object> map = new HashMap<>();
		map.put("date",date);
		map.put("email",email);
		List<Schedule> list=scheduleService.scheduleList(map);
		System.out.println("SADdddddddd"+list);
	
		return list;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
//	@RequestMapping("schedule/scheduleManage.do")
//	public ModelAndView scheduleManage(ModelAndView mav,@RequestParam String date,@RequestParam String email) {
//		System.out.println(date);
//		System.out.println(email);
//		Map<String,Object> map = new HashMap<>();
//		map.put("date",date);
//		map.put("email",email);
//		List<Schedule> list=scheduleService.scheduleList(map);
//		System.out.println("dfd"+list);
//		mav.addObject("list",list);
//		mav.setViewName("main/scheduleManage");
//		return mav;
//	}
	@RequestMapping("schedule/scheduleDelete.do")
	public ModelAndView scheduleDelete(ModelAndView mav,Schedule schedule,@SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn)
	{
		try {
		String email = Optional.ofNullable(memberLoggedIn).map(Member::getEmail)
				 .orElseThrow(IllegalStateException::new);
	System.out.println("SADfasd"+schedule);
	int result=scheduleService.scheduleDelete(schedule);
	mav.addObject("loc", "/main/main.do?email="+email);
	
	mav.addObject("msg", result>0?"삭제 성공!":"삭제 실패!");
	mav.setViewName("common/msg");
	return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	
	@RequestMapping("schedule/scheduleModify.do")
	public ModelAndView scheduleModify(ModelAndView mav,Schedule schedule,String []title1,String []content1) {
		try {
		System.out.println("Fsadfasd"+schedule);
		String title="";
		String content="";
		for(int i=0;i<title1.length;i++)
		{
			title+=title1[i];
			title+=" ";
		}
		for(int i=0;i<content1.length;i++)
		{
			content+=content1[i];
			content+=" ";
		}
		schedule.setStartTime(schedule.getStartTime().substring(0, 5));
		schedule.setEndTime(schedule.getEndTime().substring(0,5));
		schedule.setContent(content);
		schedule.setTitle(title);
		System.out.println(title);
		System.out.println("dfdfdf"+content);
		mav.addObject("schedule",schedule);
		mav.setViewName("main/scheduleModify");
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	@RequestMapping("schedule/scheduleUpdate.do")
	public ModelAndView scheduleUpdate(ModelAndView mav,Schedule schedule1,Schedule schedule) {
		try {
		String date=schedule.getEndScheduleTime()+" "+schedule.getEndTime();
		schedule.setEndScheduleTime(date);
		date=schedule.getStartScheduleTime()+" "+schedule.getStartTime();
		schedule.setStartScheduleTime(date);
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaa"+schedule);
		System.out.println("bbbbbbbbbbbb"+schedule1);
		int result =scheduleService.scheduleUpdate(schedule);
		mav.addObject("loc", "/main/main.do?email="+schedule.getEmail());
		
		mav.addObject("msg", result>0?"수정 성공!":"수정 실패!");
		mav.setViewName("common/msg");
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	
}
