package com.dev.erp.sales.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.sales.model.dao.SalesDAO;

@Service
public class SalesServiceImpl implements SalesService {
	
	@Autowired
	private SalesDAO salesDAO;

	@Override
	public List<Map<String, String>> selectAllSalesList(Map<String, String> param) {
		// TODO Auto-generated method stub
		return salesDAO.selectAllSalesList(param);
	}

	@Override
	public Map<String, String> selectSalesOneBySalesNo(String sales_no) {
		// TODO Auto-generated method stub
		return salesDAO.selectSalesOneBySalesNo(sales_no);
	}

	@Override
	public int deleteSalesOneBySalesNo(String salesNo) {
		// TODO Auto-generated method stub
		return salesDAO.deleteSalesOneBySalesNo(salesNo);
	}

	@Override
	public int reInsertProductBySalesNo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return salesDAO.reInsertProductBySalesNo(param);
	}

	@Override
	public List<Map<String, String>> selectLotAllInProduction(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return salesDAO.selectLotAllInProduction(cPage,numPerPage);
	}

	@Override
	public int selectAllCountByLotNo() {
		// TODO Auto-generated method stub
		return salesDAO.selectAllCountByLotNo();
	}

	@Override
	public int updateSalesList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return salesDAO.updateSalesList(paramMap);
	}

	@Override
	public int insertSalesListInProduction(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return salesDAO.insertSalesListInProduction(paramMap);
	}

	@Override
	public List<Map<String, String>> selectSalesProduct() {
		// TODO Auto-generated method stub
		return salesDAO.selectSalesProduct();
	}

	@Override
	public List<Map<String, String>> selectSalesMoney(Map<String, String> param) {
		// TODO Auto-generated method stub
		return salesDAO.selectSalesMoney(param);
	}

	@Override
	public Map<String, String> selectTotalSalesData(Map<String, String> param) {
		// TODO Auto-generated method stub
		return salesDAO.selectTotalSalesData(param);
	}

	@Override
	public List<Map<String, String>> selectTotalSalesDataPerMonth() {
		// TODO Auto-generated method stub
		return salesDAO.selectTotalSalesDataPerMonth();
	}

	
}
