package com.mis.service;

import java.util.List;

import com.mis.domain.SearchCriteria;
import com.mis.domain.TeamMemberVO;
import com.mis.domain.TeamVO;
import com.mis.dto.YearTermDTO;

public interface TeamService {

	// 팀 조회
	public TeamVO read(int teamNum) throws Exception;

	// 팀 소개 수정
	public void update(TeamVO vo) throws Exception;

	// 팀 삭제
	public void delete(int teamNum) throws Exception;

	// 팀 등록
	public int registerTeam(TeamVO team, String mentorId, List<String> menteeIds) throws Exception;

	// 팀 수정
	public int updateTeam(TeamVO team, String mentorId, List<String> menteeIds) throws Exception;

	// 팀원 목록
	public List<TeamMemberVO> listMembers(int teamNum) throws Exception;

	// 최신 연도/학기
	public YearTermDTO selectLatestYearTerm() throws Exception;

	// 연도/학기 목록
	public List<YearTermDTO> selectYearTermList() throws Exception;

	// 팀 목록
	public List<TeamVO> listSearch(SearchCriteria cri) throws Exception;

	// 팀 목록 개수
	public int listSearchCount(SearchCriteria cri) throws Exception;
}