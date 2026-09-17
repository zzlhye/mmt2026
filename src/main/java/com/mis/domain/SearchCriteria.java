package com.mis.domain;

public class SearchCriteria extends Criteria {

	private String searchType; // id, n, p, s 등
	private String keyword; // 검색어

	// 멘토(M) / 멘티(S) 필터 (공통 사용 가능, 기본 null)
	private String authority;

	// ✅ 추가: 연도/학기 필터 (팀관리/성찰일지/활동보고서 리스트 공통 사용)
	private String year;
	private String term;

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
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

	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + ", authority=" + authority
				+ ", year=" + year + ", term=" + term + "]";
	}
}
