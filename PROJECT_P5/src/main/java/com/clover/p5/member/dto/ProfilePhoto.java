package com.clover.p5.member.dto;

public class ProfilePhoto {
	
	private int id;
	private int memberId;
	private String originalName;
	private int fileSize;
	private String path;
	private char isProfile;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public char getIsProfile() {
		return isProfile;
	}
	public void setIsProfile(char isProfile) {
		this.isProfile = isProfile;
	}
	@Override
	public String toString() {
		return "ProfilePhoto [id=" + id + ", memberId=" + memberId + ", originalName=" + originalName + ", fileSize="
				+ fileSize + ", path=" + path + ", isProfile=" + isProfile + "]";
	}
	
	
	
	

}
