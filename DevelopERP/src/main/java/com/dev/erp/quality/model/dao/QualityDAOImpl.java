package com.dev.erp.quality.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dev.erp.quality.model.vo.Quality;

@Repository
public class QualityDAOImpl implements QualityDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, String>> selectQaulityAll() {
		
		return sqlSession.selectList("quality.selectQualityAll");
	}

	@Override
	public Map<String, String> selectOnebyQualityNo(String quality_no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("quality.selectOnebyQualityNo", quality_no);
	}

	@Override
	public int qualityUpdateOne(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.update("quality.qualityUpdateOne",param);
	}

	@Override
	public List<Map<String, String>> selectStoreAll(int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("quality.selectStoreAll",null,rowBounds);
	}

	@Override
	public List<Map<String, String>> selectQualityColumn(String searchType, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("quality.selectQualityColumn", searchType, rowBounds);
	}

	@Override
	public List<Map<String, String>> selectProductTypeAll() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectProductTypeAll");
	}

	@Override
	public int selectAllCountByStoreNo() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("quality.selectAllCountByStoreNo");
	}

	@Override
	public int selectAllCountForQuality() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("quality.selectAllCountForQuality");
	}

	@Override
	public List<Map<String, String>> searchBySpecify(Map<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.searchBySpecify",map);
	}

	@Override
	public List<Map<String, String>> insectionWatingList(String type) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.insectionWatingList", type);
	}

	@Override
	public Map<String,String> selectInsectionOnebyLotNo(String lotNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("quality.selectInsectionOnebyLotNo",lotNo);
	}

	@Override
	public int updateInsectionYNInRecieving(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.update("quality.updateInsectionYNInRecieving", param);
	}

	@Override
	public int updateInsectionYNInProduction(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.update("quality.updateInsectionYNInProduction", param);
	}

	@Override
	public int insertQualityInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.insert("quality.insertQualityInfo",param);
	}

	@Override
	public String selectStoreNoByStoreName(String storeName) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("quality.selectStoreNoByStoreName",storeName);
	}

	@Override
	public List<Map<String, String>> selectRPercentByQualityY(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectRPercentByQualityY",param);
	}

	@Override
	public List<Map<String, String>> selectRPercentByQualityN(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectRPercentByQualityN",param);
	}
	
	@Override
	public List<Map<String, String>> selectPPercentByQualityY(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectPPercentByQualityY",param);
	}
	
	@Override
	public List<Map<String, String>> selectPPercentByQualityN(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectPPercentByQualityN",param);
	}

	@Override
	public List<Map<String, String>> selectCountAllByInsectionY(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectCountAllByInsectionY",param);
	}

	@Override
	public List<Map<String, String>> selectCountQNByInsectionY(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectCountQNByInsectionY",param);
	}

	@Override
	public List<Map<String, String>> searchProuctNamePtNo(String ptNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.searchProuctNamePtNo",ptNo);
	}

	@Override
	public List<Map<String, String>> selectMeasurmentFromPD(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectMeasurmentFromPD",param);
	}

	@Override
	public List<Map<String, String>> selectMeasurmentFromRM(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectMeasurmentFromRM",param);
	}

	@Override
	public Map<String,String> selectSpecByRmNo(String ptNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("quality.selectSpecByRmNo",ptNo);
	}

	@Override
	public Map<String,String> selectSpecByPtNo(String ptNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("quality.selectSpecByPtNo",ptNo);
	}

	@Override
	public List<Map<String, String>> selectRCPkInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectRCPkInfo",param);
	}

	@Override
	public List<Map<String, String>> selectPCPkInfo(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("quality.selectPCPkInfo",param);
	}

	@Override
	public Map<String, String> selectRStaticsInfo(String ptNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("quality.selectRStaticsInfo",ptNo);
	}

	@Override
	public Map<String, String> selectPStaticsInfo(String ptNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("quality.selectPStaticsInfo",ptNo);
	}
	
	
}
