package com.kh.dalboo.member.model.vo;

import java.sql.Date;

public class PointHistory {
	
	private int phNum;
	private String mId;
	private String event;
	private int conditions;		//0:추가 / 1:사용
	private int originPoint;	//기존 포인트
	private int changePoint;	//변화한 포인트 (=사용내역)
	private int afterPoint;		//이후 포인트
	private Date eventDate;
	
	public PointHistory() {
		// TODO Auto-generated constructor stub
	}

	public PointHistory(int phNum, String mId, String event, int conditions, int originPoint, int changePoint,
			int afterPoint, Date eventDate) {
		super();
		this.phNum = phNum;
		this.mId = mId;
		this.event = event;
		this.conditions = conditions;
		this.originPoint = originPoint;
		this.changePoint = changePoint;
		this.afterPoint = afterPoint;
		this.eventDate = eventDate;
	}

	public int getPhNum() {
		return phNum;
	}

	public void setPhNum(int phNum) {
		this.phNum = phNum;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getEvent() {
		return event;
	}

	public void setEvent(String event) {
		this.event = event;
	}

	public int getConditions() {
		return conditions;
	}

	public void setConditions(int conditions) {
		this.conditions = conditions;
	}

	public int getOriginPoint() {
		return originPoint;
	}

	public void setOriginPoint(int originPoint) {
		this.originPoint = originPoint;
	}

	public int getChangePoint() {
		return changePoint;
	}

	public void setChangePoint(int changePoint) {
		this.changePoint = changePoint;
	}

	public int getAfterPoint() {
		return afterPoint;
	}

	public void setAfterPoint(int afterPoint) {
		this.afterPoint = afterPoint;
	}

	public Date getEventDate() {
		return eventDate;
	}

	public void setEventDate(Date eventDate) {
		this.eventDate = eventDate;
	}

	@Override
	public String toString() {
		return "PointHistory [phNum=" + phNum + ", mId=" + mId + ", event=" + event + ", conditions=" + conditions
				+ ", originPoint=" + originPoint + ", changePoint=" + changePoint + ", afterPoint=" + afterPoint
				+ ", eventDate=" + eventDate + "]";
	}

	
}
