package com.kh.dalboo.member.model.vo;

import java.sql.Date;

public class Member {
	private String id;
	private String pwd;
	private String nickName;
	private String name;
	private String phone;
	private String email;
	private int point;
	private int rank_code;
	private Date enrollDate;
	private Date modifyDate;
	private String mStatus;

	public Member() {}

	public Member(String id, String pwd, String nickName, String name, String phone, String email, int point,
			int rank_code, Date enrollDate, Date modifyDate, String mStatus) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.nickName = nickName;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.point = point;
		this.rank_code = rank_code;
		this.enrollDate = enrollDate;
		this.modifyDate = modifyDate;
		this.mStatus = mStatus;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getRank_code() {
		return rank_code;
	}

	public void setRank_code(int rank_code) {
		this.rank_code = rank_code;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getmStatus() {
		return mStatus;
	}

	public void setmStatus(String mStatus) {
		this.mStatus = mStatus;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", pwd=" + pwd + ", nickName=" + nickName + ", name=" + name + ", phone=" + phone
				+ ", email=" + email + ", point=" + point + ", rank_code=" + rank_code + ", enrollDate=" + enrollDate
				+ ", modifyDate=" + modifyDate + ", mStatus=" + mStatus + "]";
	}
}
