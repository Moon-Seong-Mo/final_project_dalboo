package com.kh.dalboo.mdProduct.model.vo;

import java.sql.Date;

public class MdOrder {
	private int mdOrderNum;
	private int mdAmount;
	private int totalPrice;
	private String receiver;
	private String address;
	private String phone;
	private String addressRequest;
	private Date orderDate;
	private String payStatus;
	private int mdShipStatus;
	private String mId;
	private int mdNum;
	
	public MdOrder() {}

	public MdOrder(int mdOrderNum, int mdAmount, int totalPrice, String receiver, String address, String phone,
			String addressRequest, Date orderDate, String payStatus, int mdShipStatus, String mId, int mdNum) {
		super();
		this.mdOrderNum = mdOrderNum;
		this.mdAmount = mdAmount;
		this.totalPrice = totalPrice;
		this.receiver = receiver;
		this.address = address;
		this.phone = phone;
		this.addressRequest = addressRequest;
		this.orderDate = orderDate;
		this.payStatus = payStatus;
		this.mdShipStatus = mdShipStatus;
		this.mId = mId;
		this.mdNum = mdNum;
	}

	public int getMdOrderNum() {
		return mdOrderNum;
	}

	public void setMdOrderNum(int mdOrderNum) {
		this.mdOrderNum = mdOrderNum;
	}

	public int getMdAmount() {
		return mdAmount;
	}

	public void setMdAmount(int mdAmount) {
		this.mdAmount = mdAmount;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddressRequest() {
		return addressRequest;
	}

	public void setAddressRequest(String addressRequest) {
		this.addressRequest = addressRequest;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public int getMdShipStatus() {
		return mdShipStatus;
	}

	public void setMdShipStatus(int mdShipStatus) {
		this.mdShipStatus = mdShipStatus;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public int getMdNum() {
		return mdNum;
	}

	public void setMdNum(int mdNum) {
		this.mdNum = mdNum;
	}

	@Override
	public String toString() {
		return "MdOrder [mdOrderNum=" + mdOrderNum + ", mdAmount=" + mdAmount + ", totalPrice=" + totalPrice
				+ ", receiver=" + receiver + ", address=" + address + ", phone=" + phone + ", addressRequest="
				+ addressRequest + ", orderDate=" + orderDate + ", payStatus=" + payStatus + ", mdShipStatus="
				+ mdShipStatus + ", mId=" + mId + ", mdNum=" + mdNum + "]";
	}
	
	
}
