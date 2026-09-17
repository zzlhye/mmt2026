package com.mis.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mis.domain.SearchCriteria;
import com.mis.domain.TeamMemberVO;
import com.mis.domain.TeamVO;
import com.mis.dto.YearTermDTO;
import com.mis.persistence.PatritDAO;
import com.mis.persistence.TeamDAO;
import com.mis.persistence.WeeklyDAO;

@Service
public class TeamServiceImpl implements TeamService {

	@Inject
	private TeamDAO teamDao;

	@Inject
	private PatritDAO patritDao;

	@Inject
	private WeeklyDAO weeklyDao;

	// 팀 조회
	@Override
	public TeamVO read(int teamNum) throws Exception {
		return teamDao.read(teamNum);
	}

	// 팀 소개 수정
	@Override
	public void update(TeamVO vo) throws Exception {

		removeFirstLineBreak(vo);

		teamDao.update(vo);
	}

	// 팀 삭제
	@Transactional
	@Override
	public void delete(int teamNum) throws Exception {

		teamDao.deleteTeamMember(teamNum);
		patritDao.deleteTeam(teamNum);
		weeklyDao.deleteTeam(teamNum);
		teamDao.delete(teamNum);
	}

	// 최신 연도/학기
	@Override
	public YearTermDTO selectLatestYearTerm() throws Exception {
		return teamDao.selectLatestYearTerm();
	}

	// 연도/학기 목록
	@Override
	public List<YearTermDTO> selectYearTermList() throws Exception {
		return teamDao.selectYearTermList();
	}

	// 팀 목록
	@Override
	public List<TeamVO> listSearch(SearchCriteria cri) throws Exception {
		return teamDao.listSearch(cri);
	}

	// 팀 목록 개수
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return teamDao.listSearchCount(cri);
	}

	// 팀원 목록
	@Override
	public List<TeamMemberVO> listMembers(int teamNum) throws Exception {
		return teamDao.listMembers(teamNum);
	}

	// 팀 등록
	@Transactional
	@Override
	public int registerTeam(TeamVO team, String mentorId, List<String> menteeIds) throws Exception {

		// 대표 멘토 설정
		team.setUserId(mentorId);
		removeFirstLineBreak(team);

		// 팀 생성
		int teamNum = teamDao.create(team);

		// 팀원 등록
		registerMembers(teamNum, mentorId, menteeIds);

		return teamNum;
	}

	// 팀 수정
	@Transactional
	@Override
	public int updateTeam(TeamVO team, String mentorId, List<String> menteeIds) throws Exception {

		int teamNum = team.getTeamNum();

		// 대표 멘토 설정
		team.setUserId(mentorId);
		removeFirstLineBreak(team);

		// 팀 정보 수정
		teamDao.update(team);

		// 기존 팀원 삭제
		teamDao.deleteTeamMember(teamNum);

		// 팀원 재등록
		registerMembers(teamNum, mentorId, menteeIds);

		return teamNum;
	}

	// 팀원 등록
	private void registerMembers(int teamNum, String mentorId, List<String> menteeIds) throws Exception {

		// 멘토 등록
		TeamMemberVO mentor = new TeamMemberVO();
		mentor.setTeamNum(teamNum);
		mentor.setUserId(mentorId);
		mentor.setPart("M");

		teamDao.insertMember(mentor);

		// 멘티가 없으면 종료
		if (menteeIds == null) {
			return;
		}

		// 멘티 등록
		for (String menteeId : menteeIds) {

			if (menteeId == null) {
				continue;
			}

			String trimmedId = menteeId.trim();

			if (trimmedId.isEmpty()) {
				continue;
			}

			// 멘토가 멘티 목록에 포함된 경우 제외
			if (trimmedId.equals(mentorId)) {
				continue;
			}

			TeamMemberVO mentee = new TeamMemberVO();
			mentee.setTeamNum(teamNum);
			mentee.setUserId(trimmedId);
			mentee.setPart("S");

			teamDao.insertMember(mentee);
		}
	}

	// 소개글 맨 앞 개행 제거
	private void removeFirstLineBreak(TeamVO team) {

		if (team.getIntro() != null) {
			team.setIntro(team.getIntro().replaceFirst("^[\\r\\n]+", ""));
		}
	}
}