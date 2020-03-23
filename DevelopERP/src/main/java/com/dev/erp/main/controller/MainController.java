package com.dev.erp.main.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.common.exception.MyException;
import com.dev.erp.schedule.model.service.ScheduleService;
import com.dev.erp.schedule.model.vo.Schedule;

@Controller
public class MainController {
	
	
	@Autowired
	ScheduleService scheduleService ;
	
	
	@RequestMapping("/main/main.do")
	public ModelAndView mainPage(ModelAndView mav,@RequestParam(value="email") String email) {
		try {
		List<Schedule> list= scheduleService.getSchedule(email);
		
		String content="";
		
		for(Schedule s:list) {
			
				content+=",{title:'"+s.getTitle()+"',start:'"+s.getStartScheduleTime()+"',end:'"+s.getEndScheduleTime()+"'}";
		}
		
		mav.addObject("content",content);
		
		mav.setViewName("main/main");
		return mav;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}

	
}

