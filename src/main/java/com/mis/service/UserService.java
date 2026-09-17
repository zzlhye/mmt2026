package com.mis.service;

import java.util.List;

import com.mis.domain.SearchCriteria;
import com.mis.domain.UserVO;
import com.mis.dto.LoginDTO;
import com.mis.dto.YearTermDTO;

public interface UserService {

	public UserVO login(LoginDTO dto) throws Exception;

	public void mentoCreate(UserVO vo) throws Exception;

	public void mentiCreate(UserVO vo) throws Exception;

	public UserVO read(String userId) throws Exception;

	public void update(UserVO vo) throws Exception;

	public void delete(String userId) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public List<UserVO> listSearch(SearchCriteria cri) throws Exception;

	public boolean isUserIdAvailable(String userId);

	public YearTermDTO getUserTeamTerm(String userId) throws Exception;
}
