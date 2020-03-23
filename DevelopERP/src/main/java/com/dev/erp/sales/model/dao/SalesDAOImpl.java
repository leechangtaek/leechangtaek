package com.dev.erp.sales.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SalesDAOImpl implements SalesDAO {
	
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, String>> selectAllSalesList(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("sales.selectAllSalesList",param);
	}

	@Override
	public Map<String, String> selectSalesOneBySalesNo(String sales_no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("sales.selectSalesOneBySalesNo",sales_no);
	}

	@Override
	public int deleteSalesOneBySalesNo(String salesNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("sales.deleteSalesOneBySalesNo",salesNo);
	}

	@Override
	public int reInsertProductBySalesNo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.update("sales.reInsertProductBySalesNo",param);
	}

	@Override
	public List<Map<String, String>> selectLotAllInProduction(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("sales.selectLotAllInProduction",null,rowBounds);
	}

	@Override
	public int selectAllCountByLotNo() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("sales.selectAllCountByLotNo");
	}

	@Override
	public int updateSalesList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return sqlSession.update("sales.updateSalesList",paramMap);
	}

	@Override
	public int insertSalesListInProduction(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return sqlSession.insert("sales.insertSalesListInProduction",paramMap);
	}

	@Override
	public List<Map<String, String>> selectSalesProduct() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("sales.selectSalesProduct");
	}

	@Override
	public List<Map<String, String>> selectSalesMoney(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("sales.selectSalesMoney",param);
	}

	@Override
	public Map<String, String> selectTotalSalesData(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("sales.selectTotalSalesData",param);
	}

	@Override
	public List<Map<String, String>> selectTotalSalesDataPerMonth() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("sales.selectTotalSalesDataPerMonth");
	}

}
