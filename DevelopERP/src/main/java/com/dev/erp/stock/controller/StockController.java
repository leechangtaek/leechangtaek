package com.dev.erp.stock.controller;

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

import com.dev.erp.common.util.Utils;
import com.dev.erp.stock.model.service.StockService;
import com.google.gson.Gson;

@Controller
public class StockController {

	@Autowired
	StockService stockservice;
	
	static final Logger logger = LoggerFactory.getLogger(StockController.class);
	
	// ========================================= 원재료 재고관리 파트 =========================================
	@RequestMapping("/stock/rm/rmView.do")
	public ModelAndView selectRmStockList(ModelAndView mav) {
		
		List<Map<String, String>> rmList = stockservice.selectRmStockList();
		List<Map<String, String>> rmTotalList = stockservice.selectRmTotalList();
		
		String json = new Gson().toJson(rmTotalList);
		
		logger.info("rmList@Controller={}", rmList);
		logger.info("rmTotalList@Controller={}", rmTotalList);
		
		mav.addObject("rmTotalList",json);  
		mav.addObject("rmList", rmList);
		mav.setViewName("/stock/rm/rmView");
		
		return mav;
	}

	
	@RequestMapping("/stock/rm/rmSnrView.do")
	public ModelAndView selectRmSnrStockList(ModelAndView mav) {
		
		List<Map<String, String>> rmSnrList = stockservice.selectRmSnrStockList();
		
		logger.info("rmSnrList@Controller={}", rmSnrList);
		
		mav.addObject("rmSnrList", rmSnrList);
		mav.setViewName("/stock/rm/rmSnrView");
		
		return mav;
	}
	
	

	@RequestMapping("/stock/rm/modalRmSnrInsert.do")
	public ModelAndView modalRmSnrInsert(ModelAndView mav) {
		
		mav.setViewName("/stock/rm/modalRmSnrInsert");
		
		return mav;
	}
	@RequestMapping("/stock/rm/modalRmSnrUpdate.do")
	public ModelAndView modalRmSnrUpdate(ModelAndView mav) {
		
		mav.setViewName("/stock/rm/modalRmSnrUpdate");
		
		return mav;
	}
	@RequestMapping("/stock/rm/modalRmSnrDelete.do")
	public ModelAndView modalRmSnrDelete(ModelAndView mav) {
		
		mav.setViewName("/stock/rm/modalRmSnrDelete");
		
		return mav;
	}
	
	// rmNo storeNo ptNo quantity recDate
	@RequestMapping("/stock/rm/InsertRm.do")
	public ModelAndView InsertRm(@RequestParam String rmNo,
									@RequestParam String quantity,
									@RequestParam String recDate,
									ModelAndView mav) {

		Map<String, String> recieving = new HashMap<>();
		recieving.put("rmNo", rmNo);
		recieving.put("quantity", quantity);
		recieving.put("recDate", recDate);
		
		logger.info("rawMaterial@controller={}",recieving);
		
		int result = stockservice.InsertRm(recieving); 
		
		logger.info("result@Controller={}",result);
		
		mav.setViewName("redirect:/stock/rm/rmSnrView.do");
		
		return mav;
	}
	
	@RequestMapping("/stock/rm/UpdateRm.do")
	public ModelAndView UpdateRm(@RequestParam String lotNo,
									@RequestParam String quantity,
									@RequestParam String recDate,
									ModelAndView mav) {

		Map<String, String> recieving = new HashMap<>();
		recieving.put("lotNo", lotNo);
		recieving.put("quantity", quantity);
		recieving.put("recDate", recDate);
		
		logger.info("rawMaterial@controller={}",recieving);
		
		int result = stockservice.UpdateRm(recieving); 
		
		logger.info("result@Controller={}",result);
		
		mav.setViewName("redirect:/stock/rm/rmSnrView.do");
		
		return mav;
	}
	
	@RequestMapping("/stock/rm/DeleteRm.do")
	public ModelAndView DeleteRm(@RequestParam String lotNo,
									@RequestParam String quantity,
									@RequestParam String recDate,
									ModelAndView mav) {

		Map<String, String> recieving = new HashMap<>();
		recieving.put("lotNo", lotNo);
		recieving.put("quantity", quantity);
		recieving.put("recDate", recDate);
		
		logger.info("rawMaterial@controller={}",recieving);
		
		int result = stockservice.DeleteRm(recieving); 
		
		logger.info("result@Controller={}",result);
		
		mav.setViewName("redirect:/stock/rm/rmSnrView.do");
		
		return mav;
	}
	
	
	
	
	
	
	
