package com.kh.dalboo.etc.model.vo;

import java.sql.Date;

public class Store {
	private int store_num;
	private String store_region;
	private String store_name;
	private String store_address;
	private String store_phone;
	private Date store_create_date;
	private Date store_modify_date;
	private String store_login_code;
	private String store_status;
	private int rank_code;
	private int totalprice;
	 public Store() {
	}

	public Store(int store_num, String store_region, String store_name, String store_address, String store_phone,
			Date store_create_date, Date store_modify_date, String store_login_code, String store_status, int rank_code,
			int totalprice) {
		super();
		this.store_num = store_num;
		this.store_region = store_region;
		this.store_name = store_name;
		this.store_address = store_address;
		this.store_phone = store_phone;
		this.store_create_date = store_create_date;
		this.store_modify_date = store_modify_date;
		this.store_login_code = store_login_code;
		this.store_status = store_status;
		this.rank_code = rank_code;
		this.totalprice = totalprice;
	}


	public int getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}

	public int getStore_num() {
		return store_num;
	}

	public void setStore_num(int store_num) {
		this.store_num = store_num;
	}

	public String getStore_region() {
		return store_region;
	}

	public void setStore_region(String store_region) {
		this.store_region = store_region;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public String getStore_address() {
		return store_address;
	}

	public void setStore_address(String store_address) {
		this.store_address = store_address;
	}

	public String getStore_phone() {
		return store_phone;
	}

	public void setStore_phone(String store_phone) {
		this.store_phone = store_phone;
	}

	public Date getStore_create_date() {
		return store_create_date;
	}

	public void setStore_create_date(Date store_create_date) {
		this.store_create_date = store_create_date;
	}

	public Date getStore_modify_date() {
		return store_modify_date;
	}

	public void setStore_modify_date(Date store_modify_date) {
		this.store_modify_date = store_modify_date;
	}

	public String getStore_login_code() {
		return store_login_code;
	}

	public void setStore_login_code(String store_login_code) {
		this.store_login_code = store_login_code;
	}

	public String getStore_status() {
		return store_status;
	}

	public void setStore_status(String store_status) {
		this.store_status = store_status;
	}

	public int getRank_code() {
		return rank_code;
	}

	public void setRank_code(int rank_code) {
		this.rank_code = rank_code;
	}

	@Override
	public String toString() {
		return "Store [store_num=" + store_num + ", store_region=" + store_region + ", store_name=" + store_name
				+ ", store_address=" + store_address + ", store_phone=" + store_phone + ", store_create_date="
				+ store_create_date + ", store_modify_date=" + store_modify_date + ", store_login_code="
				+ store_login_code + ", store_status=" + store_status + ", rank_code=" + rank_code + ", totalprice="
				+ totalprice + "]";
	}
	
}
