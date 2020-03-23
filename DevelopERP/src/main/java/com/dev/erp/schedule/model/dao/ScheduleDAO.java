package com.dev.erp.schedule.model.dao;

import java.util.List;
import java.util.Map;

import com.dev.erp.schedule.model.vo.Schedule;

public interface ScheduleDAO {

	int insertSchedule(Schedule schedule);

	List<Schedule> getSchedule(String email);

	List<Schedule> scheduleList(Map<String, Object> map);

	int scheduleDelete(Schedule schedule);

	int scheduleUpdate(Schedule schedule);

}
