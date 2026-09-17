package com.mis.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mis.domain.MentoringFileVO;
import com.mis.domain.MentoringVO;
import com.mis.domain.TeamVO;
import com.mis.dto.YearTermDTO;

@Repository
public class MentoringDAOImpl implements MentoringDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "com.mis.mapper.MentoringMapper";

	// 멘토링 게시글
	@Override
	public void create(MentoringVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	@Override
	public MentoringVO read(int mentoringNum) throws Exception {
		return session.selectOne(namespace + ".read", mentoringNum);
	}

	@Override
	public void update(MentoringVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(int mentoringNum) throws Exception {
		session.delete(namespace + ".delete", mentoringNum);
	}

	@Override
	public void viewCount(int mentoringNum) throws Exception {
		session.update(namespace + ".viewCount", mentoringNum);
	}

	// 첨부파일
	@Override
	public void insertFile(MentoringFileVO vo) throws Exception {
		session.insert(namespace + ".insertFile", vo);
	}

	@Override
	public void deleteFile(int mentoringNum) throws Exception {
		session.delete(namespace + ".deleteFile", mentoringNum);
	}

	@Override
	public void onlyFileDelete(int fileNum) throws Exception {
		session.delete(namespace + ".onlyFileDelete", fileNum);
	}

	@Override
	public List<MentoringFileVO> fileList(int mentoringNum) throws Exception {
		return session.selectList(namespace + ".fileList", mentoringNum);
	}

	// 팀별 멘토링 게시글
	@Override
	public List<MentoringVO> listByTeamWithThumb(int teamNum) throws Exception {
		return session.selectList(namespace + ".listByTeamWithThumb", teamNum);
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

	// 관리자용 팀 목록
	@Override
	public List<TeamVO> selectTeamsByYearTerm(
			String year, String term) throws Exception {

		Map<String, Object> param = new HashMap<>();
		param.put("year", year);
		param.put("term", term);

		return session.selectList(
				namespace + ".selectTeamsByYearTerm",
				param
		);
	}

	// 멘토/멘티용 소속 팀 목록
	@Override
	public List<TeamVO> selectMyTeamsByYearTerm(
			String year, String term, String userId) throws Exception {

		Map<String, Object> param = new HashMap<>();
		param.put("year", year);
		param.put("term", term);
		param.put("userId", userId);

		return session.selectList(
				namespace + ".selectMyTeamsByYearTerm",
				param
		);
	}

	// 댓글 수
	@Override
	public int countComt(int mentoringNum) throws Exception {
		return session.selectOne(namespace + ".countComt", mentoringNum);
	}
}