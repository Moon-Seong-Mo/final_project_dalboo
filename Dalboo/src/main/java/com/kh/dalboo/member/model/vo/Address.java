package com.kh.dalboo.member.model.vo;

public class Address {
	private int adNum;
	private String adName;
	private String adReceiver;
	private String adAddress;
	private String adPhone;
	private String id;
	private int adBaseAddress;
	private String status;
	
	public Address() {}

	public Address(int adNum, String adName, String adReceiver, String adAddress, String adPhone, String id,
			int adBaseAddress, String status) {
		super();
		this.adNum = adNum;
		this.adName = adName;
		this.adReceiver = adReceiver;
		this.adAddress = adAddress;
		this.adPhone = adPhone;
		this.id = id;
		this.adBaseAddress = adBaseAddress;
		this.status = status;
	}

	public int getAdNum() {
		return adNum;
	}

	public void setAdNum(int adNum) {
		this.adNum = adNum;
	}

	public String getAdName() {
		return adName;
	}

	public void setAdName(String adName) {
		this.adName = adName;
	}

	public String getAdReceiver() {
		return adReceiver;
	}

	public void setAdReceiver(String adReceiver) {
		this.adReceiver = adReceiver;
	}

	public String getAdAddress() {
		return adAddress;
	}

	public void setAdAddress(String adAddress) {
		this.adAddress = adAddress;
	}

	public String getAdPhone() {
		return adPhone;
	}

	public void setAdPhone(String adPhone) {
		this.adPhone = adPhone;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getAdBaseAddress() {
		return adBaseAddress;
	}

	public void setAdBaseAddress(int adBaseAddress) {
		this.adBaseAddress = adBaseAddress;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Address [adNum=" + adNum + ", adName=" + adName + ", adReceiver=" + adReceiver + ", adAddress="
				+ adAddress + ", adPhone=" + adPhone + ", id=" + id + ", adBaseAddress=" + adBaseAddress + ", status="
				+ status + "]";
	}

}
