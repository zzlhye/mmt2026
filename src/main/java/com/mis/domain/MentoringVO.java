package com.mis.domain;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

public class MentoringVO {

	private int mentoringNum;
	private String title;
	private String content;
	private Date regDate;
	private int viewCount;
	private int teamNum;
	private String teamName;
	private String intro;
	private int weeklyNum;
	private int weekName;
	private Date startDate;
	private Date endDate;
	private String activityName;
	private String userId;
	private String name;
	private String thumbFileName; // 멘토링 목록에서 사용할 대표 사진

	private String[] files; // 다수의 첨부파일 이름을 저장하기 위함
	private int fileCnt; // 첨부파일 개수
	private ArrayList<MentoringFileVO> fileList; // 상세보기 file 여러 개 가져오기

	public int getMentoringNum() {
		return mentoringNum;
	}

	public void setMentoringNum(int mentoringNum) {
		this.mentoringNum = mentoringNum;
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

	public int getTeamNum() {
		return teamNum;
	}

	public void setTeamNum(int teamNum) {
		this.teamNum = teamNum;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public int getWeeklyNum() {
		return weeklyNum;
	}

	public void setWeeklyNum(int weeklyNum) {
		this.weeklyNum = weeklyNum;
	}

	public int getWeekName() {
		return weekName;
	}

	public void setWeekName(int weekName) {
		this.weekName = weekName;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getThumbFileName() {
		return thumbFileName;
	}

	public void setThumbFileName(String thumbFileName) {
		this.thumbFileName = thumbFileName;
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

	public ArrayList<MentoringFileVO> getFileList() {
		return fileList;
	}

	public void setFileList(ArrayList<MentoringFileVO> fileList) {
		this.fileList = fileList;
	}

	@Override
	public String toString() {
		return "MentoringVO [mentoringNum=" + mentoringNum + ", title=" + title + ", content=" + content + ", regDate="
				+ regDate + ", viewCount=" + viewCount + ", teamNum=" + teamNum + ", teamName=" + teamName + ", intro="
				+ intro + ", weeklyNum=" + weeklyNum + ", weekName=" + weekName + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", activityName=" + activityName + ", userId=" + userId + ", name=" + name
				+ ", thumbFileName=" + thumbFileName + ", files=" + Arrays.toString(files) + ", fileCnt=" + fileCnt
				+ ", fileList=" + fileList + "]";
	}

}
