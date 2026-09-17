package com.mis.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class UserVO {

	private String userId;
	private String userPw;
	private String name;
	private String phone;
	private String email1;
	private String email2;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date jumin;
	private String authority; // M:멘토 S:멘티 A:관리자
	private String school;
	private int grade;
	private Date regDate;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public Date getJumin() {
		return jumin;
	}

	public void setJumin(Date jumin) {
		this.jumin = jumin;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", userPw=" + userPw + ", name=" + name + ", phone=" + phone + ", email1="
				+ email1 + ", email2=" + email2 + ", jumin=" + jumin + ", authority=" + authority + ", school=" + school
				+ ", grade=" + grade + ", regDate=" + regDate + "]";
	}

}
