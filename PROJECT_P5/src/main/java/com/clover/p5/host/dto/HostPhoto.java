package com.clover.p5.host.dto;

public class HostPhoto {
	
	private int id;
	private int hostId;
	private String originalName;
	private long fileSize;
	private String path;
	private int sortOrder;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getHostId() {
		return hostId;
	}
	public void setHostId(int hostId) {
		this.hostId = hostId;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public int getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}
	@Override
	public String toString() {
		return "HostPhoto [id=" + id + ", hostId=" + hostId + ", originalName=" + originalName + ", fileSize="
				+ fileSize + ", path=" + path + ", sortOrder=" + sortOrder + "]";
	}
	
	
	
	
	
	
}
