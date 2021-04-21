package com.kh.dalboo.owner.model.vo;

import java.sql.Date;

public class OwnerNotice {
	
	private int onNo;
	private String owTitle;
	private String owContent;
	private String originFileName;
	private String renameFileName;
	private Date owDate;
	private int onCount;
	private String owStatus;
	
	public OwnerNotice() {
		// TODO Auto-generated constructor stub
	}

	public OwnerNotice(int onNo, String owTitle, String owContent, String originFileName, String renameFileName,
			Date owDate, int onCount, String owStatus) {
		super();
		this.onNo = onNo;
		this.owTitle = owTitle;
		this.owContent = owContent;
		this.originFileName = originFileName;
		this.renameFileName = renameFileName;
		this.owDate = owDate;
		this.onCount = onCount;
		this.owStatus = owStatus;
	}

	public int getOnNo() {
		return onNo;
	}

	public void setOnNo(int onNo) {
		this.onNo = onNo;
	}

	public String getOwTitle() {
		return owTitle;
	}

	public void setOwTitle(String owTitle) {
		this.owTitle = owTitle;
	}

	public String getOwContent() {
		return owContent;
	}

	public void setOwContent(String owContent) {
		this.owContent = owContent;
	}

	public String getOriginFileName() {
		return originFileName;
	}

	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}

	public String getRenameFileName() {
		return renameFileName;
	}

	public void setRenameFileName(String renameFileName) {
		this.renameFileName = renameFileName;
	}

	public Date getOwDate() {
		return owDate;
	}

	public void setOwDate(Date owDate) {
		this.owDate = owDate;
	}

	public int getOnCount() {
		return onCount;
	}

	public void setOnCount(int onCount) {
		this.onCount = onCount;
	}

	public String getOwStatus() {
		return owStatus;
	}

	public void setOwStatus(String owStatus) {
		this.owStatus = owStatus;
	}

	@Override
	public String toString() {
		return "OwnerNotice [onNo=" + onNo + ", owTitle=" + owTitle + ", owContent=" + owContent + ", originFileName="
				+ originFileName + ", renameFileName=" + renameFileName + ", owDate=" + owDate + ", onCount=" + onCount
				+ ", owStatus=" + owStatus + "]";
	}
	
}
