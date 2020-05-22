package com.clover.p5.guest.dto;

public class HostPhotoDTO {

	/*
	ID	NUMBER
	HOST_ID	NUMBER
	ORIGINAL_NAME	VARCHAR2(260 BYTE)
	FILE_SIZE	NUMBER
	PATH	VARCHAR2(100 BYTE)
	*/
	private int id;
	private int hostId;
	private String originalName;
	private int fileSize;
	private String path;
	private int sortOrder;
	
	public HostPhotoDTO() {
		// TODO Auto-generated constructor stub
	}

	public HostPhotoDTO(int id, int hostId, String originalName, int fileSize, String path, int sortOrder) {
		super();
		this.id = id;
		this.hostId = hostId;
		this.originalName = originalName;
		this.fileSize = fileSize;
		this.path = path;
		this.sortOrder = sortOrder;
	}

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

	public int getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}
	
	
	
	
}
