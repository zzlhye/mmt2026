package com.mis.domain;

import java.util.Date;

public class TeamVO {

	private int teamNum;
	private String teamName;
	private String year;
	private String term;
	private String intro;
	private Date regDate;
	private String userId;
	private String name;

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

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
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
		return "TeamVO [teamNum=" + teamNum + ", teamName=" + teamName + ", year=" + year + ", term=" + term
				+ ", intro=" + intro + ", regDate=" + regDate + ", userId=" + userId + ", name=" + name + "]";
	}

}
