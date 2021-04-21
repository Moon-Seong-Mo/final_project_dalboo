package com.kh.dalboo.board.model.vo;

import java.sql.Date;

public class Vote {
	private int vNum;
	private int vCount;
	private Date voteDate;
	private String vStatus;
	private int fileNum;
	private int nNum;
	private String mId;
	
	public Vote() {}

	public Vote(int vNum, int vCount, Date voteDate, String vStatus, int fileNum, int nNum, String mId) {
		super();
		this.vNum = vNum;
		this.vCount = vCount;
		this.voteDate = voteDate;
		this.vStatus = vStatus;
		this.fileNum = fileNum;
		this.nNum = nNum;
		this.mId = mId;
	}

	public int getvNum() {
		return vNum;
	}

	public void setvNum(int vNum) {
		this.vNum = vNum;
	}

	public int getvCount() {
		return vCount;
	}

	public void setvCount(int vCount) {
		this.vCount = vCount;
	}

	public Date getVoteDate() {
		return voteDate;
	}

	public void setVoteDate(Date voteDate) {
		this.voteDate = voteDate;
	}

	public String getvStatus() {
		return vStatus;
	}

	public void setvStatus(String vStatus) {
		this.vStatus = vStatus;
	}

	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}

	public int getnNum() {
		return nNum;
	}

	public void setnNum(int nNum) {
		this.nNum = nNum;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	@Override
	public String toString() {
		return "Vote [vNum=" + vNum + ", vCount=" + vCount + ", voteDate=" + voteDate + ", vStatus=" + vStatus
				+ ", fileNum=" + fileNum + ", nNum=" + nNum + ", mId=" + mId + "]";
	}

	
}
