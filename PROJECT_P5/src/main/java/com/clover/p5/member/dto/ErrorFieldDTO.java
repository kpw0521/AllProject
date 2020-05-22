package com.clover.p5.member.dto;

public class ErrorFieldDTO {
	private String name;
	private String message;
	
	public ErrorFieldDTO() {}
	public ErrorFieldDTO(String name, String message) {
		this.name = name;
		this.message = message;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "ErrorFieldDTO [name=" + name + ", message=" + message + "]";
	}
	

}
