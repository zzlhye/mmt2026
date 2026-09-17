package com.mis.dto;

public class YearTermDTO {

	private String year;
	private String term;

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
		return "YearTermDTO [year=" + year + ", term=" + term + "]";
	}

}
