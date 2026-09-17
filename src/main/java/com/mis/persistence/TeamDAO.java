package com.mis.persistence;

import java.util.List;

import com.mis.domain.SearchCriteria;
import com.mis.domain.TeamMemberVO;
import com.mis.domain.TeamVO;
import com.mis.dto.YearTermDTO;

public interface TeamDAO {

	public int create(TeamVO vo) throws Exception;

	public TeamVO read(int teamNum) throws Exception;

	public void update(TeamVO vo) throws Exception;

	public void deleteTeamMember(int teamNum) throws Exception;

	public void delete(int teamNum) throws Exception;

	// 최신 연도/학기 1개
	public YearTermDTO selectLatestYearTerm() throws Exception;

	// 연도/학기 목록
	public List<YearTermDTO> selectYearTermList() throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public List<TeamVO> listSearch(SearchCriteria cri) throws Exception;

	public void insertMember(TeamMemberVO vo) throws Exception;

	public List<TeamMemberVO> listMembers(int teamNum) throws Exception;

}
