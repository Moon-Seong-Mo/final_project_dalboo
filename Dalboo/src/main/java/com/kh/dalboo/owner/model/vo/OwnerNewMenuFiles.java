package com.kh.dalboo.owner.model.vo;

public class OwnerNewMenuFiles {
	private int owFileNum;
	private String originalName;
	private String changeName;
	private String filePath;
	private String contentText; //이미지와 같이 들어갈 메뉴 설명
	private String status; 
	private int boardLevel; 
	private int onmNum; //가맹주 신메뉴 보드넘버
	public OwnerNewMenuFiles() {}
	public OwnerNewMenuFiles(int owFileNum, String originalName, String changeName, String filePath, String contentText,
			String status, int boardLevel, int onmNum) {
		super();
		this.owFileNum = owFileNum;
		this.originalName = originalName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.contentText = contentText;
		this.status = status;
		this.boardLevel = boardLevel;
		this.onmNum = onmNum;
	}
	public int getOwFileNum() {
		return owFileNum;
	}
	public void setOwFileNum(int owFileNum) {
		this.owFileNum = owFileNum;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
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
	public String getContentText() {
		return contentText;
	}
	public void setContentText(String contentText) {
		this.contentText = contentText;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getBoardLevel() {
		return boardLevel;
	}
	public void setBoardLevel(int boardLevel) {
		this.boardLevel = boardLevel;
	}
	public int getOnmNum() {
		return onmNum;
	}
	public void setOnmNum(int onmNum) {
		this.onmNum = onmNum;
	}
	@Override
	public String toString() {
		return "OwnerNewMenuFiles [owFileNum=" + owFileNum + ", originalName=" + originalName + ", changeName="
				+ changeName + ", filePath=" + filePath + ", contentText=" + contentText + ", status=" + status
				+ ", boardLevel=" + boardLevel + ", onmNum=" + onmNum + "]";
	}
	
	
}
