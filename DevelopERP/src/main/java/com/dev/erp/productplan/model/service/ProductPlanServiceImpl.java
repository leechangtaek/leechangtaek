package com.dev.erp.productplan.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.productplan.model.dao.ProductPlanDAO;

@Service
public class ProductPlanServiceImpl implements ProductPlanService {
	@Autowired
	ProductPlanDAO productPlanDAO;

	@Override
	public int insertJobOrder(Map<String, String> joList) {
		
		return productPlanDAO.insertJobOrder(joList);
	}

	@Override
	public List<Map<String, String>> selectJobOrder() {
		return productPlanDAO.selectJobOrder();
	}

	@Override
	public int deleteOneJo(String joNo) {
		return productPlanDAO.deleteOneJo(joNo);
	}

	@Override
	public List<Map<String, String>> selectEndProduct(int cPage, int numPerPage) {
		return productPlanDAO.selectEndProduct(cPage, numPerPage);
	}

	@Override
	public int selectTotalContentsByEp() {
		return productPlanDAO.selectTotalContentsByEp();
	}

	@Override
	public List<Map<String, String>> selectCustomer(int cPage, int numPerPage) {
		return productPlanDAO.selectCustomer(cPage, numPerPage);
	}

	@Override
	public int selectTotalContentsByCtmr() {
		return productPlanDAO.selectTotalContentsByCtmr();
	}

	@Override
	public List<Map<String, String>> selectProductName(int cPage, int numPerPage) {
		return productPlanDAO.selectProductName(cPage, numPerPage);
	}

	@Override
	public int selectTotalContentsByPn() {
		return productPlanDAO.selectTotalContentsByPn();
	}

	@Override
	public int selectJoTotalContents() {
		return productPlanDAO.selectJoTotalContents();
	}

	@Override
	public Map<String, String> selectOneJo(String joNo) {
		return productPlanDAO.selectOneJo(joNo);
	}

	@Override
	public int updateJobOrderEnd(Map<String, String> update) {
		return productPlanDAO.updateJobOrderEnd(update);
	}

	@Override
	public List<Map<String, String>> eachAmountByProduct(String productNo) {
		return productPlanDAO.eachAmountByProduct(productNo);
	}

	@Override
	public List<Map<String, String>> selectFirstByPL() {
		return productPlanDAO.selectFirstByPL();
	}

	@Override
	public int selectTotalEpPlan(Map<String,String> param) {
		return productPlanDAO.selectTotalEpPlan(param);
	}

	@Override
	public int selectTotalEpResult(Map<String,String> param) {
		return productPlanDAO.selectTotalEpResult(param);
	}

	@Override
	public List<Map<String, String>> selectProduction(int cPage, int numPerPage, String year) {
		return productPlanDAO.selectProduction(cPage, numPerPage, year);
	}

	@Override
	public int selectTotalContentsByP(String year) {
		return productPlanDAO.selectTotalContentsByP(year);
	}

	@Override
	public List<Map<String, String>> monthlyOutputByProduct(Map<String,String> param) {
		return productPlanDAO.monthlyOutputByProduct(param);
	}

	@Override
	public String productionPlanDate() {
		return productPlanDAO.productionPlanDate();
	}

	@Override
	public int sumLast3Months(String productName) {
		return productPlanDAO.sumLast3Months(productName);
	}

	@Override
	public int insertOrderRequest(Map<String, String> map) {
		return productPlanDAO.insertOrderRequest(map);
	}

	@Override
	public String selectVendorNo(String rmNo) {
		return productPlanDAO.selectVendorNo(rmNo);
	}

}
