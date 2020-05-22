package com.clover.p5.member.service;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.Errors;
import org.springframework.web.multipart.MultipartFile;

import com.clover.p5.member.dto.ErrorFieldDTO;
import com.clover.p5.member.dto.NewMemberDTO;
import com.clover.p5.member.dto.ProfilePhoto;

public interface MemberService {
	
	
	boolean isEmailAvailable(String email);
	
	// 이메일 인증번호 발송
	String sendEmailCode(String email);
	// 이메일 인증
	boolean emailAuthentication(HttpServletRequest req);
	// 회원 가입(DB에 정보 입력)
	boolean signUp(NewMemberDTO dto);
		
	
	
	
	// 로그인
	int logIn(HttpServletRequest req, HttpServletResponse res);
	void logOut(HttpServletRequest req);
	
	Cookie refreshCookie(HttpServletRequest req, int memberId);
	
	
	// 임시 비밀번호 생성
	String randomPassword(int length);
	// 이메일로 임시 비밀번호 발급
	String sendTemporaryPassword(String email);
	// 임시 로그인
	boolean temporaryLogIn(HttpServletRequest req);
	
	
	// 회원정보 수정 - 이름, 성
	boolean updateUserName(HttpServletRequest req);
	// 회원정보 수정 - 생년월일
	boolean updateUserBirthDate(HttpServletRequest req, Date birthDate);
	
	// 현재 비밀번호 확인
	boolean checkPresentPassword(HttpServletRequest req);
	// 비밀번호 변경
	boolean updateUserPassword(HttpServletRequest req);
	

	
	
	// 휴대전화 인증여부 확인
	boolean isMobileAuthentication(HttpServletRequest req);
	// 휴대전화 인증번호 발송
	String sendMobileCode(String mobileNumber);
	// 휴대전화 인증(변경)
	int mobileAuthentication(HttpServletRequest req);
	
	
	
	
	
	
	// 프로필 사진 목록 가져오기
	List<ProfilePhoto> getProfilePhotoList(HttpServletRequest req);
	// 프로필 사진 저장(서버 + DB) 및 적용
	boolean addProfilePhoto(MultipartFile photoFile, HttpServletRequest req);
	// 프로필 사진 삭제
	boolean deleteProfilePhoto(HttpServletRequest req);
	// 프로필 사진 변경
	boolean changeProfilePhoto(HttpServletRequest req);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 유효성 검사 결과를 정리
	List<ErrorFieldDTO> validationResult(Errors errors);
	
	
}
