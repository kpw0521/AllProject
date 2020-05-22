package com.clover.p5.member.mapper;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.clover.p5.member.dto.Member;
import com.clover.p5.member.dto.NewMemberDTO;
import com.clover.p5.member.dto.ProfilePhoto;
import com.clover.p5.member.dto.ProfilePhotoVO;

public interface MemberMapper {
	
	// 이메일 중복 확인
	int selectEmailCount(String email);
	
	
	// 회원정보 저장
	int insertMember(NewMemberDTO newHost);
	// 회원정보 검색(이메일로)
	Member selectMemberByEmail(String email);
	// 이메일로 회원ID 검색
	int selectMemberId(String email);
	// 회원정보 검색(ID로)
	Member selectMember(int memberId);
	
	// 자동 로그인 정보 삭제
	int deleteRememberMe(int memberId);
	// 자동 로그인 정보 저장
	int insertRememberMe(@Param("cookieValue") String cookieValue,
							@Param("memberId") int memberId);
	// 자동 로그인 유효여부 검색
	int selectRememberMeCount(String cookieValue);
	// 자동 로그인할 회원ID 검색
	int selectRememberMeMemberId(String cookieValue);
	
	
	
	
	
	
	
	
	// 회원정보 수정 - 이름, 성
	int updateName(@Param("memberId") int memberId,
					@Param("firstName") String firstName,
					@Param("lastName") String lastName);
	// 회원정보 수정 - 생년월일
	int updateBirthDate(@Param("memberId") int memberId,
						@Param("birthDate") Date birthDate);
	// 비밀번호 변경
	int updatePassword(@Param("memberId") int memberId,
						@Param("newPassword") String newPassword);
	
	
	
	
	
	// 휴대전화 인증 여부 검색
	String selectMobileAuthentication(int memberId);
	// 휴대전화 인증(변경)
	int updateMobileAuthentication(@Param("memberId") int memberId,
								@Param("mobilePhone") String mobilePhone);
	

	
	
	
	// 프로필 사진 검색
	List<ProfilePhoto> selectProfilePhotoList(int memberId);
	// 프로필 사진 유무만을 검색
	int selectProfilePhotoCount(int memberId);
	// 프로필 사진 등록
	int insertProfilePhoto(ProfilePhotoVO vo);
	// 프로필 사진 경로 검색
	String selectProfilePhotoPath(int profilePhotoId);
	// 프로필 사진 삭제
	int deleteProfilePhoto(int profilePhotoId);
	// 삭제된 프로필 사진 채우기
	int updateAutoProfile(int memberId);
	// 프로필 사진 해제
	int updateIsProfileN(int memberId);
	// 프로필 사진 적용
	int updateIsProfileY(int profilePhotoId);
	
	
	
}
