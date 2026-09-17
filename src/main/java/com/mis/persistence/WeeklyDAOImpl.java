package com.mis.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mis.domain.WeeklyVO;

@Repository
public class WeeklyDAOImpl implements WeeklyDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "com.mis.mapper.weeklyMapper";

	@Override
	public void create(WeeklyVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	@Override
	public WeeklyVO read(int weeklyNum) throws Exception {
		return session.selectOne(namespace + ".read", weeklyNum);
	}

	@Override
	public void update(WeeklyVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(int weeklyNum) throws Exception {
		session.delete(namespace + ".delete", weeklyNum);
	}

	@Override
	public List<WeeklyVO> teamWeeklyList(int teamNum) throws Exception {
		return session.selectList(namespace + ".teamWeeklyList", teamNum);
	}

	@Override
	public void deleteTeam(int teamNum) throws Exception {
		session.delete(namespace + ".deleteTeam", teamNum);
	}

}
