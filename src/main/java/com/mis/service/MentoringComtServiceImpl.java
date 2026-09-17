package com.mis.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.mis.domain.MentoringComtVO;
import com.mis.persistence.MentoringComtDAO;

@Service
public class MentoringComtServiceImpl implements MentoringComtService {

	@Inject
	private MentoringComtDAO comtDao;

	@Override
	public void create(MentoringComtVO vo) throws Exception {
		comtDao.create(vo);
	}

	@Override
	public List<MentoringComtVO> list(int mentoringNum) throws Exception {
		return comtDao.list(mentoringNum);
	}

	@Override
	public void delete(int comtNum) throws Exception {
		comtDao.delete(comtNum);
	}

	@Override
	public void deleteUser(String userId) throws Exception {
		comtDao.deleteUser(userId);
	}

}
