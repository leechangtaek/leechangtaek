package com.dev.erp.search.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.search.model.dao.SearchDAO;

@Service
public class SearchServiceImpl implements SearchService {

	@Autowired
	SearchDAO searchDAO;

	@Override
	public List<Map<String, String>> searchList(String srchName) {
		return searchDAO.searchList(srchName);
	}

	@Override
	public Map<String, Object> searchKeywordInfo(String searchKeyword) {
		return searchDAO.searchKeywordInfo(searchKeyword);
	}
}
