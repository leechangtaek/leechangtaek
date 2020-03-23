package com.dev.erp.search.model.dao;

import java.util.List;
import java.util.Map;

public interface SearchDAO {

	List<Map<String, String>> searchList(String srchName);

	Map<String, Object> searchKeywordInfo(String searchKeyword);

}
