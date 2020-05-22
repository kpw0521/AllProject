package com.clover.p5.member.dto;

import java.sql.Date;

public class Member {
	
	private int id;
	private String email;
	private String password;
	private String firstName;
	private String lastName;
	private Date birthDate;
	private String mobilePhone;
	private char mobileAuthentication;
	private String registrationDate;
	
	private String profilePhotoPath;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public char getMobileAuthentication() {
		return mobileAuthentication;
	}

	public void setMobileAuthentication(char mobileAuthentication) {
		this.mobileAuthentication = mobileAuthentication;
	}

	public String getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(String registrationDate) {
		this.registrationDate = registrationDate;
	}

	public String getProfilePhotoPath() {
		return profilePhotoPath;
	}

	public void setProfilePhotoPath(String profilePhotoPath) {
		this.profilePhotoPath = profilePhotoPath;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", email=" + email + ", password=" + password + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", birthDate=" + birthDate + ", mobilePhone=" + mobilePhone
				+ ", mobileAuthentication=" + mobileAuthentication + ", registrationDate=" + registrationDate
				+ ", profilePhotoPath=" + profilePhotoPath + "]";
	}
	
	
	
	
	
	
	
	
	


	
}