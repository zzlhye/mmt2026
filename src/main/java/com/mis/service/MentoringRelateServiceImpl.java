package com.mis.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mis.persistence.MentoringRelateDAO;

@Service
public class MentoringRelateServiceImpl implements MentoringRelateService {

	@Inject
	private MentoringRelateDAO mentoringRelateDao;

	// 반응 등록 / 변경 / 취소
	@Override
	@Transactional
	public String toggle(int mentoringNum, String userId, String relateType) throws Exception {

		String currentType = mentoringRelateDao.getType(mentoringNum, userId);

		// 기존 반응이 없는 경우
		if (currentType == null) {
			mentoringRelateDao.create(mentoringNum, userId, relateType);
			return relateType;
		}

		// 같은 반응을 다시 선택한 경우
		if (currentType.equals(relateType)) {
			mentoringRelateDao.delete(mentoringNum, userId);
			return null;
		}

		// 다른 반응을 선택한 경우
		mentoringRelateDao.delete(mentoringNum, userId);
		mentoringRelateDao.create(mentoringNum, userId, relateType);

		return relateType;
	}

	// 사용자가 선택한 반응 조회
	@Override
	public String getType(int mentoringNum, String userId) throws Exception {
		return mentoringRelateDao.getType(mentoringNum, userId);
	}

	// 전체 반응 수
	@Override
	public int countAll(int mentoringNum) throws Exception {
		return mentoringRelateDao.countAll(mentoringNum);
	}

	// 반응별 개수
	@Override
	public int countEmo1(int mentoringNum) throws Exception {
		return mentoringRelateDao.countEmo1(mentoringNum);
	}

	@Override
	public int countEmo2(int mentoringNum) throws Exception {
		return mentoringRelateDao.countEmo2(mentoringNum);
	}

	@Override
	public int countEmo3(int mentoringNum) throws Exception {
		return mentoringRelateDao.countEmo3(mentoringNum);
	}

	@Override
	public int countEmo4(int mentoringNum) throws Exception {
		return mentoringRelateDao.countEmo4(mentoringNum);
	}

	@Override
	public int countEmo5(int mentoringNum) throws Exception {
		return mentoringRelateDao.countEmo5(mentoringNum);
	}

	@Override
	public int countEmo6(int mentoringNum) throws Exception {
		return mentoringRelateDao.countEmo6(mentoringNum);
	}

	@Override
	public int countEmo7(int mentoringNum) throws Exception {
		return mentoringRelateDao.countEmo7(mentoringNum);
	}
}