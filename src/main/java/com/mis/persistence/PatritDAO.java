package com.mis.persistence;

import java.util.List;
import java.util.Map;

import com.mis.domain.PatritVO;
import com.mis.dto.YearTermDTO;

public interface PatritDAO {

	public void create(PatritVO vo) throws Exception;

	public PatritVO read(int patritNum) throws Exception;

	public void update(PatritVO vo) throws Exception;

	public void delete(int patritNum) throws Exception;

	public void deleteTeam(int teamNum) throws Exception;

	public YearTermDTO selectLatestYearTerm() throws Exception;

	public List<YearTermDTO> selectYearTermList() throws Exception;

	public int countPatritByYearTermMembers(Map<String, Object> param) throws Exception;

	public List<PatritVO> selectPatritByYearTermMembersPaging(Map<String, Object> param) throws Exception;

	public PatritVO selectMyTeamInfo(String userId) throws Exception;
	
	public int countMyPatritByYearTerm(Map<String, Object> param) throws Exception;
}