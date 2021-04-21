package com.kh.dalboo.mdProduct.model.vo;

import java.sql.Date;

public class MdProduct {
	
	private int mdNum;
	private String mdCategory;
	private String mdName;
	private int mdPrice;
	private String mdMaterial;
	private int mdCapacity;
	private int mdStock;
	private Date updateDate;
	private Date modifyDate;
	private String mdStatus;
	
	public MdProduct() {
		// TODO Auto-generated constructor stub
	}

	
	
	public MdProduct(int mdNum, String mdCategory, String mdName, int mdPrice, String mdMaterial, int mdCapacity,
			int mdStock, Date updateDate, Date modifyDate, String mdStatus) {
		super();
		this.mdNum = mdNum;
		this.mdCategory = mdCategory;
		this.mdName = mdName;
		this.mdPrice = mdPrice;
		this.mdMaterial = mdMaterial;
		this.mdCapacity = mdCapacity;
		this.mdStock = mdStock;
		this.updateDate = updateDate;
		this.modifyDate = modifyDate;
		this.mdStatus = mdStatus;
	}

	public int getMdNum() {
		return mdNum;
	}

	public void setMdNum(int mdNum) {
		this.mdNum = mdNum;
	}

	public String getMdCategory() {
		return mdCategory;
	}

	public void setMdCategory(String mdCategory) {
		this.mdCategory = mdCategory;
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

	public String getMdMaterial() {
		return mdMaterial;
	}

	public void setMdMaterial(String mdMaterial) {
		this.mdMaterial = mdMaterial;
	}

	public int getMdCapacity() {
		return mdCapacity;
	}

	public void setMdCapacity(int mdCapacity) {
		this.mdCapacity = mdCapacity;
	}

	public int getMdStock() {
		return mdStock;
	}

	public void setMdStock(int mdStock) {
		this.mdStock = mdStock;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getMdStatus() {
		return mdStatus;
	}

	public void setMdStatus(String mdStatus) {
		this.mdStatus = mdStatus;
	}

	@Override
	public String toString() {
		return "MdProduct [mdNum=" + mdNum + ", mdCategory=" + mdCategory + ", mdName=" + mdName + ", mdPrice="
				+ mdPrice + ", mdMaterial=" + mdMaterial + ", mdCapacity=" + mdCapacity + ", mdStock=" + mdStock
				+ ", updateDate=" + updateDate + ", modifyDate=" + modifyDate + ", mdStatus=" + mdStatus + "]";
	}
	
	
	
}
