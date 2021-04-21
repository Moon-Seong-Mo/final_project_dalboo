package com.kh.dalboo.menu.model.vo;

public class Menu {
	private int mNum;
	private String mType;
	private String mName;
	private int mPrice;
	private int mCaffeine;
	private int mCalorie;
	private int mSodium;
	private int mSugar;
	private int mCapacity;
	private String mContent;
	private String originalFileName;
	private String renameFileName;
	private String mStatus;
	
	public Menu() {}

	public Menu(int mNum, String mType, String mName, int mPrice, int mCaffeine, int mCalorie, int mSodium, int mSugar,
			int mCapacity, String mContent, String originalFileName, String renameFileName, String mStatus) {
		super();
		this.mNum = mNum;
		this.mType = mType;
		this.mName = mName;
		this.mPrice = mPrice;
		this.mCaffeine = mCaffeine;
		this.mCalorie = mCalorie;
		this.mSodium = mSodium;
		this.mSugar = mSugar;
		this.mCapacity = mCapacity;
		this.mContent = mContent;
		this.originalFileName = originalFileName;
		this.renameFileName = renameFileName;
		this.mStatus = mStatus;
	}

	public int getmNum() {
		return mNum;
	}

	public void setmNum(int mNum) {
		this.mNum = mNum;
	}

	public String getmType() {
		return mType;
	}

	public void setmType(String mType) {
		this.mType = mType;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public int getmPrice() {
		return mPrice;
	}

	public void setmPrice(int mPrice) {
		this.mPrice = mPrice;
	}

	public int getmCaffeine() {
		return mCaffeine;
	}

	public void setmCaffeine(int mCaffeine) {
		this.mCaffeine = mCaffeine;
	}

	public int getmCalorie() {
		return mCalorie;
	}

	public void setmCalorie(int mCalorie) {
		this.mCalorie = mCalorie;
	}

	public int getmSodium() {
		return mSodium;
	}

	public void setmSodium(int mSodium) {
		this.mSodium = mSodium;
	}

	public int getmSugar() {
		return mSugar;
	}

	public void setmSugar(int mSugar) {
		this.mSugar = mSugar;
	}

	public int getmCapacity() {
		return mCapacity;
	}

	public void setmCapacity(int mCapacity) {
		this.mCapacity = mCapacity;
	}

	public String getmContent() {
		return mContent;
	}

	public void setmContent(String mContent) {
		this.mContent = mContent;
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

	public String getmStatus() {
		return mStatus;
	}

	public void setmStatus(String mStatus) {
		this.mStatus = mStatus;
	}

	@Override
	public String toString() {
		return "Menu [mNum=" + mNum + ", mType=" + mType + ", mName=" + mName + ", mPrice=" + mPrice + ", mCaffeine="
				+ mCaffeine + ", mCalorie=" + mCalorie + ", mSodium=" + mSodium + ", mSugar=" + mSugar + ", mCapacity="
				+ mCapacity + ", mContent=" + mContent + ", originalFileName=" + originalFileName + ", renameFileName="
				+ renameFileName + ", mStatus=" + mStatus + "]";
	}


	
	
}
