package com.kh.dalboo.owner.model.vo;

import java.sql.Date;

public class StoreStock {
	private int stock_num;
	private String materialName;
	private int materialAmount;
	private Date uploadDate;
	private int store_num;
	private String status;
	private String material_type;
	private int materialprice;
	private String rename_filename;
	private int allStockNum;
	
	public StoreStock() {}

	public StoreStock(int stock_num, String materialName, int materialAmount, Date uploadDate, int store_num,
			String status, String material_type, int materialprice, String rename_filename, int allStockNum) {
		super();
		this.stock_num = stock_num;
		this.materialName = materialName;
		this.materialAmount = materialAmount;
		this.uploadDate = uploadDate;
		this.store_num = store_num;
		this.status = status;
		this.material_type = material_type;
		this.materialprice = materialprice;
		this.rename_filename = rename_filename;
		this.allStockNum = allStockNum;
	}

	public int getStock_num() {
		return stock_num;
	}

	public void setStock_num(int stock_num) {
		this.stock_num = stock_num;
	}

	public String getMaterialName() {
		return materialName;
	}

	public void setMaterialName(String materialName) {
		this.materialName = materialName;
	}

	public int getMaterialAmount() {
		return materialAmount;
	}

	public void setMaterialAmount(int materialAmount) {
		this.materialAmount = materialAmount;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public int getStore_num() {
		return store_num;
	}

	public void setStore_num(int store_num) {
		this.store_num = store_num;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMaterial_type() {
		return material_type;
	}

	public void setMaterial_type(String material_type) {
		this.material_type = material_type;
	}

	public int getMaterialprice() {
		return materialprice;
	}

	public void setMaterialprice(int materialprice) {
		this.materialprice = materialprice;
	}

	public String getRename_filename() {
		return rename_filename;
	}

	public void setRename_filename(String rename_filename) {
		this.rename_filename = rename_filename;
	}

	public int getAllStockNum() {
		return allStockNum;
	}

	public void setAllStockNum(int allStockNum) {
		this.allStockNum = allStockNum;
	}

	@Override
	public String toString() {
		return "StoreStock [stock_num=" + stock_num + ", materialName=" + materialName + ", materialAmount="
				+ materialAmount + ", uploadDate=" + uploadDate + ", store_num=" + store_num + ", status=" + status
				+ ", material_type=" + material_type + ", materialprice=" + materialprice + ", rename_filename="
				+ rename_filename + ", allStockNum=" + allStockNum + "]";
	}
	
}
