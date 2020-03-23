package com.dev.erp.stock.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StockDAOImpl implements StockDAO {

	@Autowired
	SqlSession sqlsession;
	
	@Override
	public List<Map<String, String>> selectRmStockList() {
		return sqlsession.selectList("stock.selectRmStockList");
	}

	@Override
	public List<Map<String, String>> selectRmTotalList() {
		return sqlsession.selectList("stock.selectRmTotalList");

	}
	
	@Override
	public List<Map<String, String>> selectRmSnrStockList() {
		return sqlsession.selectList("stock.selectRmSnrStockList");
	}
	
	@Override
	public List<Map<String, String>> selectProductStockList() {
		return sqlsession.selectList("stock.selectProductStockList");
	}
	
	@Override
	public List<Map<String, String>> selectProductStockTotalList() {
		return sqlsession.selectList("stock.selectProductStockTotalList");

	}


	@Override
	public List<Map<String, String>> selectStorageStockList(String storeNo) {
		return sqlsession.selectList("stock.selectStorageStockList", storeNo);
	}
	
	@Override
	public List<Map<String, String>> allStorageStockList() {
		return sqlsession.selectList("stock.allStorageStockList");
	}
	
	@Override
	public List<Map<String, String>> storageList() {
		return sqlsession.selectList("stock.storageStockList");
	}
	
	@Override
	public List<Map<String, String>> storageTotalList() {
		return sqlsession.selectList("stock.storageTotalList");

	}

	
	
	
	@Override
	public int UpdateRm(Map<String, String> rawMaterial) {
		return sqlsession.update("stock.UpdateRm", rawMaterial);
	}

	@Override
	public int InsertRm(Map<String, String> rawMaterial) {
		
		return sqlsession.insert("stock.InsertRm", rawMaterial);
	}
	@Override
	public int DeleteRm(Map<String, String> rawMaterial) {
		return sqlsession.delete("stock.DeleteRm", rawMaterial);
	}
	
	

	@Override
	public List<Map<String, String>> selectRawmaterialAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("stock.selectRawmaterialAll",null,rowBounds);
	}

	@Override
	public int selectAllRawmaterialNo() {
		return sqlsession.selectOne("stock.selectAllRawmaterialNo");
	}

	@Override
	public List<Map<String, String>> selectStorageAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("stock.selectStorageAll",null,rowBounds);
	}

	@Override
	public int selectAllCountByStorageNo() {
		return sqlsession.selectOne("stock.selectAllCountByStorageNo");

	}

	@Override
	public List<Map<String, String>> selectProductTypeAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("stock.selectProductTypeAll",null,rowBounds);
	}

	@Override
	public int selectAllCountByProductNo() {
		return sqlsession.selectOne("stock.selectAllCountByProductNo");
	}

	@Override
	public List<Map<String, String>> selectRecievingtypeAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("stock.selectRecievingtypeAll",null,rowBounds);
	}

	@Override
	public int selectRecievingCountByLotNo() {
		return sqlsession.selectOne("stock.selectRecievingCountByLotNo");
	}








	

	
	
	
	
	
	

}
