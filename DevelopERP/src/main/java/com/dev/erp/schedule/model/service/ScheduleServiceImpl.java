package com.dev.erp.schedule.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dev.erp.schedule.model.dao.ScheduleDAO;
import com.dev.erp.schedule.model.vo.Schedule;

@Service
public class ScheduleServiceImpl implements ScheduleService {
@Autowired ScheduleDAO scheduleDAO;

@Override
public int insertSchedule(Schedule schedule) {
return scheduleDAO.insertSchedule(schedule);
}

@Override
public List<Schedule> getSchedule(String email) {
	return scheduleDAO.getSchedule(email);
}

@Override
public List<Schedule> scheduleList(Map<String, Object> map) {
	return scheduleDAO.scheduleList(map);
}

@Override
public int scheduleDelete(Schedule schedule) {
	return scheduleDAO.scheduleDelete(schedule);
}

@Override
public int scheduleUpdate(Schedule schedule) {
	return scheduleDAO.scheduleUpdate(schedule);
}
}
