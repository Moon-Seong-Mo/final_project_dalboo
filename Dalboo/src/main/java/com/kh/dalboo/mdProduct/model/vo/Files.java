package com.kh.dalboo.mdProduct.model.vo;

import java.sql.Date;

public class Files {
	
	
	private int fileNum;		//파일 시퀀스		
	private String originName;	//기존 이름
	private String changeName;	//바꾼 이름
	private String filePath;	//경로
	private int photoLevel;		//썸네일 0 / 나머지 1
	private int boardNum;		//내가 가져올 게시판 번호
	private Date uploadDate;	
	private String status;	
	
	public Files() {}

	public Files(int fileNum, String originName, String changeName, String filePath, int photoLevel, int boardNum,
			Date uploadDate, String status) {
		super();
		this.fileNum = fileNum;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.photoLevel = photoLevel;
		this.boardNum = boardNum;
		this.uploadDate = uploadDate;
		this.status = status;
	}

	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getPhotoLevel() {
		return photoLevel;
	}

	public void setPhotoLevel(int photoLevel) {
		this.photoLevel = photoLevel;
	}

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Files [fileNum=" + fileNum + ", originName=" + originName + ", changeName=" + changeName + ", filePath="
				+ filePath + ", photoLevel=" + photoLevel + ", boardNum=" + boardNum + ", uploadDate=" + uploadDate
				+ ", status=" + status + "]";
	}
	
	
}
