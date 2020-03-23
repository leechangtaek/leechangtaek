package com.dev.erp.search.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SearchDAOImpl implements SearchDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<Map<String, String>> searchList(String srchName) {
		return sqlSession.selectList("search.searchList",srchName);
	}

	@Override
	public Map<String, Object> searchKeywordInfo(String searchKeyword) {
		return sqlSession.selectOne("search.searchKeywordInfo",searchKeyword);
	}
}
