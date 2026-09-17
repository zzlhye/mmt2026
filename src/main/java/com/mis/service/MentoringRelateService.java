package com.mis.service;

public interface MentoringRelateService {

	// 반응 등록 / 변경 / 취소
	public String toggle(int mentoringNum, String userId, String relateType) throws Exception;

	// 사용자가 선택한 반응 조회
	public String getType(int mentoringNum, String userId) throws Exception;

	// 전체 반응 수
	public int countAll(int mentoringNum) throws Exception;

	// 반응별 개수
	public int countEmo1(int mentoringNum) throws Exception;

	public int countEmo2(int mentoringNum) throws Exception;

	public int countEmo3(int mentoringNum) throws Exception;

	public int countEmo4(int mentoringNum) throws Exception;

	public int countEmo5(int mentoringNum) throws Exception;

	public int countEmo6(int mentoringNum) throws Exception;

	public int countEmo7(int mentoringNum) throws Exception;
}