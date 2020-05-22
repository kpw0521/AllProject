package com.clover.p5.host.dto;

public class Blocking {
	
	private int id; // 쓸 일이 있을까
	private int hostId;
	private String checkInDate;
	private char who;
	
	
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
	public String getCheckInDate() {
		return checkInDate;
	}
	public void setCheckInDate(String checkInDate) {
		this.checkInDate = checkInDate;
	}
	public char getWho() {
		return who;
	}
	public void setWho(char who) {
		this.who = who;
	}
	@Override
	public String toString() {
		return "Blocking [id=" + id + ", hostId=" + hostId + ", checkInDate=" + checkInDate + ", who=" + who + "]";
	}
	
	
	
	
	
	
}
