package com.mis.domain;

public class MentoringFileVO {

	private int fileNum;
	private String fileName;
	private int mentoringNum;
	private String files;

	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getMentoringNum() {
		return mentoringNum;
	}

	public void setMentoringNum(int mentoringNum) {
		this.mentoringNum = mentoringNum;
	}

	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
	}

	@Override
	public String toString() {
		return "MentoringFileVO [fileNum=" + fileNum + ", fileName=" + fileName + ", mentoringNum=" + mentoringNum
				+ ", files=" + files + "]";
	}

}
