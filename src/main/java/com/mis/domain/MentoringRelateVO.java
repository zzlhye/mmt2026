package com.mis.domain;

import java.util.Date;

public class MentoringRelateVO {

	private int relateNum;
	private String relateType; // 1.좋아요 2.공감 3.응원 4.감사
	private Date regDate;
	private int mentoringNum;
	private String userId;

	public int getRelateNum() {
		return relateNum;
	}

	public void setRelateNum(int relateNum) {
		this.relateNum = relateNum;
	}

	public String getRelateType() {
		return relateType;
	}

	public void setRelateType(String relateType) {
		this.relateType = relateType;
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

	@Override
	public String toString() {
		return "MentoringRelateVO [relateNum=" + relateNum + ", relateType=" + relateType + ", regDate=" + regDate
				+ ", mentoringNum=" + mentoringNum + ", userId=" + userId + "]";
	}

}
