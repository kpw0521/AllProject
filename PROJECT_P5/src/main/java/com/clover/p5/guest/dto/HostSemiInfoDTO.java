package com.clover.p5.guest.dto;

public class HostSemiInfoDTO {
	
	/*
		h.id, h.member_id, h.name, h.description, h.description_etc, h.capacity, 
    	h.bed_count, h.bathroom_count, h.room_count, h.address, h.latitude, h.longitude,
    	rt.name, ht.name, hp.original_name , hp.path, hp.sort_order
	*/
	
	// 호스트정보
	private int id;
	private int MemberId;
	private String name;
	private String description;
	private String descriptionEtc;
	
	private int capacity;
	private int roomCount;
	private int bedCount;
	private int bathroomCount;
	
	private String address;
	private double latitude;
	private double longitude;
	
	// 리뷰 
	private String rateAvg;
	private String reviewCount;
	
	// 호스트 타입
	private String htName;
	// 룸 타입
	private String rtName;
	
	// 호스트 대표사진
	private String path;
	private String originalName;
	
	@Override
	public String toString() {
		return "HostSemiInfoDTO [id=" + id + ", MemberId=" + MemberId + ", name=" + name + ", description="
				+ description + ", descriptionEtc=" + descriptionEtc + ", capacity=" + capacity + ", roomCount="
				+ roomCount + ", bedCount=" + bedCount + ", bathroomCount=" + bathroomCount + ", address=" + address
				+ ", latitude=" + latitude + ", longitude=" + longitude + ", rateAvg=" + rateAvg + ", reviewCount="
				+ reviewCount + ", htName=" + htName + ", rtName=" + rtName + ", path=" + path + ", originalName="
				+ originalName + "]";
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMemberId() {
		return MemberId;
	}

	public void setMemberId(int memberId) {
		MemberId = memberId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescriptionEtc() {
		return descriptionEtc;
	}

	public void setDescriptionEtc(String descriptionEtc) {
		this.descriptionEtc = descriptionEtc;
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

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getRateAvg() {
		return rateAvg;
	}

	public void setRateAvg(String rateAvg) {
		this.rateAvg = rateAvg;
	}

	public String getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(String reviewCount) {
		this.reviewCount = reviewCount;
	}

	public String getHtName() {
		return htName;
	}

	public void setHtName(String htName) {
		this.htName = htName;
	}

	public String getRtName() {
		return rtName;
	}

	public void setRtName(String rtName) {
		this.rtName = rtName;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getOriginalName() {
		return originalName;
	}

	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	
	
	
	
	
}
