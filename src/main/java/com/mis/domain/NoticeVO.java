package com.mis.domain;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

public class NoticeVO {

	private int noticeNum;
	private String title;
	private String content;
	private String category; // M:멘토 S:멘티 A:전체
	private Date regDate;
	private int viewCount;
	private String userId;

	private String[] files; // 다수의 첨부파일 이름을 저장하기 위함
	private int fileCnt; // 첨부파일 개수
	private ArrayList<NoticeFileVO> fileList; // 상세보기 file 여러 개 가져오기

	public int getNoticeNum() {
		return noticeNum;
	}

	public void setNoticeNum(int noticeNum) {
		this.noticeNum = noticeNum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String[] getFiles() {
		return files;
	}

	public void setFiles(String[] files) {
		this.files = files;
	}

	public int getFileCnt() {
		return fileCnt;
	}

	public void setFileCnt(int fileCnt) {
		this.fileCnt = fileCnt;
	}

	public ArrayList<NoticeFileVO> getFileList() {
		return fileList;
	}

	public void setFileList(ArrayList<NoticeFileVO> fileList) {
		this.fileList = fileList;
	}

	@Override
	public String toString() {
		return "NoticeVO [noticeNum=" + noticeNum + ", title=" + title + ", content=" + content + ", category="
				+ category + ", regDate=" + regDate + ", viewCount=" + viewCount + ", userId=" + userId + ", files="
				+ Arrays.toString(files) + ", fileCnt=" + fileCnt + ", fileList=" + fileList + "]";
	}

}
