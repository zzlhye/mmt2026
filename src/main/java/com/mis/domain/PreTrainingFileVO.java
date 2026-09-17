package com.mis.domain;

public class PreTrainingFileVO {

	private int fileNum;
	private String fileName;
	private int preNum;

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

	public int getPreNum() {
		return preNum;
	}

	public void setPreNum(int preNum) {
		this.preNum = preNum;
	}

	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
	}

	@Override
	public String toString() {
		return "PreTrainingFileVO [fileNum=" + fileNum + ", fileName=" + fileName + ", preNum=" + preNum + ", files="
				+ files + "]";
	}

}
