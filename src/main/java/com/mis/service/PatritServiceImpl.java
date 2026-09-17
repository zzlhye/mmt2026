package com.mis.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.mis.domain.Criteria;
import com.mis.domain.PatritVO;
import com.mis.dto.YearTermDTO;
import com.mis.persistence.PatritDAO;

@Service
public class PatritServiceImpl implements PatritService {

	@Inject
	private PatritDAO patritDao;

	@Override
	public void create(PatritVO vo) throws Exception {
		patritDao.create(vo);
	}

	@Override
	public PatritVO read(int patritNum) throws Exception {
		return patritDao.read(patritNum);
	}

	@Override
	public void update(PatritVO vo) throws Exception {
		patritDao.update(vo);
	}

	@Override
	public void delete(int patritNum) throws Exception {
		patritDao.delete(patritNum);
	}

	@Override
	public YearTermDTO selectLatestYearTerm() throws Exception {
		return patritDao.selectLatestYearTerm();
	}

	@Override
	public List<YearTermDTO> selectYearTermList() throws Exception {
		return patritDao.selectYearTermList();
	}

	@Override
	public int countPatritByYearTermMembers(String year, String term) throws Exception {

		Map<String, Object> param = new HashMap<>();
		param.put("year", year);
		param.put("term", term);

		return patritDao.countPatritByYearTermMembers(param);
	}

	@Override
	public List<PatritVO> selectPatritByYearTermMembersPaging(String year, String term, Criteria cri) throws Exception {

		Map<String, Object> param = new HashMap<>();
		param.put("year", year);
		param.put("term", term);
		param.put("pageStart", cri.getPageStart());
		param.put("pageEnd", cri.getPageEnd());

		return patritDao.selectPatritByYearTermMembersPaging(param);
	}

	@Override
	public PatritVO selectMyTeamInfo(String userId) throws Exception {
		return patritDao.selectMyTeamInfo(userId);
	}

	@Override
	public int countMyPatritByYearTerm(String userId, String year, String term) throws Exception {

		Map<String, Object> param = new HashMap<>();

		param.put("userId", userId);
		param.put("year", year);
		param.put("term", term);

		return patritDao.countMyPatritByYearTerm(param);
	}
}