package com.clover.p5.guest.dto;

public class SearchHostDTO {
	
	private String sStartDate;
	private String sEndDate;
	private double swLatitude;
	private double neLatitude;
	private double swLongitude;
	private double neLongitude;
	private int guestCount;
	
	public SearchHostDTO() {
		// TODO Auto-generated constructor stub
	}

	public SearchHostDTO(String sStartDate, String sEndDate, double swLatitude, double neLatitude, double swLongitude,
			double neLongitude, int guestCount) {
		super();
		this.sStartDate = sStartDate;
		this.sEndDate = sEndDate;
		this.swLatitude = swLatitude;
		this.neLatitude = neLatitude;
		this.swLongitude = swLongitude;
		this.neLongitude = neLongitude;
		this.guestCount = guestCount;
	}
	
	
	
	
}
