package com.mis.domain;

import java.util.Date;

public class PatritVO {

	private int patritNum;
	private String content;
	private Date regDate;
	private int teamNum;
	private String teamName;
	private String year;
	private String term;
	private String userId;
	private String name;
	private String authority;

	public int getPatritNum() {
		return patritNum;
	}

	public void setPatritNum(int patritNum) {
		this.patritNum = patritNum;
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

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	@Override
	public String toString() {
		return "PatritVO [patritNum=" + patritNum + ", content=" + content + ", regDate=" + regDate + ", teamNum="
				+ teamNum + ", teamName=" + teamName + ", year=" + year + ", term=" + term + ", userId=" + userId
				+ ", name=" + name + ", authority=" + authority + "]";
	}

}
