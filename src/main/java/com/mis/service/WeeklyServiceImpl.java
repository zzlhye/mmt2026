package com.mis.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.mis.domain.WeeklyVO;
import com.mis.persistence.WeeklyDAO;

@Service
public class WeeklyServiceImpl implements WeeklyService {

	@Inject
	private WeeklyDAO weeklyDao;

	@Override
	public void create(WeeklyVO vo) throws Exception {
		weeklyDao.create(vo);
	}

	@Override
	public WeeklyVO read(int weeklyNum) throws Exception {
		return weeklyDao.read(weeklyNum);
	}

	@Override
	public void update(WeeklyVO vo) throws Exception {
		weeklyDao.update(vo);
	}

	@Override
	public void delete(int weeklyNum) throws Exception {
		weeklyDao.delete(weeklyNum);
	}

	@Override
	public List<WeeklyVO> teamWeeklyList(int teamNum) throws Exception {
		return weeklyDao.teamWeeklyList(teamNum);
	}
}
