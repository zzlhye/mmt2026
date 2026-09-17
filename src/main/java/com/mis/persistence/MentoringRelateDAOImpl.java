package com.mis.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MentoringRelateDAOImpl implements MentoringRelateDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "com.mis.mapper.MentoringRelateMapper";

	// 사용자가 선택한 반응 조회
	@Override
	public String getType(int mentoringNum, String userId) throws Exception {

		Map<String, Object> param = new HashMap<>();
		param.put("mentoringNum", mentoringNum);
		param.put("userId", userId);

		return session.selectOne(namespace + ".getType", param);
	}

	// 반응 등록
	@Override
	public void create(int mentoringNum, String userId, String relateType) throws Exception {

		Map<String, Object> param = new HashMap<>();
		param.put("mentoringNum", mentoringNum);
		param.put("userId", userId);
		param.put("relateType", relateType);

		session.insert(namespace + ".create", param);
	}

	// 사용자의 반응 삭제
	@Override
	public void delete(int mentoringNum, String userId) throws Exception {

		Map<String, Object> param = new HashMap<>();
		param.put("mentoringNum", mentoringNum);
		param.put("userId", userId);

		session.delete(namespace + ".delete", param);
	}

	// 게시글의 모든 반응 삭제
	@Override
	public void deleteAll(int mentoringNum) throws Exception {
		session.delete(namespace + ".deleteAll", mentoringNum);
	}

	// 전체 반응 수
	@Override
	public int countAll(int mentoringNum) throws Exception {
		return session.selectOne(namespace + ".countAll", mentoringNum);
	}

	// 반응별 개수
	@Override
	public int countEmo1(int mentoringNum) throws Exception {
		return session.selectOne(namespace + ".countEmo1", mentoringNum);
	}

	@Override
	public int countEmo2(int mentoringNum) throws Exception {
		return session.selectOne(namespace + ".countEmo2", mentoringNum);
	}

	@Override
	public int countEmo3(int mentoringNum) throws Exception {
		return session.selectOne(namespace + ".countEmo3", mentoringNum);
	}

	@Override
	public int countEmo4(int mentoringNum) throws Exception {
		return session.selectOne(namespace + ".countEmo4", mentoringNum);
	}

	@Override
	public int countEmo5(int mentoringNum) throws Exception {
		return session.selectOne(namespace + ".countEmo5", mentoringNum);
	}

	@Override
	public int countEmo6(int mentoringNum) throws Exception {
		return session.selectOne(namespace + ".countEmo6", mentoringNum);
	}

	@Override
	public int countEmo7(int mentoringNum) throws Exception {
		return session.selectOne(namespace + ".countEmo7", mentoringNum);
	}
}