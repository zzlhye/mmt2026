package com.mis.service;

import java.util.List;

import com.mis.domain.MentoringFileVO;
import com.mis.domain.MentoringVO;
import com.mis.domain.TeamVO;
import com.mis.dto.YearTermDTO;

public interface MentoringService {

	// 멘토링 게시글
	public void create(MentoringVO vo) throws Exception;

	public MentoringVO read(int mentoringNum) throws Exception;

	public void update(MentoringVO vo) throws Exception;

	public void delete(int mentoringNum) throws Exception;

	// 첨부파일
	public void onlyFileDelete(int fileNum) throws Exception;

	public List<MentoringFileVO> fileList(int mentoringNum) throws Exception;

	// 연도 / 학기
	public YearTermDTO getLatestYearTerm() throws Exception;

	public List<YearTermDTO> getYearTermList() throws Exception;

	// 팀 목록
	public List<TeamVO> getTeamsByYearTerm(String year, String term) throws Exception;

	public List<TeamVO> getMyTeamsByYearTerm(String year, String term, String userId) throws Exception;

	// 팀별 멘토링 게시글
	public List<MentoringVO> mentoringListByTeamWithThumb(int teamNum) throws Exception;

	// 댓글 수
	public int countComt(int mentoringNum) throws Exception;
}