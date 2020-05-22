package com.clover.p5.host.dto;

public class HostPhotoVO {

	private int hostId;
	private String originalName;
	private long fileSize;
	private String path;
	private int sortOrder;
	
	
	public HostPhotoVO(int hostId, String originalName, long fileSize, String path, int sortOrder) {
		this.hostId = hostId;
		this.originalName = originalName;
		this.fileSize = fileSize;
		this.path = path;
		this.sortOrder = sortOrder;
	}


	@Override
	public String toString() {
		return "HostPhotoVO [hostId=" + hostId + ", originalName=" + originalName + ", fileSize=" + fileSize + ", path="
				+ path + ", sortOrder=" + sortOrder + "]";
	}
	
	
	
	
}
