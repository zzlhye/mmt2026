package com.mis.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class WeeklyVO {

	private int weeklyNum;
	private int weekName;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String activityName;
	private Date regDate;
	private String userId;
	private int teamNum;

	private boolean open;

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
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

	public int getTeamNum() {
		return teamNum;
	}

	public void setTeamNum(int teamNum) {
		this.teamNum = teamNum;
	}

	@Override
	public String toString() {
		return "WeeklyVO [weeklyNum=" + weeklyNum + ", weekName=" + weekName + ", startDate=" + startDate + ", endDate="
				+ endDate + ", activityName=" + activityName + ", regDate=" + regDate + ", userId=" + userId
				+ ", teamNum=" + teamNum + ", open=" + open + "]";
	}

}
