package com.dev.erp.purchase.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.purchase.model.service.PurchaseService;

@Controller
public class PurchaseController {

	@Autowired
	PurchaseService perchaseservice;
	
	static final Logger logger = LoggerFactory.getLogger(PurchaseController.class);
	
	
	@RequestMapping("/purchase/purchaseView.do")
	public ModelAndView selectPurchaseList(ModelAndView mav) {
		
		List<Map<String, String>> purchaseList = perchaseservice.selectPurchaseList();
		
		logger.info("purchaseList@Controller={}", purchaseList);
		
		mav.addObject("purchaseList", purchaseList);
		mav.setViewName("/purchase/purchaseView");
		
		return mav;
	}
	
	
	@RequestMapping("/purchase/purchaseInsertView.do")
	public ModelAndView selectPurchaseInsertList (ModelAndView mav) {
		
		List<Map<String, String>> purchaseInsertList = perchaseservice.selectPurchaseInsertList();
		
		logger.info("purchaseList@Controller={}", purchaseInsertList);
		
		mav.addObject("purchaseInsertList", purchaseInsertList);
		mav.setViewName("/purchase/purchaseInsertView");
		
		return mav;
	}
	
	
	
	// 모달 페이지 이동 컨트롤러
	
	@RequestMapping("/purchase/modalPurchaseInsert.do")
	public ModelAndView modalRmSnrInsert(ModelAndView mav) {
		
		mav.setViewName("/purchase/modalPurchaseInsert");
		
		return mav;
	}
	@RequestMapping("/purchase/modalPurchaseUpdate.do")
	public ModelAndView modalRmSnrUpdate(ModelAndView mav) {
		
		mav.setViewName("/purchase/modalPurchaseUpdate");
		
		return mav;
	}
	@RequestMapping("/purchase/modalPurchaseDelete.do")
	public ModelAndView modalRmSnrDelete(ModelAndView mav) {
		
		mav.setViewName("/purchase/modalPurchaseDelete");
		
		return mav;
	}
	
	
	// 모달 페이지에서 결과값 전송 컨트롤러
	@RequestMapping("/purchase/InsertPurchase.do")
	public ModelAndView InsertRm(@RequestParam String rmNo,
									@RequestParam String vendorNo,
									@RequestParam String purchaseAmount,
									ModelAndView mav) {

		Map<String, String> purchase = new HashMap<>();
		purchase.put("rmNo", rmNo);
		purchase.put("vendorNo", vendorNo);
		purchase.put("purchaseAmount", purchaseAmount);
		
		logger.info("purchase@controller={}",purchase);
		
		int result = perchaseservice.InsertPurchase(purchase); 
		int result2 = perchaseservice.UpdatePurchase(purchase); 
		
		
		logger.info("result@Controller={}",result);
		logger.info("result@Controller={}",result2);
		
		mav.setViewName("redirect:/purchase/purchaseInsertView.do");
		
		return mav;
	}
	
}

