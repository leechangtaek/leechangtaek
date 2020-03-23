package com.dev.erp.common.aop;

import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.member.model.vo.Member;


@Component
@Aspect
public class AfterMemberLoginAspect {

	static final Logger logger = LoggerFactory.getLogger(AfterMemberLoginAspect.class);
	
	@AfterReturning(pointcut="execution(* com.dev.erp.member.controller.MemberController.memberLogin(..))", returning="returnObj")
	public void afterReturning(JoinPoint joinPoint, Object returnObj) {
		
		logger.debug("returnObj={}",returnObj);
		
		ModelAndView mav = (ModelAndView)returnObj;
		Map<String, Object> map = mav.getModel();
		
		if(map.containsKey("memberLoggedIn")) {
			Member memberLoggedIn = (Member)map.get("memberLoggedIn");
			logger.info("[{}]님이 로그인하셨습니다.",memberLoggedIn.getEmail());
		}
	}
}
