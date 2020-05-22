package com.clover.p5.host.dto;

public class HostDTO {
	
	private int id; // 호스트 번호
	
	private String coverPhotoPath; // 대표 이미지 경로
	
	private String hostTypeName; // 호스트 종류
	private String roomTypeName; // 호스트 유형
	
	private int capacity; // 수용 인원
	private int roomCount; // 방 수
	private int bedCount; // 침대 수
	private int bathroomCount; // 욕실 수
	
	private String address; // API주소 + 상세주소(직접 입력)
	
	private String name; // 숙소 제목
	
	private String creationDate; // 작성일
	private String modificationDate; // 마지막 수정일
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCoverPhotoPath() {
		return coverPhotoPath;
	}
	public void setCoverPhotoPath(String coverPhotoPath) {
		this.coverPhotoPath = coverPhotoPath;
	}
	public String getHostTypeName() {
		return hostTypeName;
	}
	public void setHostTypeName(String hostTypeName) {
		this.hostTypeName = hostTypeName;
	}
	public String getRoomTypeName() {
		return roomTypeName;
	}
	public void setRoomTypeName(String roomTypeName) {
		this.roomTypeName = roomTypeName;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public int getRoomCount() {
		return roomCount;
	}
	public void setRoomCount(int roomCount) {
		this.roomCount = roomCount;
	}
	public int getBedCount() {
		return bedCount;
	}
	public void setBedCount(int bedCount) {
		this.bedCount = bedCount;
	}
	public int getBathroomCount() {
		return bathroomCount;
	}
	public void setBathroomCount(int bathroomCount) {
		this.bathroomCount = bathroomCount;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}
	public String getModificationDate() {
		return modificationDate;
	}
	public void setModificationDate(String modificationDate) {
		this.modificationDate = modificationDate;
	}

}
