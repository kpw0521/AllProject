package com.clover.p5.guest.dto;

public class ReviewInfoDTO {
	
	// review
	private String bookingId;
	private String rating;
	private String content;
	private String creationDate;
	
	// member 정보
	private String firstName;
	private String lastName;
	
	// profile 정보
	private String path;
	private String originalName;
	
	@Override
	public String toString() {
		return "MemberReviewDTO [bookingId=" + bookingId + ", rating=" + rating + ", content=" + content
				+ ", creationDate=" + creationDate + ", firstName=" + firstName + ", lastName=" + lastName + ", path="
				+ path + ", originalName=" + originalName + "]";
	}

	public String getBookingId() {
		return bookingId;
	}

	public void setBookingId(String bookingId) {
		this.bookingId = bookingId;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
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
