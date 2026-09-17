package com.mis.service;

import java.util.List;

import com.mis.domain.Criteria;
import com.mis.domain.PatritVO;
import com.mis.dto.YearTermDTO;

public interface PatritService {

	public void create(PatritVO vo) throws Exception;

	public PatritVO read(int patritNum) throws Exception;

	public void update(PatritVO vo) throws Exception;

	public void delete(int patritNum) throws Exception;

	public YearTermDTO selectLatestYearTerm() throws Exception;

	public List<YearTermDTO> selectYearTermList() throws Exception;

	public int countPatritByYearTermMembers(String year, String term) throws Exception;

	public List<PatritVO> selectPatritByYearTermMembersPaging(String year, String term, Criteria cri) throws Exception;

	public PatritVO selectMyTeamInfo(String userId) throws Exception;

	public int countMyPatritByYearTerm(String userId, String year, String term) throws Exception;
}
