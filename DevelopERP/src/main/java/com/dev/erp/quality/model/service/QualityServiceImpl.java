package com.dev.erp.quality.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.quality.model.dao.QualityDAO;
import com.dev.erp.quality.model.vo.Quality;

@Service
public class QualityServiceImpl implements QualityService {

	@Autowired
	private QualityDAO qualityDAO;
	
	@Override
	public List<Map<String, String>> selectQualityAll() {
		
		List<Map<String, String>> list = qualityDAO.selectQaulityAll();
		
		return list;
	}

	@Override
	public Map<String, String> selectOnebyQualityNo(String quality_no) {
		
		Map<String, String> qualityContent = qualityDAO.selectOnebyQualityNo(quality_no);
		
		return qualityContent;
	}

	@Override
	public int qualityUpdateOne(Map<String, String> param) {
		return qualityDAO.qualityUpdateOne(param);
	}

	@Override
	public List<Map<String, String>> selectStoreAll(int cPage,int numPerPage) {
		// TODO Auto-generated method stub
		return qualityDAO.selectStoreAll(cPage,numPerPage);
	}

	@Override
	public List<Map<String, String>> selectQualityColumn(String searchType, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return qualityDAO.selectQualityColumn(searchType, cPage, numPerPage);
	}

	@Override
	public List<Map<String, String>> selectProductTypeAll() {
		// TODO Auto-generated method stub
		return qualityDAO.selectProductTypeAll();
	}

	@Override
	public int selectAllCountByStoreNo() {
		// TODO Auto-generated method stub
		return qualityDAO.selectAllCountByStoreNo();
	}

	@Override
	public int selectAllCountForQuality() {
		// TODO Auto-generated method stub
		return qualityDAO.selectAllCountForQuality();
	}

	@Override
	public List<Map<String, String>> searchBySpecify(Map<String, String> map) {
		// TODO Auto-generated method stub
		return qualityDAO.searchBySpecify(map);
	}

	@Override
	public List<Map<String, String>> insectionWatingList(String type) {
		// TODO Auto-generated method stub
		return qualityDAO.insectionWatingList(type);
	}

	@Override
	public Map<String,String> selectInsectionOnebyLotNo(String lotNo) {
		// TODO Auto-generated method stub
		return qualityDAO.selectInsectionOnebyLotNo(lotNo);
	}

	@Override
	public int updateInsectionYNInRecieving(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.updateInsectionYNInRecieving(param);
	}

	@Override
	public int updateInsectionYNInProduction(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.updateInsectionYNInProduction(param);
	}

	@Override
	public int insertQualityInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.insertQualityInfo(param);
	}

	@Override
	public String selectStoreNoByStoreName(String storeName) {
		// TODO Auto-generated method stub
		return qualityDAO.selectStoreNoByStoreName(storeName);
	}

	@Override
	public List<Map<String, String>> selectRPercentByQualityY(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.selectRPercentByQualityY(param);
	}

	@Override
	public List<Map<String, String>> selectRPercentByQualityN(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.selectRPercentByQualityN(param);
	}

	@Override
	public List<Map<String, String>> selectPPercentByQualityY(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.selectPPercentByQualityY(param);
	}

	@Override
	public List<Map<String, String>> selectPPercentByQualityN(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.selectPPercentByQualityN(param);
	}

	@Override
	public List<Map<String, String>> selectCountAllByInsectionY(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.selectCountAllByInsectionY(param);
	}

	@Override
	public List<Map<String, String>> selectCountQNByInsectionY(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.selectCountQNByInsectionY(param);
	}

	@Override
	public List<Map<String, String>> searchProuctNamePtNo(String ptNo) {
		// TODO Auto-generated method stub
		return qualityDAO.searchProuctNamePtNo(ptNo);
	}

	@Override
	public List<Map<String, String>> selectMeasurmentFromRM(Map<String,String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.selectMeasurmentFromRM(param);
	}

	@Override
	public List<Map<String, String>> selectMeasurmentFromPD(Map<String,String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.selectMeasurmentFromPD(param);
	}

	@Override
	public Map<String,String> selectSpecByRmNo(String ptNo) {
		// TODO Auto-generated method stub
		return qualityDAO.selectSpecByRmNo(ptNo);
	}

	@Override
	public Map<String,String> selectSpecByPtNo(String ptNo) {
		// TODO Auto-generated method stub
		return qualityDAO.selectSpecByPtNo(ptNo);
	}

	@Override
	public List<Map<String, String>> selectRCPkInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.selectRCPkInfo(param);
	}

	@Override
	public List<Map<String, String>> selectPCPkInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return qualityDAO.selectPCPkInfo(param);
	}

	@Override
	public Map<String, String> selectRStaticsInfo(String ptNo) {
		// TODO Auto-generated method stub
		return qualityDAO.selectRStaticsInfo(ptNo);
	}

	@Override
	public Map<String, String> selectPStaticsInfo(String ptNo) {
		// TODO Auto-generated method stub
		return qualityDAO.selectPStaticsInfo(ptNo);
	}



}
