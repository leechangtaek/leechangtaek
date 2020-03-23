package com.dev.erp.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 
 * preHandle: DispatcherServlet이 controller handler 호출전.
 * postHandle: handler에서 DispatcherServlet으로 리턴되기 전(ModelAndView객체 접근 가능)
 * afterCompletion: view단에서 최종결과생성 완료후에 실행됨.
 *
 */
public class LoggerInterceptor extends HandlerInterceptorAdapter {

	final static Logger logger 
		= LoggerFactory.getLogger(LoggerInterceptor.class);
	
	public LoggerInterceptor() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if(logger.isDebugEnabled()) {
			logger.debug("================== HANDLER ==================");
			logger.debug(request.getRequestURI());
			logger.debug("---------------------------------------------");
			
		}
		
		//true를 리턴해야 정상진행됨.
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		super.postHandle(request, response, handler, modelAndView);

		if(logger.isDebugEnabled()) {
			logger.debug("mav={}", modelAndView);
			logger.debug("-------------------- VIEW -------------------");
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		if(logger.isDebugEnabled()) {
			logger.debug("______________________ END ____________________");
		}
		super.afterCompletion(request, response, handler, ex);
	}
	
	

}
