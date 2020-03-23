package com.dev.erp.purchase.model.service;

import java.util.List;
import java.util.Map;

public interface PurchaseService {

	List<Map<String, String>> selectPurchaseList();

	List<Map<String, String>> selectPurchaseInsertList();

	int InsertPurchase(Map<String, String> purchase);

	int UpdatePurchase(Map<String, String> purchase);

	

}
