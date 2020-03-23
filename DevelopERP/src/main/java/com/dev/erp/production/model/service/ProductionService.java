package com.dev.erp.production.model.service;

import java.util.List;
import java.util.Map;

public interface ProductionService {

	List<Map<String, String>> selectRawMaterialList();


	int insertBOMlist(Map<String, Object> paramMap);


	int insertBOM(String productCode);


	int selectBOMNobyProductCode(String productCode);


	List<Map<String, String>> selectproductList();


	Map<String, String> selectBOMForm(String tdPtNo);


	List<Map<String, String>> selectBOMRmListByBOMNo(int bomNo);


	int deleteBOMRm(Map<String, Object> deleteMap);


	int updateBOMRm(Map<String, Object> paramMap);


	List<Map<String, String>> selectReceivingList();

	Map<String, Object> selectWarehousingByLotNo(String tdLotNo);


	int updateWarehousing(Map<String, String> warehousing);


	int deleteBOMByBOMNo(int bomNo);


	int selectRotNobyRmNo(String rmNo);


	int deleteWarehousingByRmNo(int lotNo);


	List<Map<String, String>> selectReleaseList();


	List<Map<String, String>> checkBOMExist(String chkBOM);


	List<Map<String, String>> quantityCheck(Map<String, Object> map);


	int addRelease(Map<String, String> addMap);


	int addWarehousing(Map<String, String> map);


	int updateReceivingForWarehousing(Map<String, String> map);


	Map<String, String> selectOneProductByPlNo(String rCode);


	int selectOneBOMNoByPlNo(String rCode);


	int insertProduction(Map<String, String> pMap);


	List<Map<String, String>> selectProductionList();

}
