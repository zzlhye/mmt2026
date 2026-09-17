package com.mis.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mis.domain.SearchCriteria;
import com.mis.domain.TeamMemberVO;
import com.mis.domain.TeamVO;
import com.mis.dto.YearTermDTO;

@Repository
public class TeamDAOImpl implements TeamDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "com.mis.mapper.TeamMapper";

	@Override
	public int create(TeamVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
		return vo.getTeamNum();
	}

	@Override
	public TeamVO read(int teamNum) throws Exception {
		return session.selectOne(namespace + ".read", teamNum);
	}

	@Override
	public void update(TeamVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(int teamNum) throws Exception {
		session.delete(namespace + ".delete", teamNum);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace + ".listSearchCount", cri);
	}

	@Override
	public List<TeamVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".listSearch", cri);
	}

	// 연도/학기
	@Override
	public YearTermDTO selectLatestYearTerm() throws Exception {
		return session.selectOne(namespace + ".selectLatestYearTerm");
	}

	@Override
	public List<YearTermDTO> selectYearTermList() throws Exception {
		return session.selectList(namespace + ".selectYearTermList");
	}

	// 팀원
	@Override
	public void insertMember(TeamMemberVO vo) throws Exception {
		session.insert(namespace + ".insertMember", vo);
	}

	@Override
	public List<TeamMemberVO> listMembers(int teamNum) throws Exception {
		return session.selectList(namespace + ".listMembers", teamNum);
	}

	@Override
	public void deleteTeamMember(int teamNum) throws Exception {
		session.delete(namespace + ".deleteTeamMember", teamNum);
	}
}