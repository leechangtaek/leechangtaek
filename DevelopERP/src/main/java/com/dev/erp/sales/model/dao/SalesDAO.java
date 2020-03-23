package com.dev.erp.sales.model.dao;

import java.util.List;
import java.util.Map;

public interface SalesDAO {

	List<Map<String, String>> selectAllSalesList(Map<String, String> param);

	Map<String, String> selectSalesOneBySalesNo(String sales_no);

	int deleteSalesOneBySalesNo(String salesNo);

	int reInsertProductBySalesNo(Map<String, String> param);

	List<Map<String, String>> selectLotAllInProduction(int cPage, int numPerPage);

	int selectAllCountByLotNo();

	int updateSalesList(Map<String, Object> paramMap);

	int insertSalesListInProduction(Map<String, Object> paramMap);

	List<Map<String, String>> selectSalesProduct();

	List<Map<String, String>> selectSalesMoney(Map<String, String> param);

	Map<String, String> selectTotalSalesData(Map<String, String> param);

	List<Map<String, String>> selectTotalSalesDataPerMonth();


}
