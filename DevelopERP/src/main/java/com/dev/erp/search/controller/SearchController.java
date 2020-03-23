package com.dev.erp.search.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dev.erp.common.exception.MyException;
import com.dev.erp.search.model.service.SearchService;

@Controller
public class SearchController {

	@Autowired
	SearchService searchService;
	
	
	@RequestMapping("/search/headerSearch.do")
	@ResponseBody
	public Map<String,Object> headerSearch( @RequestParam ("srchName") String srchName ,HttpServletResponse response){
		try {
			Map<String,Object> map = new HashMap<>();
			List<Map<String,String>> list = new ArrayList<>();
			list = searchService.searchList(srchName);
			StringBuilder csv = new StringBuilder();
			if(list!=null && !list.isEmpty()){
				for(int i=0; i< list.size(); i++){
					csv.append("<span id="+"searchIcon"+"></span>"+list.get(i).get("SEARCH_NAME")+"<hr>^");
					if(i==2) {
						break;
					}
				}
			}
			map.put("csv", csv);
			return map;
		}catch(Exception e) {
			throw new MyException("조회 실패! 관리자에게 문의하세요!");
		}
	}
	
	@RequestMapping("/search/searchKeywordInfo.do")
	@ResponseBody
	public Map<String,Object> searchKeywordInfo(ModelAndView mav, @RequestParam("searchKeyword") String searchKeyword,HttpServletResponse response) {
		Map<String,Object> map = new HashMap<>();
		map = searchService.searchKeywordInfo(searchKeyword);
		return map;
	}
}

