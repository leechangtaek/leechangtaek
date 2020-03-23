package com.dev.erp.facility.model.dao;

import java.util.List;
import java.util.Map;

import com.dev.erp.facility.model.vo.Facility;
import com.dev.erp.facility.model.vo.FacilityBook;

public interface FacilityDAO {

	List<Facility> selectAll();

	Facility selectOne(String facilityNo);

	int insertBook(FacilityBook facilityBook);

	List<FacilityBook> facilityTime(FacilityBook facilityBook);

	List<FacilityBook> facilityBookListGet(FacilityBook facilityBook);

}
