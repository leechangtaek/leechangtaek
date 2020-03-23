package com.dev.erp.enrollment.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EnrollmentDAOImpl implements EnrollmentDAO {

	@Autowired
	SqlSession sqlsession;

	@Override
	public int insertVendor(Map<String, String> vendor) {
		return sqlsession.insert("enrollment.insertVendor", vendor);
	}

	@Override
	public List<Map<String, String>> selectVendorList() {
		return sqlsession.selectList("enrollment.selectVendorList");
	}

	@Override
	public Map<String, String> selectOneVendorNo(String vendorNo) {
		return sqlsession.selectOne("enrollment.selectOneVendorNo",vendorNo);
	}

	@Override
	public int updateVendor(Map<String, String> vendor) {
		return sqlsession.update("enrollment.updateVendor", vendor);
	}

	@Override
	public int updateVendorNo(Map<String, String> vendorNo) {
		return sqlsession.update("enrollment.updateVendorNo", vendorNo);
	}

	@Override
	public List<Map<String, String>> selectStorageList() {
		return sqlsession.selectList("enrollment.selectStorageList");
	}

	@Override
	public int insertStorage(Map<String, String> storage) {
		return sqlsession.insert("enrollment.insertStorage", storage);
	}

	@Override
	public Map<String, String> selectOneStorageNo(String storageNo) {
		return sqlsession.selectOne("enrollment.selectOneStorageNo",storageNo);
	}

	@Override
	public int updateStorage(Map<String, String> storage) {
		return sqlsession.update("enrollment.updateStorage",storage);
	}

	@Override
	public List<Map<String, String>> selectproductList() {
		return sqlsession.selectList("enrollment.selectproductList");
	}

	@Override
	public int insertProduct(Map<String, String> product) {
		return sqlsession.insert("enrollment.insertProduct", product);
	}

	@Override
	public Map<String, String> selectOneProductNo(String productNo) {
		return sqlsession.selectOne("enrollment.selectOneProductNo",productNo);
	}

	@Override
	public List<Map<String, String>> selectAccountAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("enrollment.selectAccountAll",null,rowBounds);
	}

	@Override
	public int selectAllCountByAccountNo() {
		return sqlsession.selectOne("enrollment.selectAllCountByAccountNo");
	}

	@Override
	public List<Map<String, String>> selectProductTypeAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("enrollment.selectProductTypeAll",null,rowBounds);
	}

	@Override
	public int selectAllCountByProductNo() {
		return sqlsession.selectOne("enrollment.selectAllCountByProductNo");
	}

	@Override
	public Map<String, String> selectOneProductNoForRawMaterial(String productNo) {
		return sqlsession.selectOne("enrollment.selectOneProductNoForRawMaterial",productNo);
	}

	@Override
	public int insertRawMaterial(Map<String, String> rawMaterial) {
		return sqlsession.insert("enrollment.insertRawMaterial", rawMaterial);
	}

	@Override
	public int updateProductNo(Map<String, String> productNo) {
		return sqlsession.update("enrollment.updateProductNo",productNo);
	}

	@Override
	public int updateRawMaterial(Map<String, String> rawMaterial) {
		return sqlsession.update("enrollment.updateRawMaterial", rawMaterial);
	}

	@Override
	public int updateProduct(Map<String, String> product) {
		return sqlsession.update("enrollment.updateProduct",product);
	}

	@Override
	public int updateProductNoForProductList(Map<String, String> productNo) {
		return sqlsession.update("enrollment.updateProductNoForProductList",productNo);
	}

	@Override
	public int selectAllRawmaterial() {
		return sqlsession.selectOne("enrollment.selectAllRawmaterial");
	}

	@Override
	public List<Map<String, String>> selectRawmaterialAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("enrollment.selectRawmaterialAll",null,rowBounds);
	}

	@Override
	public List<Map<String, String>> selectVendorTypeAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("enrollment.selectVendorTypeAll",null,rowBounds);
	}

	@Override
	public int selectAllVendorType() {
		return sqlsession.selectOne("enrollment.selectAllVendorType");
	}

	@Override
	public List<Map<String, String>> selectrawMaterialDetailAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("enrollment.selectrawMaterialDetailAll",null,rowBounds);
	}

	@Override
	public int selectAllrawMaterialDetail() {
		return sqlsession.selectOne("enrollment.selectAllrawMaterialDetail");
	}

	@Override
	public List<Map<String, String>> selectStoreNoAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("enrollment.selectStoreNoAll",null,rowBounds);
	}

	@Override
	public int selectAllStoreNo() {
		return sqlsession.selectOne("enrollment.selectAllStoreNo");
	}

	@Override
	public int deleteVendorByVendorNo(String vendorNo) {
		return sqlsession.delete("enrollment.deleteVendorByVendorNo",vendorNo);
	}

	@Override
	public int deleteStorageByStNo(String stNo) {
		return sqlsession.delete("enrollment.deleteStorageByStNo",stNo);
	}

	@Override
	public int deleteProductByProductNo(String productNo) {
		return sqlsession.delete("enrollment.deleteProductByProductNo",productNo);
	}

	@Override
	public int deleteRawmaterialByRmNo(String rmNo) {
		return sqlsession.delete("enrollment.deleteRawmaterialByRmNo",rmNo);
	}

	@Override
	public Map<String, Object> checkDataAvailable(String ckData) {
		return sqlsession.selectOne("enrollment.checkDataAvailable",ckData);
	}

	@Override
	public List<Map<String, String>> selectJobOrderAll(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("enrollment.selectJobOrderAll",null,rowBounds);
	}

	@Override
	public int selectAllJobOrder() {
		return sqlsession.selectOne("enrollment.selectAllJobOrder");
	}

	@Override
	public List<Map<String, String>> selectReceivingLotNoAll(int cPage, int numPerPage, String thisCode) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlsession.selectList("enrollment.selectReceivingLotNoAll",thisCode,rowBounds);
	}

	@Override
	public int selectAllReceivingLotNo(String thisCode) {
		return sqlsession.selectOne("enrollment.selectAllReceivingLotNo", thisCode);
	}

	@Override
	public int updateRawMeterial(Map<String, String> product) {
		return sqlsession.update("enrollment.updateRawMeterial", product);
	}
	
	
}
