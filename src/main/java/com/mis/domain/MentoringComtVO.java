package com.mis.domain;

import java.util.Date;

public class MentoringComtVO {

	private int comtNum;
	private String content;
	private Date regDate;
	private int mentoringNum;
	private String userId;
	private String name;

	public int getComtNum() {
		return comtNum;
	}

	public void setComtNum(int comtNum) {
		this.comtNum = comtNum;
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

	public int getMentoringNum() {
		return mentoringNum;
	}

	public void setMentoringNum(int mentoringNum) {
		this.mentoringNum = mentoringNum;
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

	@Override
	public String toString() {
		return "MentoringComtVO [comtNum=" + comtNum + ", content=" + content + ", regDate=" + regDate
				+ ", mentoringNum=" + mentoringNum + ", userId=" + userId + ", name=" + name + "]";
	}

}
