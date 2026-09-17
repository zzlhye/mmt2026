package com.mis.persistence;

import java.util.List;

import com.mis.domain.NoticeFileVO;
import com.mis.domain.NoticeVO;
import com.mis.domain.SearchCriteria;

public interface NoticeDAO {

	public void create(NoticeVO vo) throws Exception;

	public NoticeVO read(int noticeNum) throws Exception;

	public void update(NoticeVO vo) throws Exception;

	public void delete(int noticeNum) throws Exception;

	public void viewCount(int noticeNum) throws Exception;

	public void insertFile(NoticeFileVO vo) throws Exception;

	public void deleteFile(int noticeNum) throws Exception;

	public void onlyFileDelete(int fileNum) throws Exception;

	public List<NoticeFileVO> fileList(int noticeNum) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public List<NoticeVO> listSearch(SearchCriteria cri) throws Exception;

}
