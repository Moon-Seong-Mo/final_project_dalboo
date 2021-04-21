package com.kh.dalboo.etc.model.vo;

public class Faq {

	private int faq_num;
	private String faq_title;
	private String faq_content;
	private String status;
	
	public Faq() {}
	
	public Faq(int faq_num, String faq_title, String faq_content, String status) {
		super();
		this.faq_num = faq_num;
		this.faq_title = faq_title;
		this.faq_content = faq_content;
		this.status = status;
	}

	public int getFaq_num() {
		return faq_num;
	}

	public void setFaq_num(int faq_num) {
		this.faq_num = faq_num;
	}

	public String getFaq_title() {
		return faq_title;
	}

	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}

	public String getFaq_content() {
		return faq_content;
	}

	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Faq [faq_num=" + faq_num + ", faq_title=" + faq_title + ", faq_content=" + faq_content + ", status="
				+ status + "]";
	}
	
}
