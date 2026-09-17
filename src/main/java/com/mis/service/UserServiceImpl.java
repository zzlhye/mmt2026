package com.mis.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mis.domain.SearchCriteria;
import com.mis.domain.UserVO;
import com.mis.dto.LoginDTO;
import com.mis.dto.YearTermDTO;
import com.mis.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO userDao;

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return userDao.login(dto);
	}

	@Override
	public void mentoCreate(UserVO vo) throws Exception {
		vo.setUserPw("1234");
		userDao.mentoCreate(vo);
	}

	@Override
	public void mentiCreate(UserVO vo) throws Exception {
		vo.setUserPw("1234");
		userDao.mentiCreate(vo);
	}

	@Override
	public UserVO read(String userId) throws Exception {
		return userDao.read(userId);
	}

	@Override
	public void update(UserVO vo) throws Exception {
		userDao.update(vo);
	}

	@Override
	@Transactional
	public void delete(String userId) throws Exception {

		// 회원이 작성한 데이터 삭제
		userDao.deleteMentoringComtByUserId(userId);
		userDao.deleteMentoringRelateByUserId(userId);
		userDao.deleteMentoringByUserId(userId);
		userDao.deletePatritByUserId(userId);

		// 팀 관련 데이터 삭제
		userDao.deleteWeeklyByUserId(userId);
		userDao.deleteTeamMemberByUserId(userId);
		userDao.deleteTeamByOwnerUserId(userId);

		// 회원 삭제
		userDao.delete(userId);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return userDao.listSearchCount(cri);
	}

	@Override
	public List<UserVO> listSearch(SearchCriteria cri) throws Exception {
		return userDao.listSearch(cri);
	}

	@Override
	public boolean isUserIdAvailable(String userId) {
		return userDao.countByUserId(userId) == 0;
	}

	@Override
	public YearTermDTO getUserTeamTerm(String userId) throws Exception {
		return userDao.selectUserTeamTerm(userId);
	}

}
