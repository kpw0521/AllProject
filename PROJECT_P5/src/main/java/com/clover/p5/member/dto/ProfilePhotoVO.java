package com.clover.p5.member.dto;

public class ProfilePhotoVO {
	
	private int memberId;
	private String originalName;
	private long fileSize;
	private String path;
	
	
	public ProfilePhotoVO(int memberId, String originalName, long fileSize, String path) {
		this.memberId = memberId;
		this.originalName = originalName;
		this.fileSize = fileSize;
		this.path = path;
	}


	@Override
	public String toString() {
		return "ProfilePhotoVO [memberId=" + memberId + ", originalName=" + originalName + ", fileSize=" + fileSize
				+ ", path=" + path + "]";
	}

	
}
