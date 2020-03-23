package com.dev.erp.attend.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.attend.model.dao.AttendDAO;
import com.dev.erp.attend.model.vo.Attend;

@Service
public class AttendServiceImpl implements AttendService {
	static final Logger logger = LoggerFactory.getLogger(AttendServiceImpl.class);

	@Autowired
	AttendDAO attendDAO;
	@Override
	public int attendant(String email) {
		return attendDAO.attendant(email);
	}
	@Override
	public int leave(String email) {
		return attendDAO.leave(email);
	}
	@Override
	public List<Attend> attendShow(String email) {
		return attendDAO.attendShow(email);
	}

	@Override
	public String checkAttend(Attend attend) {
		return attendDAO.checkAttend(attend);
	}
	@Override
	public int earlyLeave(Attend attend) {
		return attendDAO.earlyLeave(attend);
	}
	@Override
	public String checkend(Attend attend) {
		return attendDAO.checkend(attend);
	}
	@Override
	public String checkearly(Attend attend) {
		return attendDAO.checkearly(attend);
	}
	@Override
	public String checkholiday(Attend holiday) {
		return attendDAO.checkholiday(holiday);
	}

}
