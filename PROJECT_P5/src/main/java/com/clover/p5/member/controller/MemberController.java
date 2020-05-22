package com.clover.p5.member.controller;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.clover.p5.member.dto.NewMemberDTO;
import com.clover.p5.member.dto.ProfilePhoto;
import com.clover.p5.member.service.MemberService;



@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	
	
	
	@RequestMapping("/ajax/isEmailAvailable") // 이메일 중복여부 검사
	@ResponseBody
	public boolean isEmailAvailable(String email) {
		return memberService.isEmailAvailable(email);
	}
	
	
	
//********************************** 회원가입 ******************************************
	/*@RequestMapping("/ajax/validateSignUp") // 회원가입 유효성 검사
	@ResponseBody
	public List<ErrorFieldDTO> validateSignUp(NewMemberDTO newMemberDto, Errors errors) {
		System.out.println(newMemberDto);
		return memberService.validationResult(errors);
	}*/
	
	@RequestMapping("/ajax/sendEmailAuthenticationCode") // 인증메일 발송
	@ResponseBody // 이메일을 발송하고 해시된 인증번호를 반환한다.
	public String sendEmailAuthenticationCode(String email) {
		return memberService.sendEmailCode(email);
	}
	
	@RequestMapping("/ajax/emailAuthentication") // 이메일 인증
	@ResponseBody // 입력한 인증번호로 이메일 인증을 진행
	public boolean emailAuthentication(HttpServletRequest req) {
		return memberService.emailAuthentication(req);
	}
	
	@RequestMapping("/ajax/completeSignUp") // 회원가입 완료
	@ResponseBody // 회원가입 페이지에서 입력받은 정보를 DB에 저장하고 가입을 완료한다.
	public boolean completeSignUp(NewMemberDTO newMemberDto) {
		return memberService.signUp(newMemberDto);
	}
//********************************** 회원가입-END ******************************************
	
	
	
	
	
	
//********************************** 로그인, 로그아웃 ******************************************	
	@RequestMapping("/ajax/logIn") // 로그인
	@ResponseBody // 입력한 정보를 토대로 로그인을 시도하여 결과를 반환한다.
	public int logIn(HttpServletRequest req, HttpServletResponse res) {
		return memberService.logIn(req, res);
	}
	
	@RequestMapping("/ajax/logOut") // 로그아웃
	@ResponseBody // 세션을 초기화한다.
	public void logOut(HttpServletRequest req) {
		memberService.logOut(req);
		return;
	}
//********************************** 로그인, 로그아웃-END ******************************************	
	
	
	

	
	
//********************************** 임시 비밀번호 발급, 임시 로그인 ******************************************	
	@RequestMapping("/ajax/sendTemporaryPassword") // 임시 비밀번호 발급
	@ResponseBody // 입력받은 이메일로 임시 비밀번호를 발송한다
	public String sendTemporaryPassword(String userEmail) {
		return memberService.sendTemporaryPassword(userEmail);
	}
	
	@RequestMapping("/ajax/temporaryLogIn") // 임시 로그인
	@ResponseBody // 임시 비밀번호 발급 화면에서의 로그인
	public boolean temporaryLogIn(HttpServletRequest req) {
		return memberService.temporaryLogIn(req);
	}
//********************************** 임시 비밀번호 발급, 임시 로그인-END *************************************	

	
	
//********************************** 회원정보 수정 *************************************
	@RequestMapping("/ajax/updateUserName") // 이름, 성
	@ResponseBody
	public boolean updateUserName(HttpServletRequest req) {
		return memberService.updateUserName(req);
	}
	@RequestMapping("/ajax/updateUserBirthDate") // 생년월일
	@ResponseBody
	public boolean updateUserBirthDate(HttpServletRequest req, Date birthDate) {
		return memberService.updateUserBirthDate(req, birthDate);
	}
//********************************** 회원정보 수정-END *************************************
	
	
//********************************** 비밀번호 변경 *************************************
	@RequestMapping("/ajax/checkPresentPassword") // 현재 비밀번호 확인
	@ResponseBody // 기존의 비밀번호를 확인한다
	public boolean checkPresentPassword(HttpServletRequest req) {
		return memberService.checkPresentPassword(req);
	}
	@RequestMapping("/ajax/updateUserPassword") // 비밀번호 변경
	@ResponseBody // 새로운 비밀번호로 변경한다.
	public boolean updateUserPassword(HttpServletRequest req) {
		return memberService.updateUserPassword(req);
	}
//********************************** 비밀번호 변경-END *************************************	

	
	
	
	
	
	
//********************************** 휴대전화 인증 ******************************************	
	@RequestMapping("/ajax/isMobileAuthentication")
	@ResponseBody // 휴대전화 인증여부를 확인한다
	public boolean isMobileAuthentication(HttpServletRequest req) {
		return memberService.isMobileAuthentication(req);
	}
	
	@RequestMapping("/ajax/sendMobileAuthenticationCode")
	@ResponseBody // 건당 20원 API를 이용해서 인증문자를 전송한다
	public String sendMobileAuthenticationCode(String mobileNumber) {
		return memberService.sendMobileCode(mobileNumber);
	}
	
	@RequestMapping("/ajax/completeMobileAuthentication")
	@ResponseBody // 입력한 인증번호의 일치여부를 확인하고 결과를 DB에 적용한다 + session 갱신
	public int completeMobileAuthentication(HttpServletRequest req) {
		return memberService.mobileAuthentication(req);
	}
//********************************** 휴대전화 인증-END ******************************************
	
	
//********************************** 회원 프로필 사진 ******************************************	
	@RequestMapping("/ajax/getProfilePhotoList")
	@ResponseBody // 회원 프로필 사진 목록을 가져온다.
	public List<ProfilePhoto> getProfilePhotoList(HttpServletRequest req) {
		return memberService.getProfilePhotoList(req);
	}
	
	@RequestMapping("/ajax/addProfilePhoto")
	@ResponseBody // 회원 프로필 사진 등록(변경)
	public boolean addProfilePhoto(MultipartFile photoFile, HttpServletRequest req) {
		return memberService.addProfilePhoto(photoFile, req);
	}
	
	@RequestMapping("/ajax/deleteProfilePhoto")
	@ResponseBody // 회원 프로필 사진 삭제
	public boolean deleteProfilePhoto(HttpServletRequest req) {
		return memberService.deleteProfilePhoto(req);
	}
	
	@RequestMapping("/ajax/changeProfilePhoto")
	@ResponseBody // 회원 프로필 사진 변경
	public boolean changeProfilePhoto(HttpServletRequest req) {
		return memberService.changeProfilePhoto(req);
	}
//********************************** 회원 프로필 사진-END ******************************************	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
