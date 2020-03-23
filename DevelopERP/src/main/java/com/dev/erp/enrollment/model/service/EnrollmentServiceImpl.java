package com.dev.erp.enrollment.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.enrollment.model.dao.EnrollmentDAO;

@Service
public class EnrollmentServiceImpl implements EnrollmentService {

	@Autowired
	EnrollmentDAO enrollmentDAO;
	
	Logger logger = LoggerFactory.getLogger(EnrollmentServiceImpl.class);

	@Override
	public int insertVendor(Map<String, String> vendor) {
		return enrollmentDAO.insertVendor(vendor);
	}

	@Override
	public List<Map<String, String>> selectVendorList() {
		return enrollmentDAO.selectVendorList();
	}

	@Override
	public Map<String, String> selectOneVendorNo(String vendorNo) {
		return enrollmentDAO.selectOneVendorNo(vendorNo);
	}

	@Override
	public int updateVendor(Map<String, String> vendor) {
		return enrollmentDAO.updateVendor(vendor);
	}

	@Override
	public int updateVendorNo(Map<String, String> vendorNo) {
		return enrollmentDAO.updateVendorNo(vendorNo);
	}

	@Override
	public List<Map<String, String>> selectStorageList() {
		return enrollmentDAO.selectStorageList();
	}

	@Override
	public int insertStorage(Map<String, String> storage) {
		return enrollmentDAO.insertStorage(storage);
	}

	@Override
	public Map<String, String> selectOneStorageNo(String storageNo) {
		return enrollmentDAO.selectOneStorageNo(storageNo);
	}

	@Override
	public int updateStorage(Map<String, String> storage) {
		return enrollmentDAO.updateStorage(storage);
	}

	@Override
	public List<Map<String, String>> selectproductList() {
		return enrollmentDAO.selectproductList();
	}

	@Override
	public int insertProduct(Map<String, String> product) {
		return enrollmentDAO.insertProduct(product);
	}

	@Override
	public Map<String, String> selectOneProductNo(String productNo) {
		return enrollmentDAO.selectOneProductNo(productNo);
	}

	@Override
	public List<Map<String, String>> selectAccountAll(int cPage, int numPerPage) {
		return enrollmentDAO.selectAccountAll(cPage, numPerPage);
	}

	@Override
	public int selectAllCountByAccountNo() {
		return enrollmentDAO.selectAllCountByAccountNo();
	}

	@Override
	public List<Map<String, String>> selectProductTypeAll(int cPage, int numPerPage) {
		return enrollmentDAO.selectProductTypeAll(cPage, numPerPage);
	}

	@Override
	public int selectAllCountByProductNo() {
		return enrollmentDAO.selectAllCountByProductNo();
	}

	@Override
	public Map<String, String> selectOneProductNoForRawMaterial(String productNo) {
		return enrollmentDAO.selectOneProductNoForRawMaterial(productNo);
	}

	@Override
	public int insertRawMaterial(Map<String, String> rawMaterial) {
		return enrollmentDAO.insertRawMaterial(rawMaterial);
	}

	@Override
	public int updateProductNo(Map<String, String> productNo) {
		return enrollmentDAO.updateProductNo(productNo);
	}

	@Override
	public int updateRawMaterial(Map<String, String> rawMaterial) {
		return enrollmentDAO.updateRawMaterial(rawMaterial);
	}

	@Override
	public int updateProduct(Map<String, String> product) {
		return enrollmentDAO.updateProduct(product);
	}

	@Override
	public int updateProductNoForProductList(Map<String, String> productNo) {
		return enrollmentDAO.updateProductNoForProductList(productNo);
	}

	@Override
	public int selectAllRawmaterial() {
		return enrollmentDAO.selectAllRawmaterial();
	}

	@Override
	public List<Map<String, String>> selectRawmaterialAll(int cPage, int numPerPage) {
		return enrollmentDAO.selectRawmaterialAll(cPage, numPerPage);
	}

	@Override
	public List<Map<String, String>> selectVendorTypeAll(int cPage, int numPerPage) {
		return enrollmentDAO.selectVendorTypeAll(cPage, numPerPage);
	}

	@Override
	public int selectAllVendorType() {
		return enrollmentDAO.selectAllVendorType();
	}

	@Override
	public List<Map<String, String>> selectrawMaterialDetailAll(int cPage, int numPerPage) {
		return enrollmentDAO.selectrawMaterialDetailAll(cPage, numPerPage);
	}

	@Override
	public int selectAllrawMaterialDetail() {
		return enrollmentDAO.selectAllrawMaterialDetail();
	}

	@Override
	public List<Map<String, String>> selectStoreNoAll(int cPage, int numPerPage) {
		return enrollmentDAO.selectStoreNoAll(cPage, numPerPage);
	}

	@Override
	public int selectAllStoreNo() {
		return enrollmentDAO.selectAllStoreNo();
	}

	@Override
	public int deleteVendorByVendorNo(String vendorNo) {
		return enrollmentDAO.deleteVendorByVendorNo(vendorNo);
	}

	@Override
	public int deleteStorageByStNo(String stNo) {
		return enrollmentDAO.deleteStorageByStNo(stNo);
	}

	@Override
	public int deleteProductByProductNo(String productNo) {
		return enrollmentDAO.deleteProductByProductNo(productNo);
	}

	@Override
	public int deleteRawmaterialByRmNo(String rmNo) {
		return enrollmentDAO.deleteRawmaterialByRmNo(rmNo);
	}

	@Override
	public Map<String, Object> checkDataAvailable(String ckData) {
		return enrollmentDAO.checkDataAvailable(ckData);
	}

	@Override
	public List<Map<String, String>> selectJobOrderAll(int cPage, int numPerPage) {
		return enrollmentDAO.selectJobOrderAll(cPage, numPerPage);
	}

	@Override
	public int selectAllJobOrder() {
		return enrollmentDAO.selectAllJobOrder();
	}

	@Override
	public List<Map<String, String>> selectReceivingLotNoAll(int cPage, int numPerPage, String thisCode) {
		return enrollmentDAO.selectReceivingLotNoAll(cPage, numPerPage, thisCode);
	}

	@Override
	public int selectAllReceivingLotNo(String thisCode) {
		return enrollmentDAO.selectAllReceivingLotNo(thisCode);
	}

	@Override
	public int updateRawMeterial(Map<String, String> product) {
		return enrollmentDAO.updateRawMeterial(product);
	}
	
	
}
