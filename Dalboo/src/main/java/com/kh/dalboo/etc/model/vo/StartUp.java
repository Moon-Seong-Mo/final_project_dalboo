package com.kh.dalboo.etc.model.vo;

import java.sql.Date;

public class StartUp {
	private int sNum;
	private String sTitle;
	private String sName;
	private String sPhone;
	private String sEmail;
	private String storeName;
	private String sAddress;
	private String sContent;
	private Date startDate;
	private String sConfirm;
	private String sStatus;
	
	public StartUp() {}

	public StartUp(int sNum, String sTitle, String sName, String sPhone, String sEmail, String storeName,
			String sAddress, String sContent, Date startDate, String sConfirm, String sStatus) {
		super();
		this.sNum = sNum;
		this.sTitle = sTitle;
		this.sName = sName;
		this.sPhone = sPhone;
		this.sEmail = sEmail;
		this.storeName = storeName;
		this.sAddress = sAddress;
		this.sContent = sContent;
		this.startDate = startDate;
		this.sConfirm = sConfirm;
		this.sStatus = sStatus;
	}

	public int getsNum() {
		return sNum;
	}

	public void setsNum(int sNum) {
		this.sNum = sNum;
	}

	public String getsTitle() {
		return sTitle;
	}

	public void setsTitle(String sTitle) {
		this.sTitle = sTitle;
	}

	public String getsName() {
		return sName;
	}

	public void setsName(String sName) {
		this.sName = sName;
	}

	public String getsPhone() {
		return sPhone;
	}

	public void setsPhone(String sPhone) {
		this.sPhone = sPhone;
	}

	public String getsEmail() {
		return sEmail;
	}

	public void setsEmail(String sEmail) {
		this.sEmail = sEmail;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getsAddress() {
		return sAddress;
	}

	public void setsAddress(String sAddress) {
		this.sAddress = sAddress;
	}

	public String getsContent() {
		return sContent;
	}

	public void setsContent(String sContent) {
		this.sContent = sContent;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public String getsConfirm() {
		return sConfirm;
	}

	public void setsConfirm(String sConfirm) {
		this.sConfirm = sConfirm;
	}

	public String getsStatus() {
		return sStatus;
	}

	public void setsStatus(String sStatus) {
		this.sStatus = sStatus;
	}

	@Override
	public String toString() {
		return "StartUp [sNum=" + sNum + ", sTitle=" + sTitle + ", sName=" + sName + ", sPhone=" + sPhone + ", sEmail="
				+ sEmail + ", storeName=" + storeName + ", sAddress=" + sAddress + ", sContent=" + sContent
				+ ", startDate=" + startDate + ", sConfirm=" + sConfirm + ", sStatus=" + sStatus + "]";
	}

	

	
	
}
