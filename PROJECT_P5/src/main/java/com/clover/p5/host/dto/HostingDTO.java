package com.clover.p5.host.dto;

public class HostingDTO {
	
	private int hostId;
	private String coverPhotoPath;
	private String hostName;
	private String roomTypeName;
	
	public int getHostId() {
		return hostId;
	}
	public void setHostId(int hostId) {
		this.hostId = hostId;
	}
	public String getCoverPhotoPath() {
		return coverPhotoPath;
	}
	public void setCoverPhotoPath(String coverPhotoPath) {
		this.coverPhotoPath = coverPhotoPath;
	}
	public String getHostName() {
		return hostName;
	}
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}
	public String getRoomTypeName() {
		return roomTypeName;
	}
	public void setRoomTypeName(String roomTypeName) {
		this.roomTypeName = roomTypeName;
	}

}
