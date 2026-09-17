package com.mis.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.mis.domain.PreTrainingFileVO;
import com.mis.domain.PreTrainingVO;
import com.mis.domain.SearchCriteria;

@Repository
public class PreTrainingDAOImpl implements PreTrainingDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "com.mis.mapper.preTrainingMapper";

	@Override
	public void create(PreTrainingVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	@Override
	public PreTrainingVO read(int preNum) throws Exception {
		return session.selectOne(namespace + ".read", preNum);
	}

	@Override
	public void update(PreTrainingVO vo) throws Exception {
		session.update(namespace + ".update", vo);
	}

	@Override
	public void delete(int preNum) throws Exception {
		session.delete(namespace + ".delete", preNum);
	}

	@Override
	public void insertFile(PreTrainingFileVO vo) throws Exception {
		session.insert(namespace + ".insertFile", vo);
	}

	@Override
	public void deleteFile(int preNum) throws Exception {
		session.delete(namespace + ".deleteFile", preNum);
	}

	@Override
	public void onlyFileDelete(int fileNum) throws Exception {
		session.delete(namespace + ".onlyFileDelete", fileNum);
	}

	@Override
	public List<PreTrainingFileVO> fileList(int preNum) throws Exception {
		return session.selectList(namespace + ".fileList", preNum);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne(namespace + ".listSearchCount", cri);
	}

	@Override
	public List<PreTrainingVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public void viewCount(int preNum) throws Exception {
		session.update(namespace + ".viewCount", preNum);
	}

}
