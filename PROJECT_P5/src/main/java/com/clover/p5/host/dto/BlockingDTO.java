package com.clover.p5.host.dto;

public class BlockingDTO {

	private int hostId;
	private String year;
	private String month;
	private String date;
	
	public int getHostId() {
		return hostId;
	}
	public void setHostId(int hostId) {
		this.hostId = hostId;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "BlockingDTO [hostId=" + hostId + ", year=" + year + ", month=" + month + ", date=" + date + "]";
	}
	
	
	
	
}
