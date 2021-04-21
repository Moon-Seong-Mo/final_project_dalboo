package com.kh.dalboo.board.model.vo;

import java.sql.Date;

public class NewMenuBoard {
	private int nNum;
	private String title;
	private String subTitle;
	private int views;
	private String voteStatus;
	private Date createDate;
	private Date modifyDate;
	private String votEndDate;
	private String nStatus;
	private String mId;
	
	public NewMenuBoard() {}

	public NewMenuBoard(int nNum, String title, String subTitle, int views, String voteStatus, Date createDate,
			Date modifyDate, String votEndDate, String nStatus, String mId) {
		super();
		this.nNum = nNum;
		this.title = title;
		this.subTitle = subTitle;
		this.views = views;
		this.voteStatus = voteStatus;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.votEndDate = votEndDate;
		this.nStatus = nStatus;
		this.mId = mId;
	}

	public int getnNum() {
		return nNum;
	}

	public void setnNum(int nNum) {
		this.nNum = nNum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubTitle() {
		return subTitle;
	}

	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public String getVoteStatus() {
		return voteStatus;
	}

	public void setVoteStatus(String voteStatus) {
		this.voteStatus = voteStatus;
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

	public String getVotEndDate() {
		return votEndDate;
	}

	public void setVotEndDate(String votEndDate) {
		this.votEndDate = votEndDate;
	}

	public String getnStatus() {
		return nStatus;
	}

	public void setnStatus(String nStatus) {
		this.nStatus = nStatus;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	@Override
	public String toString() {
		return "NewMenuBoard [nNum=" + nNum + ", title=" + title + ", subTitle=" + subTitle + ", views=" + views
				+ ", voteStatus=" + voteStatus + ", createDate=" + createDate + ", modifyDate=" + modifyDate
				+ ", votEndDate=" + votEndDate + ", nStatus=" + nStatus + ", mId=" + mId + "]";
	}
	
}
