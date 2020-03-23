package com.dev.erp.facility.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dev.erp.facility.model.vo.Facility;
import com.dev.erp.facility.model.vo.FacilityBook;

@Repository
public class FacilityDAOImpl implements FacilityDAO {
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<Facility> selectAll() {
		return sqlSession.selectList("facility.selectAll");
	}

	@Override
	public Facility selectOne(String facilityNo) {
		return sqlSession.selectOne("facility.selectOne",facilityNo);
	}

	@Override
	public int insertBook(FacilityBook facilityBook) {
		return sqlSession.insert("facility.insertBook",facilityBook);
	}

	@Override
	public List<FacilityBook> facilityTime(FacilityBook facilityBook) {
		return sqlSession.selectList("facility.facilityTime",facilityBook);
	}

	@Override
	public List<FacilityBook> facilityBookListGet(FacilityBook facilityBook) {
	return sqlSession.selectList("facility.facilityBookListGet",facilityBook);
	}
}
