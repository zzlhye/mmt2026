package com.mis.domain;

import java.util.Date;

public class TeamMemberVO {

	private int teamNum;
	private String userId;
	private String part; // M:멘토 S:멘티
	private String name;
	private Date jumin;
	private String school;

	public int getTeamNum() {
		return teamNum;
	}

	public void setTeamNum(int teamNum) {
		this.teamNum = teamNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPart() {
		return part;
	}

	public void setPart(String part) {
		this.part = part;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getJumin() {
		return jumin;
	}

	public void setJumin(Date jumin) {
		this.jumin = jumin;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	@Override
	public String toString() {
		return "TeamMemberVO [teamNum=" + teamNum + ", userId=" + userId + ", part=" + part + ", name=" + name
				+ ", jumin=" + jumin + ", school=" + school + "]";
	}

}
