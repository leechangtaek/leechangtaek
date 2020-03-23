package com.dev.erp.search.model.service;

import java.util.List;
import java.util.Map;

public interface SearchService {

	List<Map<String, String>> searchList(String srchName);

	Map<String, Object> searchKeywordInfo(String searchKeyword);

}
