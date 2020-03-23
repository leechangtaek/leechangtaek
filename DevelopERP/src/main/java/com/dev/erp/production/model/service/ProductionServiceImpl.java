package com.dev.erp.production.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.production.model.dao.ProductionDAO;

@Service
public class ProductionServiceImpl implements ProductionService {

	@Autowired
	ProductionDAO productionDAO;

	@Override
	public List<Map<String, String>> selectRawMaterialList() {
		return productionDAO.selectRawMaterialList();
	}

	@Override
	public int insertBOMlist(Map<String, Object> paramMap) {
		return productionDAO.insertBOMlist(paramMap);
	}

	@Override
	public int insertBOM(String productCode) {
		return productionDAO.insertBOM(productCode);
	}

	@Override
	public int selectBOMNobyProductCode(String productCode) {
		return productionDAO.selectBOMNobyProductCode(productCode);
	}

	@Override
	public List<Map<String, String>> selectproductList() {
		return productionDAO.selectproductList();
	}

	@Override
	public Map<String, String> selectBOMForm(String tdPtNo) {
		return productionDAO.selectBOMForm(tdPtNo);
	}

	@Override
	public List<Map<String, String>> selectBOMRmListByBOMNo(int bomNo) {
		return productionDAO.selectBOMRmListByBOMNo(bomNo);
	}

	@Override
	public int deleteBOMRm(Map<String, Object> deleteMap) {
		return productionDAO.deleteBOMRm(deleteMap);
	}

	@Override
	public int updateBOMRm(Map<String, Object> paramMap) {
		return productionDAO.updateBOMRm(paramMap);
	}

	@Override
	public List<Map<String, String>> selectReceivingList() {
		return productionDAO.selectReceivingList();
	}

	@Override
	public Map<String, Object> selectWarehousingByLotNo(String tdLotNo) {
		return productionDAO.selectWarehousingByLotNo(tdLotNo);
	}

	@Override
	public int updateWarehousing(Map<String, String> warehousing) {
		return productionDAO.updateWarehousing(warehousing);
	}

	@Override
	public int deleteBOMByBOMNo(int bomNo) {
		return productionDAO.deleteBOMByBOMNo(bomNo);
	}

	@Override
	public int selectRotNobyRmNo(String rmNo) {
		return productionDAO.selectRotNobyRmNo(rmNo);
	}

	@Override
	public int deleteWarehousingByRmNo(int lotNo) {
		return productionDAO.deleteWarehousingByRmNo(lotNo);
	}

	@Override
	public List<Map<String, String>> selectReleaseList() {
		return productionDAO.selectReleaseList();
	}

	@Override
	public List<Map<String, String>> checkBOMExist(String chkBOM) {
		return productionDAO.checkBOMExist(chkBOM);
	}

	@Override
	public List<Map<String, String>> quantityCheck(Map<String, Object> map) {
		return productionDAO.quantityCheck(map);
	}

	@Override
	public int addRelease(Map<String, String> addMap) {
		return productionDAO.addRelease(addMap);
	}

	@Override
	public int addWarehousing(Map<String, String> map) {
		return productionDAO.addWarehousing(map);
	}

	@Override
	public int updateReceivingForWarehousing(Map<String, String> map) {
		return productionDAO.updateReceivingForWarehousing(map);
	}

	@Override
	public Map<String, String> selectOneProductByPlNo(String rCode) {
		return productionDAO.selectOneProductByPlNo(rCode);
	}

	@Override
	public int selectOneBOMNoByPlNo(String rCode) {
		return productionDAO.selectOneBOMNoByPlNo(rCode);
	}

	@Override
	public int insertProduction(Map<String, String> pMap) {
		return productionDAO.insertProduction(pMap);
	}

	@Override
	public List<Map<String, String>> selectProductionList() {
		return productionDAO.selectProductionList();
	}

}
