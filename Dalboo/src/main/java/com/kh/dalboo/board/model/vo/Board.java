package com.kh.dalboo.board.model.vo;

import java.sql.Date;

public class Board {
	private int bNum;
	private String bType;
	private String bWriter;
	private String bTitle;
	private String bContent;
	private String originalFileName;
	private String renameFileName;
	private int bViews;
	private Date bCreateDate;
	private Date bModifyDate;
	private String bStatus;
	
	public Board() {}

	public int getbNum() {
		return bNum;
	}

	public void setbNum(int bNum) {
		this.bNum = bNum;
	}

	public String getbType() {
		return bType;
	}

	public void setbType(String bType) {
		this.bType = bType;
	}

	public String getbWriter() {
		return bWriter;
	}

	public void setbWriter(String bWriter) {
		this.bWriter = bWriter;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getRenameFileName() {
		return renameFileName;
	}

	public void setRenameFileName(String renameFileName) {
		this.renameFileName = renameFileName;
	}

	public int getbViews() {
		return bViews;
	}

	public void setbViews(int bViews) {
		this.bViews = bViews;
	}

	public Date getbCreateDate() {
		return bCreateDate;
	}

	public void setbCreateDate(Date bCreateDate) {
		this.bCreateDate = bCreateDate;
	}

	public Date getbModifyDate() {
		return bModifyDate;
	}

	public void setbModifyDate(Date bModifyDate) {
		this.bModifyDate = bModifyDate;
	}

	public String getbStatus() {
		return bStatus;
	}

	public void setbStatus(String bStatus) {
		this.bStatus = bStatus;
	}

	@Override
	public String toString() {
		return "Board [bNum=" + bNum + ", bType=" + bType + ", bWriter=" + bWriter + ", bTitle=" + bTitle
				+ ", bContent=" + bContent + ", originalFileName=" + originalFileName + ", renameFileName="
				+ renameFileName + ", bViews=" + bViews + ", bCreateDate=" + bCreateDate + ", bModifyDate="
				+ bModifyDate + ", bStatus=" + bStatus + "]";
	}

	
	
	
	
}
