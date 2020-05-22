package com.clover.p5.member.dto;

import java.sql.Date;

public class NewMemberDTO {
	
	
//	@Pattern(regexp ="/^[A-Za-z0-9]([-_\\.]?[A-Za-z0-9])*@[A-Za-z0-9]([-_\\.]?[A-Za-z0-9])*\\.[A-Za-z]{2,3}$/i")
	private String email;
//	@NotBlank(message = "비밀번호를 입력해주세요")
//	@Pattern(regexp =
///		"/^[A-Za-z0-9~!@#$%^&*()_+|<>?:{}]{8,16}$/",
//	message = "비밀번호는 8~16자리 영문대소문자,숫자,특수문자(~!@#$%^&*()_+|<>?:{})를 사용해주세요")
	private String password;
//	@NotBlank(message = "비밀번호확인을 입력해주세요")
	private String passwordCheck;
	
//	@NotBlank(message = "이름을 입력해주세요")
///	@Pattern(regexp = "/^[가-힣]{1,20}$|^[A-Za-z]{1,60}$/",
//	message = "최대 한글 20글자 또는 영문 60글자까지 가능합니다")
	private String firstName;
//	@NotBlank(message="성을 입력해주세요")
//	@Pattern(regexp = "/^[가-힣]{1,10}$|^[A-Za-z]{1,30}$/",
//	message = "최대 한글 10글자 또는 영문 30글자까지 가능합니다")
	private String lastName;
	
//	@NotBlank(message="생년월일을 입력해주세요")
	private Date birthDate;
	//@NotBlank(message="휴대전화번호를 입력해주세요")
//	@Pattern(regexp = "/^01[016789]([1-9][0-9]{2,3})([0-9]{4})$/",
//	message = "휴대전화 번호의 형식이 올바르지 않습니다")
	private String mobilePhone;
	private String registrationDate;
	
	
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
	public String getPasswordCheck() {
		return passwordCheck;
	}
	public void setPasswordCheck(String passwordCheck) {
		this.passwordCheck = passwordCheck;
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
	public String getRegistrationDate() {
		return registrationDate;
	}
	public void setRegistrationDate(String registrationDate) {
		this.registrationDate = registrationDate;
	}
	@Override
	public String toString() {
		return "NewMemberDTO [email=" + email + ", password=" + password + ", passwordCheck=" + passwordCheck
				+ ", firstName=" + firstName + ", lastName=" + lastName + ", birthDate=" + birthDate + ", mobilePhone="
				+ mobilePhone + ", registrationDate=" + registrationDate + "]";
	}

}
