package com.kh.dalboo.mdProduct.model.vo;

import java.sql.Date;

public class Cart {

	private int cartNum;
	private int mdNum;
	private String mdName;
	private int mdPrice;
	private int cartAmount;
	private String mId;
	private Date cartDate;
	
	public Cart() {}
	
	

	public Cart(int mdNum, int cartAmount) {
		super();
		this.mdNum = mdNum;
		this.cartAmount = cartAmount;
	}



	public Cart(int cartNum, int mdNum, String mdName, int mdPrice, int cartAmount, String mId, Date cartDate) {
		super();
		this.cartNum = cartNum;
		this.mdNum = mdNum;
		this.mdName = mdName;
		this.mdPrice = mdPrice;
		this.cartAmount = cartAmount;
		this.mId = mId;
		this.cartDate = cartDate;
	}

	public int getCartNum() {
		return cartNum;
	}

	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}

	public int getMdNum() {
		return mdNum;
	}

	public void setMdNum(int mdNum) {
		this.mdNum = mdNum;
	}

	public String getMdName() {
		return mdName;
	}

	public void setMdName(String mdName) {
		this.mdName = mdName;
	}

	public int getMdPrice() {
		return mdPrice;
	}

	public void setMdPrice(int mdPrice) {
		this.mdPrice = mdPrice;
	}

	public int getCartAmount() {
		return cartAmount;
	}

	public void setCartAmount(int cartAmount) {
		this.cartAmount = cartAmount;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public Date getCartDate() {
		return cartDate;
	}

	public void setCartDate(Date cartDate) {
		this.cartDate = cartDate;
	}

	@Override
	public String toString() {
		return "Cart [cartNum=" + cartNum + ", mdNum=" + mdNum + ", mdName=" + mdName + ", mdPrice=" + mdPrice
				+ ", cartAmount=" + cartAmount + ", mId=" + mId + ", cartDate=" + cartDate + "]";
	}
	
	
}
