package com.mis.persistence;

import java.util.List;

import com.mis.domain.WeeklyVO;

public interface WeeklyDAO {

	// 주차 등록
	public void create(WeeklyVO vo) throws Exception;

	// 주차 조회
	public WeeklyVO read(int weeklyNum) throws Exception;

	// 주차 수정
	public void update(WeeklyVO vo) throws Exception;

	// 주차 삭제
	public void delete(int weeklyNum) throws Exception;

	// 팀 삭제 시 주차 삭제
	public void deleteTeam(int teamNum) throws Exception;

	// 주차 목록(팀별)
	public List<WeeklyVO> teamWeeklyList(int teamNum) throws Exception;
}
