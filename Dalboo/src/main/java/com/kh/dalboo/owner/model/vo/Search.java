package com.kh.dalboo.owner.model.vo;

public class Search {
	
	private String title;
	private String content;
	
	public Search() {
		// TODO Auto-generated constructor stub
	}

	public Search(String title, String content) {
		super();
		this.title = title;
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "Search [title=" + title + ", content=" + content + "]";
	}
	
}
