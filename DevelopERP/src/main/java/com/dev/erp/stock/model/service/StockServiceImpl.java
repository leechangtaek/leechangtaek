package com.dev.erp.stock.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.stock.model.dao.StockDAO;

@Service
public class StockServiceImpl implements StockService {

	@Autowired
	StockDAO stockDAO;
	
	@Override
	public List<Map<String, String>> selectRmStockList() {
		
		return stockDAO.selectRmStockList();
	}
	
	@Override
	public List<Map<String, String>> selectRmTotalList() {
		return stockDAO.selectRmTotalList();

	}
	
	@Override
	public List<Map<String, String>> selectRmSnrStockList() {
		
		return stockDAO.selectRmSnrStockList();
	}

	@Override
	public List<Map<String, String>> selectProductStockList() {
		
		return stockDAO.selectProductStockList();
	}
	
	@Override
	public List<Map<String, String>> selectProductStockTotalList() {
		return stockDAO.selectProductStockTotalList();

	}


	@Override
	public List<Map<String, String>> selectStorageStockList(String storeNo) {
		
		return stockDAO.selectStorageStockList(storeNo);
	}
	
	@Override
	public List<Map<String, String>> allStorageStockList() {
		
		return stockDAO.allStorageStockList();
	}

	@Override
	public List<Map<String, String>> storageList() {
		
		return stockDAO.storageList();
	}
	
	@Override
	public List<Map<String, String>> storageTotalList() {
		
		return stockDAO.storageTotalList();
	}


	
	
	
	
	@Override
	public int InsertRm(Map<String, String> rawMaterial) {
		
		return stockDAO.InsertRm(rawMaterial);
	}

	@Override
	public int UpdateRm(Map<String, String> rawMaterial) {
		
		return stockDAO.UpdateRm(rawMaterial);
	}
	@Override
	public int DeleteRm(Map<String, String> rawMaterial) {
		
		return stockDAO.DeleteRm(rawMaterial);
	}
	
	

	@Override
	public List<Map<String, String>> selectRawmaterialAll(int cPage, int numPerPage) {
		return stockDAO.selectRawmaterialAll(cPage, numPerPage);
	}

	@Override
	public int selectAllRawmaterialNo() {
		return stockDAO.selectAllRawmaterialNo();
	}

	@Override
	public List<Map<String, String>> selectStorageAll(int cPage, int numPerPage) {
		return stockDAO.selectStorageAll(cPage, numPerPage);
	}

	@Override
	public int selectAllCountByStorageNo() {
		return stockDAO.selectAllCountByStorageNo();
	}

	@Override
	public List<Map<String, String>> selectProductTypeAll(int cPage, int numPerPage) {
		return stockDAO.selectProductTypeAll(cPage, numPerPage);
	}

	@Override
	public int selectAllCountByProductNo() {
		return stockDAO.selectAllCountByProductNo();
	}

	@Override
	public List<Map<String, String>> selectRecievingtypeAll(int cPage, int numPerPage) {
		return stockDAO.selectRecievingtypeAll(cPage, numPerPage);
	}

	@Override
	public int selectRecievingCountByLotNo() {
		return stockDAO.selectRecievingCountByLotNo();
	}








	


	

}
