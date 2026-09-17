package com.mis.persistence;

import java.util.List;

import com.mis.domain.MentoringFileVO;
import com.mis.domain.MentoringVO;
import com.mis.domain.TeamVO;
import com.mis.dto.YearTermDTO;

public interface MentoringDAO {

	// 멘토링 게시글
	public void create(MentoringVO vo) throws Exception;

	public MentoringVO read(int mentoringNum) throws Exception;

	public void update(MentoringVO vo) throws Exception;

	public void delete(int mentoringNum) throws Exception;

	public void viewCount(int mentoringNum) throws Exception;

	// 첨부파일
	public void insertFile(MentoringFileVO vo) throws Exception;

	public void deleteFile(int mentoringNum) throws Exception;

	public void onlyFileDelete(int fileNum) throws Exception;

	public List<MentoringFileVO> fileList(int mentoringNum) throws Exception;

	// 연도 / 학기
	public YearTermDTO selectLatestYearTerm() throws Exception;

	public List<YearTermDTO> selectYearTermList() throws Exception;

	// 팀 목록
	public List<TeamVO> selectTeamsByYearTerm(String year, String term) throws Exception;

	public List<TeamVO> selectMyTeamsByYearTerm(String year, String term, String userId) throws Exception;

	// 팀별 멘토링 게시글
	public List<MentoringVO> listByTeamWithThumb(int teamNum) throws Exception;

	// 댓글 수
	public int countComt(int mentoringNum) throws Exception;
}