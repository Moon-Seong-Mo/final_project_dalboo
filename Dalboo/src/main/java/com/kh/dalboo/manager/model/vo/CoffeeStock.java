package com.kh.dalboo.manager.model.vo;

import java.sql.Date;

public class CoffeeStock {
	private int allStockNum;
	private String materialType;
	private String materialName;
	private int materialAmount;
	private int materialPrice;
	private String originalFileName;
	private String renameFileName;
	private Date modifyDate;
	
	public CoffeeStock() {}

	public CoffeeStock(int allStockNum, String materialType, String materialName, int materialAmount, int materialPrice,
			String originalFileName, String renameFileName, Date modifyDate) {
		super();
		this.allStockNum = allStockNum;
		this.materialType = materialType;
		this.materialName = materialName;
		this.materialAmount = materialAmount;
		this.materialPrice = materialPrice;
		this.originalFileName = originalFileName;
		this.renameFileName = renameFileName;
		this.modifyDate = modifyDate;
	}

	public int getAllStockNum() {
		return allStockNum;
	}

	public void setAllStockNum(int allStockNum) {
		this.allStockNum = allStockNum;
	}

	public String getMaterialType() {
		return materialType;
	}

	public void setMaterialType(String materialType) {
		this.materialType = materialType;
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

	public int getMaterialPrice() {
		return materialPrice;
	}

	public void setMaterialPrice(int materialPrice) {
		this.materialPrice = materialPrice;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getRenameFileName() {
		return renameFileName;
	}

	public void setRenameFileName(String renameFileName) {
		this.renameFileName = renameFileName;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	@Override
	public String toString() {
		return "CoffeeStock [allStockNum=" + allStockNum + ", materialType=" + materialType + ", materialName="
				+ materialName + ", materialAmount=" + materialAmount + ", materialPrice=" + materialPrice
				+ ", originalFileName=" + originalFileName + ", renameFileName=" + renameFileName + ", modifyDate="
				+ modifyDate + "]";
	}

	
	
	
	
}
