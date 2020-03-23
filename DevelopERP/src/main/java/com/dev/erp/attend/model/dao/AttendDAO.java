package com.dev.erp.attend.model.dao;

import java.util.List;
import java.util.Map;

import com.dev.erp.attend.model.vo.Attend;
import com.dev.erp.facility.model.vo.Facility;

public interface AttendDAO {

	int attendant(String email);

	int leave(String email);

	List<Attend> attendShow(String email);



	String checkAttend(Attend attend);

	int earlyLeave(Attend attend);

	String checkend(Attend attend);

	String checkearly(Attend attend);

	String checkholiday(Attend holiday);



}
