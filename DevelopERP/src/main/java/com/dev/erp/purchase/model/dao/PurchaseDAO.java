package com.dev.erp.purchase.model.dao;

import java.util.List;
import java.util.Map;

public interface PurchaseDAO {

	List<Map<String, String>> selectPurchaseList();

	List<Map<String, String>> selectPurchaseInsertList();

	int InsertPurchase(Map<String, String> purchase);

	int UpdatePurchase(Map<String, String> purchase);

}
