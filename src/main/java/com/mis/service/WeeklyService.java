package com.mis.service;

import java.util.List;

import com.mis.domain.WeeklyVO;

public interface WeeklyService {

	public void create(WeeklyVO vo) throws Exception;

	public WeeklyVO read(int weeklyNum) throws Exception;

	public void update(WeeklyVO vo) throws Exception;

	public void delete(int weeklyNum) throws Exception;

	public List<WeeklyVO> teamWeeklyList(int teamNum) throws Exception;

}
