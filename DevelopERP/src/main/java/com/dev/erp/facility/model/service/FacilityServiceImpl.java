package com.dev.erp.facility.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.facility.model.dao.FacilityDAO;
import com.dev.erp.facility.model.vo.Facility;
import com.dev.erp.facility.model.vo.FacilityBook;

@Service
public class FacilityServiceImpl implements FacilityService {
@Autowired
FacilityDAO facilityDAO;

@Override
public List<Facility> selectAll() {
	// TODO Auto-generated method stub
	return facilityDAO.selectAll();
}

@Override
public Facility selectOne(String facilityNo) {
	return facilityDAO.selectOne(facilityNo);
}

@Override
public int insertBook(FacilityBook facilityBook) {
	return facilityDAO.insertBook(facilityBook);
}

@Override
public List<FacilityBook> facilityTime(FacilityBook facilityBook) {
	return facilityDAO.facilityTime(facilityBook);
}

@Override
public List<FacilityBook> facilityBookListGet(FacilityBook facilityBook) {
	return facilityDAO.facilityBookListGet(facilityBook);
}
}
