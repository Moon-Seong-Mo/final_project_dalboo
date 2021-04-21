package com.kh.dalboo.owner.model.vo;

import java.sql.Date;

public class OwnerNewMenuBoard {
	private int onmNum;
	private String onmTitle;
	private int onmViews;
	private Date createDate;
	private Date modifyDate;
	private String onmStatus;
	private String storeName;
	public OwnerNewMenuBoard() {}
	public OwnerNewMenuBoard(int onmNum, String onmTitle, int onmViews, Date createDate, Date modifyDate,
			String onmStatus, String storeName) {
		super();
		this.onmNum = onmNum;
		this.onmTitle = onmTitle;
		this.onmViews = onmViews;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.onmStatus = onmStatus;
		this.storeName = storeName;
	}
	public int getOnmNum() {
		return onmNum;
	}
	public void setOnmNum(int onmNum) {
		this.onmNum = onmNum;
	}
	public String getOnmTitle() {
		return onmTitle;
	}
	public void setOnmTitle(String onmTitle) {
		this.onmTitle = onmTitle;
	}
	public int getOnmViews() {
		return onmViews;
	}
	public void setOnmViews(int onmViews) {
		this.onmViews = onmViews;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getOnmStatus() {
		return onmStatus;
	}
	public void setOnmStatus(String onmStatus) {
		this.onmStatus = onmStatus;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	@Override
	public String toString() {
		return "OwnerNewMenuBoard [onmNum=" + onmNum + ", onmTitle=" + onmTitle + ", onmViews=" + onmViews
				+ ", createDate=" + createDate + ", modifyDate=" + modifyDate + ", onmStatus=" + onmStatus
				+ ", storeName=" + storeName + "]";
	}
	
	
}
