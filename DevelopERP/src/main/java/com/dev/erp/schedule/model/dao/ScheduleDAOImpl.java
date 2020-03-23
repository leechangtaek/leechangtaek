package com.dev.erp.schedule.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dev.erp.schedule.model.vo.Schedule;

@Repository
public class ScheduleDAOImpl implements ScheduleDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertSchedule(Schedule schedule) {
		return sqlSession.insert("schedule.insertSchedule",schedule);
	}

	@Override
	public List<Schedule> getSchedule(String email) {
		return sqlSession.selectList("schedule.getSchedule",email);
	}

	@Override
	public List<Schedule> scheduleList(Map<String, Object> map) {
		return sqlSession.selectList("schedule.scheduleList",map);
	}

	@Override
	public int scheduleDelete(Schedule schedule) {
		return sqlSession.delete("schedule.scheduleDelete",schedule);
	}

	@Override
	public int scheduleUpdate(Schedule schedule) {
		return sqlSession.update("schedule.scheduleUpdate",schedule);
	}
}
