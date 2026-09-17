package com.mis.domain;

public class NoticeFileVO {

	private int fileNum;
	private String fileName;
	private int noticeNum;
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

	public int getNoticeNum() {
		return noticeNum;
	}

	public void setNoticeNum(int noticeNum) {
		this.noticeNum = noticeNum;
	}

	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
	}

	@Override
	public String toString() {
		return "NoticeFileVO [fileNum=" + fileNum + ", fileName=" + fileName + ", noticeNum=" + noticeNum + ", files="
				+ files + "]";
	}

}
