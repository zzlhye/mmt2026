package com.mis.service;

import java.util.List;

import com.mis.domain.PreTrainingFileVO;
import com.mis.domain.PreTrainingVO;
import com.mis.domain.SearchCriteria;

public interface PreTrainingService {

	public void create(PreTrainingVO vo) throws Exception;

	public PreTrainingVO read(int preNum) throws Exception;

	public void update(PreTrainingVO vo) throws Exception;

	public void delete(int preNum) throws Exception;

	public void onlyFileDelete(int fileNum) throws Exception;

	public List<PreTrainingFileVO> fileList(int preNum) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public List<PreTrainingVO> listSearch(SearchCriteria cri) throws Exception;

}
