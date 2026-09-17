package com.mis.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mis.domain.PatritVO;
import com.mis.dto.YearTermDTO;

@Repository
public class PatritDAOImpl implements PatritDAO {

	private static final String NAMESPACE = "com.mis.mapper.patritMapper";

	@Inject
	private SqlSession session;

	@Override
	public void create(PatritVO vo) throws Exception {
		session.insert(NAMESPACE + ".create", vo);
	}

	@Override
	public PatritVO read(int patritNum) throws Exception {
		return session.selectOne(NAMESPACE + ".read", patritNum);
	}

	@Override
	public void update(PatritVO vo) throws Exception {
		session.update(NAMESPACE + ".update", vo);
	}

	@Override
	public void delete(int patritNum) throws Exception {
		session.delete(NAMESPACE + ".delete", patritNum);
	}

	@Override
	public YearTermDTO selectLatestYearTerm() throws Exception {
		return session.selectOne(NAMESPACE + ".selectLatestYearTerm");
	}

	@Override
	public List<YearTermDTO> selectYearTermList() throws Exception {
		return session.selectList(NAMESPACE + ".selectYearTermList");
	}

	@Override
	public int countPatritByYearTermMembers(Map<String, Object> param) throws Exception {
		return session.selectOne(NAMESPACE + ".countPatritByYearTermMembers", param);
	}

	@Override
	public List<PatritVO> selectPatritByYearTermMembersPaging(Map<String, Object> param) throws Exception {
		return session.selectList(NAMESPACE + ".selectPatritByYearTermMembersPaging", param);
	}

	@Override
	public PatritVO selectMyTeamInfo(String userId) throws Exception {
		return session.selectOne(NAMESPACE + ".selectMyTeamInfo", userId);
	}

	@Override
	public void deleteTeam(int teamNum) throws Exception {
		session.delete(NAMESPACE + ".deleteTeam", teamNum);
	}

	@Override
	public int countMyPatritByYearTerm(Map<String, Object> param) throws Exception {
		return session.selectOne(NAMESPACE + ".countMyPatritByYearTerm", param);
	}
}
