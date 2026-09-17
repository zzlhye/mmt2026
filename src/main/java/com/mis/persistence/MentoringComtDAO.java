package com.mis.persistence;

import java.util.List;

import com.mis.domain.MentoringComtVO;

public interface MentoringComtDAO {

	public void create(MentoringComtVO vo) throws Exception;

	public List<MentoringComtVO> list(int mentoringNum) throws Exception;

	public void delete(int comtNum) throws Exception;

	public void deleteAll(int mentoringNum) throws Exception;

	public void deleteUser(String userId) throws Exception;

}