	// ========================================= 완제품 관리 =========================================
	@RequestMapping("/stock/product/productView.do")
	public ModelAndView selectProductStockList(ModelAndView mav) {
		
		List<Map<String, String>> productList = stockservice.selectProductStockList();
		
		logger.info("productList@Controller={}", productList);
		
		mav.addObject("productList",productList);
		mav.setViewName("/stock/product/productView");
		
		return mav;
		
	}
	
	@RequestMapping("/stock/product/productTotalView.do")
	public ModelAndView selectProductStockTotalList(ModelAndView mav) {
		
		List<Map<String, String>> productTotalList = stockservice.selectProductStockTotalList();
		
		String json = new Gson().toJson(productTotalList);
		
		mav.addObject("productTotalList",productTotalList);
		mav.addObject("productTotalList2",json);  
		mav.setViewName("/stock/product/productTotalView");
		
		return mav;
		
	}
	
	@RequestMapping("/stock/product/modalProductInsert.do")
	public ModelAndView modalProductInsert(ModelAndView mav) {
		
		mav.setViewName("/stock/product/modalProductInsert");
		
		return mav;
	}
	
	@RequestMapping("/stock/rm/modalProductSearch.do")
	public ModelAndView modalProductSearch(ModelAndView mav) {
		
		mav.setViewName("/stock/rm/modalProductSearch");
		
		return mav;
	}
	
	// ========================================= 창고별 재고 관리 =========================================
	@RequestMapping("/stock/storage/storageView.do")
	public ModelAndView selectStorageStockList(ModelAndView mav, @RequestParam("storeNo") String storeNo) {
	
		List<Map<String, String>> storageStockList;
		List<Map<String, String>> storageList;
		List<Map<String, String>> storageTotalList = stockservice.storageTotalList();

		String json = new Gson().toJson(storageTotalList);

		
		if(storeNo.equals("0"))
			storageStockList = stockservice.allStorageStockList();
		else
			storageStockList = stockservice.selectStorageStockList(storeNo);
		
		storageList = stockservice.storageList();
		
		
		logger.info("storageList@Controller={}", storageStockList);
		
		
		mav.addObject("storageTotalList",json);  
		mav.addObject("storageStockList", storageStockList);
		mav.addObject("storageList", storageList);
		mav.setViewName("/stock/storage/storageView");
		
		return mav;
		
	}
	
	
	
	// ========================================= searchSpecify Controller =========================================
	

	@RequestMapping("/stock/common/searchSpecify.do")
	public ModelAndView searchSpecify(ModelAndView mav, @RequestParam("searchType") String searchType) {
		
		mav.addObject("searchType",searchType);
		mav.setViewName("/stock/common/searchSpecify");
		
		return mav;
	}
	
	@RequestMapping("/stock/common/searchSpecifyPage.do")
	@ResponseBody
	public Map<String,Object> searchSpecify(@RequestParam("searchType") String searchType, @RequestParam(defaultValue="1") int cPage, HttpServletResponse rexsponse) {
		logger.info("SEARCHTYPE@CONTROLLER={}",searchType);
		List<Map<String,String>> list = new ArrayList<>();
		final int numPerPage = 5;
		int totalContents = 0;
		switch(searchType) {
		case "rmNo" :  
			list =  stockservice.selectRawmaterialAll(cPage,numPerPage); 
			totalContents = stockservice.selectAllRawmaterialNo();
			break;
		case "storeNo" : 
			list = stockservice.selectStorageAll(cPage,numPerPage);  
			totalContents = stockservice.selectAllCountByStorageNo(); 
			break;
		case "ptNo" :  
			list =  stockservice.selectProductTypeAll(cPage,numPerPage); 
			totalContents = stockservice.selectAllCountByProductNo();
			break;
		
		case "lotNo" :  
			list =  stockservice.selectRecievingtypeAll(cPage,numPerPage); 
			totalContents = stockservice.selectRecievingCountByLotNo();
			break;

		}
		String url = "searchSpecifyPage.do?searchType="+searchType;
		String pageBar = Utils.getPageBar(totalContents, cPage, numPerPage, url);
		
		Map<String,Object> map = new HashMap<>();
		map.put("numPerPage",numPerPage);
		map.put("cPage",cPage);
		map.put("totalContents",totalContents);
		map.put("searchType",searchType);
		map.put("speclist",list);
		map.put("pageBar", pageBar);
		return map;
	}
	
	
	
	
	
	
	
}
