package com.kh.dalboo.board.model.vo;

public class NewMenuFiles {
	private int fileNum;
	private String originalName;
	private String changName;
	private String filePath;
	private String menuName;
	private String contentText; //이미지와 같이 들어갈 메뉴 설명
	private String status; 
	private int boardLevel; //가맹주, 일반 투표 구분
	private int nNum; //신메뉴 보드넘버
	public NewMenuFiles() {}
		

	public NewMenuFiles(int fileNum, String originalName, String changName, String filePath, String menuName,
			String contentText, String status, int boardLevel, int nNum) {
		super();
		this.fileNum = fileNum;
		this.originalName = originalName;
		this.changName = changName;
		this.filePath = filePath;
		this.menuName = menuName;
		this.contentText = contentText;
		this.status = status;
		this.boardLevel = boardLevel;
		this.nNum = nNum;
	}


	public int getFileNum() {
		return fileNum;
	}


	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}


	public String getOriginalName() {
		return originalName;
	}


	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}


	public String getChangName() {
		return changName;
	}


	public void setChangName(String changName) {
		this.changName = changName;
	}


	public String getFilePath() {
		return filePath;
	}


	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}


	public String getMenuName() {
		return menuName;
	}


	public void setMenuName(String menuName) {
		this.menuName = menuName;
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


	public int getnNum() {
		return nNum;
	}


	public void setnNum(int nNum) {
		this.nNum = nNum;
	}


	@Override
	public String toString() {
		return "NewMenuFiles [fileNum=" + fileNum + ", originalName=" + originalName + ", changName=" + changName
				+ ", filePath=" + filePath + ", contentText=" + contentText + ", status=" + status + ", boardLevel="
				+ boardLevel + ", nNum=" + nNum + "]";
	}

	
}
