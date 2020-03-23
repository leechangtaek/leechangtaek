package com.dev.erp.purchase.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.purchase.model.dao.PurchaseDAO;

@Service
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	PurchaseDAO purchaseDAO;
	
	@Override
	public List<Map<String, String>> selectPurchaseList() {
		
		return purchaseDAO.selectPurchaseList();
	}

	@Override
	public List<Map<String, String>> selectPurchaseInsertList() {

		return purchaseDAO.selectPurchaseInsertList();
	}

	@Override
	public int InsertPurchase(Map<String, String> purchase) {
		
		return purchaseDAO.InsertPurchase(purchase);
	}

	@Override
	public int UpdatePurchase(Map<String, String> purchase) {
		return purchaseDAO.UpdatePurchase(purchase);
	}

}
