package com.mis.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mis.domain.SearchCriteria;
import com.mis.domain.UserVO;
import com.mis.dto.LoginDTO;
import com.mis.dto.YearTermDTO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "com.mis.mapper.userMapper";

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return session.selectOne(namespace + ".login", dto);
	}

	@Override
	public void mentoCreate(UserVO vo) throws Exception {
		session.insert(namespace + ".mentoCreate", vo);
	}

	@Override
	public void mentiCreate(UserVO vo) throws Exception {
		session.insert(namespace + ".mentiCreate", vo);
	}

	@Override
	public UserVO read(String userId) throws Exception {
		return session.selectOne(namespace + ".read", userId);
	}

	@Override
	public void update(UserVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(String userId) throws Exception {
		session.delete(namespace + ".delete", userId);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace + ".listSearchCount", cri);
	}

	@Override
	public List<UserVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public int countByUserId(String userId) {
		return session.selectOne(namespace + ".countByUserId", userId);
	}

	@Override
	public YearTermDTO selectUserTeamTerm(String userId) throws Exception {
		return session.selectOne(namespace + ".selectUserTeamTerm", userId);
	}

	@Override
	public void deleteMentoringComtByUserId(String userId) throws Exception {
		session.delete(namespace + ".deleteMentoringComtByUserId", userId);
	}

	@Override
	public void deleteMentoringRelateByUserId(String userId) throws Exception {
		session.delete(namespace + ".deleteMentoringRelateByUserId", userId);
	}

	@Override
	public void deleteMentoringByUserId(String userId) throws Exception {
		session.delete(namespace + ".deleteMentoringByUserId", userId);
	}

	@Override
	public void deletePatritByUserId(String userId) throws Exception {
		session.delete(namespace + ".deletePatritByUserId", userId);
	}

	@Override
	public void deleteTeamMemberByUserId(String userId) throws Exception {
		session.delete(namespace + ".deleteTeamMemberByUserId", userId);
	}

	@Override
	public void deleteTeamByOwnerUserId(String userId) throws Exception {
		session.delete(namespace + ".deleteTeamByOwnerUserId", userId);
	}

	@Override
	public void deleteWeeklyByUserId(String userId) throws Exception {
		session.delete(namespace + ".deleteWeeklyByUserId", userId);
	}

}
