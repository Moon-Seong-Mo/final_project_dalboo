package com.kh.dalboo.order.model.vo;

import java.sql.Date;

public class SirenOrderCart {

	private int so_cartNum;
	private String materialname;
	private int materialprice;
	private int so_cartAmount;
	private Date so_cartDate;
	private int stock_num;
	private String m_id;
	private String store_name;
	private int store_num;
	private int allStockNum;
	private int materialamount;
	public SirenOrderCart() {}
	
	public SirenOrderCart(int so_cartNum, String materialname, int materialprice, int so_cartAmount, Date so_cartDate,
			int stock_num, String m_id, String store_name, int store_num, int allStockNum, int materialamount) {
		super();
		this.so_cartNum = so_cartNum;
		this.materialname = materialname;
		this.materialprice = materialprice;
		this.so_cartAmount = so_cartAmount;
		this.so_cartDate = so_cartDate;
		this.stock_num = stock_num;
		this.m_id = m_id;
		this.store_name = store_name;
		this.store_num = store_num;
		this.allStockNum = allStockNum;
		this.materialamount = materialamount;
	}

	public SirenOrderCart(String m_id, int store_num) {
		super();
		this.m_id = m_id;
		this.store_num = store_num;
	}

	public SirenOrderCart(int stock_num, String m_id, String store_name) {
		super();
		this.stock_num = stock_num;
		this.m_id = m_id;
		this.store_name = store_name;
	}

	public int getMaterialamount() {
		return materialamount;
	}

	public void setMaterialamount(int materialamount) {
		this.materialamount = materialamount;
	}

	public int getSo_cartNum() {
		return so_cartNum;
	}

	public void setSo_cartNum(int so_cartNum) {
		this.so_cartNum = so_cartNum;
	}

	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}

	public int getMaterialprice() {
		return materialprice;
	}

	public void setMaterialprice(int materialprice) {
		this.materialprice = materialprice;
	}

	public int getSo_cartAmount() {
		return so_cartAmount;
	}

	public void setSo_cartAmount(int so_cartAmount) {
		this.so_cartAmount = so_cartAmount;
	}

	public Date getSo_cartDate() {
		return so_cartDate;
	}

	public void setSo_cartDate(Date so_cartDate) {
		this.so_cartDate = so_cartDate;
	}

	public int getStock_num() {
		return stock_num;
	}

	public void setStock_num(int stock_num) {
		this.stock_num = stock_num;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public int getStore_num() {
		return store_num;
	}

	public void setStore_num(int store_num) {
		this.store_num = store_num;
	}

	public int getAllStockNum() {
		return allStockNum;
	}

	public void setAllStockNum(int allStockNum) {
		this.allStockNum = allStockNum;
	}

	@Override
	public String toString() {
		return "SirenOrderCart [so_cartNum=" + so_cartNum + ", materialname=" + materialname + ", materialprice="
				+ materialprice + ", so_cartAmount=" + so_cartAmount + ", so_cartDate=" + so_cartDate + ", stock_num="
				+ stock_num + ", m_id=" + m_id + ", store_name=" + store_name + ", store_num=" + store_num
				+ ", allStockNum=" + allStockNum + ", materialamount=" + materialamount + "]";
	}
	
}
