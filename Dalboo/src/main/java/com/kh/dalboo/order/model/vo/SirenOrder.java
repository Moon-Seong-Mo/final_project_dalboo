package com.kh.dalboo.order.model.vo;

import java.sql.Date;
import java.util.List;

public class SirenOrder {
	private int so_num;
	private int so_total_price;
	private Date so_date;
	private String so_time;
	private String so_status2;
	private String so_status;
	private int store_num;
	private String store_name;
	private String store_status;
	private String m_id;
	private int stock_num;
	private String materialname;
	private List<String> stockNames;
	
	public SirenOrder() {}
	
	public SirenOrder(int so_num, int so_total_price, Date so_date, String so_time, String so_status2, String so_status,
			int store_num, String store_name, String store_status, String m_id, int stock_num, String materialname,
			List<String> stockNames) {
		super();
		this.so_num = so_num;
		this.so_total_price = so_total_price;
		this.so_date = so_date;
		this.so_time = so_time;
		this.so_status2 = so_status2;
		this.so_status = so_status;
		this.store_num = store_num;
		this.store_name = store_name;
		this.store_status = store_status;
		this.m_id = m_id;
		this.stock_num = stock_num;
		this.materialname = materialname;
		this.stockNames = stockNames;
	}

	public List<String> getStockNames() {
		return stockNames;
	}

	public void setStockNames(List<String> stockNames) {
		this.stockNames = stockNames;
	}

	public int getSo_num() {
		return so_num;
	}

	public void setSo_num(int so_num) {
		this.so_num = so_num;
	}

	public int getSo_total_price() {
		return so_total_price;
	}

	public void setSo_total_price(int so_total_price) {
		this.so_total_price = so_total_price;
	}

	public Date getSo_date() {
		return so_date;
	}

	public void setSo_date(Date so_date) {
		this.so_date = so_date;
	}

	public String getSo_time() {
		return so_time;
	}

	public void setSo_time(String so_time) {
		this.so_time = so_time;
	}

	public String getSo_status2() {
		return so_status2;
	}

	public void setSo_status2(String so_status2) {
		this.so_status2 = so_status2;
	}

	public String getSo_status() {
		return so_status;
	}

	public void setSo_status(String so_status) {
		this.so_status = so_status;
	}

	public int getStore_num() {
		return store_num;
	}

	public void setStore_num(int store_num) {
		this.store_num = store_num;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	
	public String getMaterialname() {
		return materialname;
	}

	public void setMaterialname(String materialname) {
		this.materialname = materialname;
	}
	
	public int getStock_num() {
		return stock_num;
	}

	public void setStock_num(int stock_num) {
		this.stock_num = stock_num;
	}
	
	public String getStore_status() {
		return store_status;
	}

	public void setStore_status(String store_status) {
		this.store_status = store_status;
	}

	@Override
	public String toString() {
		return "SirenOrder [so_num=" + so_num + ", so_total_price=" + so_total_price + ", so_date=" + so_date
				+ ", so_time=" + so_time + ", so_status2=" + so_status2 + ", so_status=" + so_status + ", store_num="
				+ store_num + ", store_name=" + store_name + ", store_status=" + store_status + ", m_id=" + m_id
				+ ", stock_num=" + stock_num + ", materialname=" + materialname + ", stockNames=" + stockNames + "]";
	}
	
}
