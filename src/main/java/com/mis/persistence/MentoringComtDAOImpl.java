package com.mis.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mis.domain.MentoringComtVO;

@Repository
public class MentoringComtDAOImpl implements MentoringComtDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "com.mis.mapper.MentoringComtMapper";

	@Override
	public void create(MentoringComtVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	@Override
	public List<MentoringComtVO> list(int mentoringNum) throws Exception {
		return session.selectList(namespace + ".list", mentoringNum);
	}

	@Override
	public void delete(int comtNum) throws Exception {
		session.delete(namespace + ".delete", comtNum);
	}

	@Override
	public void deleteAll(int mentoringNum) throws Exception {
		session.delete(namespace + ".deleteAll", mentoringNum);
	}

	@Override
	public void deleteUser(String userId) throws Exception {
		session.delete(namespace + ".deleteUser", userId);
	}
}