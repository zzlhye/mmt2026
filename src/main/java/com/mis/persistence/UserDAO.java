package com.mis.persistence;

import java.util.List;

import com.mis.domain.SearchCriteria;
import com.mis.domain.UserVO;
import com.mis.dto.LoginDTO;
import com.mis.dto.YearTermDTO;

public interface UserDAO {

	public UserVO login(LoginDTO dto) throws Exception;

	public void mentoCreate(UserVO vo) throws Exception;

	public void mentiCreate(UserVO vo) throws Exception;

	public UserVO read(String userId) throws Exception;

	public void update(UserVO vo) throws Exception;

	public void delete(String userId) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public List<UserVO> listSearch(SearchCriteria cri) throws Exception;

	public int countByUserId(String userId);

	public YearTermDTO selectUserTeamTerm(String userId) throws Exception;

	public void deleteMentoringComtByUserId(String userId) throws Exception;

	public void deleteMentoringRelateByUserId(String userId) throws Exception;

	public void deleteMentoringByUserId(String userId) throws Exception;

	public void deletePatritByUserId(String userId) throws Exception;

	public void deleteTeamMemberByUserId(String userId) throws Exception;

	public void deleteTeamByOwnerUserId(String userId) throws Exception;

	public void deleteWeeklyByUserId(String userId) throws Exception;

}
