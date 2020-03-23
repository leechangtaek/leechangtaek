package com.dev.erp.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.dev.erp.member.model.vo.Member;


public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	/**
	 * @실습문제: 로그인하지 않은 경우, 
	 * common/msg.jsp를 통해 "로그인 후 이용하세요"경고창 출력, index페이지로 이동시킨다.
	 * 
	 * 
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
					throws Exception {
		HttpSession session = request.getSession();
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		
		if(memberLoggedIn == null) {
			request.setAttribute("msg", "로그인후 이용하세요.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
				   .forward(request, response);
			
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}
	
	
	
}
