package com.dev.erp.enrollment.model.dao;

import java.util.List;
import java.util.Map;

public interface EnrollmentDAO {

	int insertVendor(Map<String, String> vendor);

	List<Map<String, String>> selectVendorList();

	Map<String, String> selectOneVendorNo(String vendorNo);

	int updateVendor(Map<String, String> vendor);

	int updateVendorNo(Map<String, String> vendorNo);

	List<Map<String, String>> selectStorageList();

	int insertStorage(Map<String, String> storage);

	Map<String, String> selectOneStorageNo(String storageNo);

	int updateStorage(Map<String, String> storage);

	List<Map<String, String>> selectproductList();

	int insertProduct(Map<String, String> product);

	Map<String, String> selectOneProductNo(String productNo);

	List<Map<String, String>> selectAccountAll(int cPage, int numPerPage);

	int selectAllCountByAccountNo();

	List<Map<String, String>> selectProductTypeAll(int cPage, int numPerPage);

	int selectAllCountByProductNo();

	Map<String, String> selectOneProductNoForRawMaterial(String productNo);

	int insertRawMaterial(Map<String, String> rawMaterial);

	int updateProductNo(Map<String, String> productNo);

	int updateRawMaterial(Map<String, String> rawMaterial);

	int updateProduct(Map<String, String> product);

	int updateProductNoForProductList(Map<String, String> productNo);

	int selectAllRawmaterial();

	List<Map<String, String>> selectRawmaterialAll(int cPage, int numPerPage);

	List<Map<String, String>> selectVendorTypeAll(int cPage, int numPerPage);

	int selectAllVendorType();

	List<Map<String, String>> selectrawMaterialDetailAll(int cPage, int numPerPage);

	int selectAllrawMaterialDetail();

	List<Map<String, String>> selectStoreNoAll(int cPage, int numPerPage);

	int selectAllStoreNo();

	int deleteVendorByVendorNo(String vendorNo);

	int deleteStorageByStNo(String stNo);

	int deleteProductByProductNo(String productNo);

	int deleteRawmaterialByRmNo(String rmNo);

	Map<String, Object> checkDataAvailable(String ckData);

	List<Map<String, String>> selectJobOrderAll(int cPage, int numPerPage);

	int selectAllJobOrder();

	List<Map<String, String>> selectReceivingLotNoAll(int cPage, int numPerPage, String thisCode);

	int selectAllReceivingLotNo(String thisCode);

	int updateRawMeterial(Map<String, String> product);

}
