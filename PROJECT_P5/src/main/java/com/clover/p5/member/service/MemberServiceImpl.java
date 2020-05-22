package com.clover.p5.member.service;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.multipart.MultipartFile;

import com.clover.p5.member.dto.ErrorFieldDTO;
import com.clover.p5.member.dto.Member;
import com.clover.p5.member.dto.NewMemberDTO;
import com.clover.p5.member.dto.ProfilePhoto;
import com.clover.p5.member.dto.ProfilePhotoVO;
import com.clover.p5.member.mapper.MemberMapper;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private JavaMailSender javaMailSender;
	
	
	
	
	
	
	
	
//******************************** 인증 이메일 전송 ********************************************
	@Override
	public String sendEmailCode(String email) {
			// 6자리 숫자 난수 생성(100000 ~ 999999)
		 String code = new Random().nextInt(900000) + 100000 + "";
		 String content = "이메일 인증번호는 " + code + "이며 인증번호를 입력하시면 회원가입을 완료하실 수 있습니다^^";				
		 String hashedCode = passwordEncoder.encode(code); // 인증번호 해싱
		 
		 MimeMessage message = javaMailSender.createMimeMessage();
         try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
            messageHelper.setSubject("P5 이메일 인증 안내드립니다."); // 메일제목은 생략이 가능하다
            messageHelper.setText(content); // 메일 내용
            messageHelper.setFrom("p5.email.authentication"); // 보내는사람 생략하면 정상작동을 안함
            messageHelper.setTo(email); // 받는사람 이메일
            
            javaMailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
			return ""; // 메일 발송 실패
		}
         
         return hashedCode;
	}
//******************************** 인증 이메일 전송-END ********************************************
	
	
	
//******************************** 이메일 인증 ********************************************
	public boolean emailAuthentication(HttpServletRequest req) {
		String authenticationCode = req.getParameter("authenticationCode");
		String inputCode = req.getParameter("inputCode");
		
		/***
		** 인증번호 입력값과 비교
		***/
			if(authenticationCode.isEmpty()) {
				return false;
			}
			if(!passwordEncoder.matches(inputCode, authenticationCode)) {
				return false;
			}
		
		return true;
	}
//******************************** 이메일 인증-END ******************************************
	
	
	
	
//****************************** 회원 가입 **************************************************	
	@Override
	public boolean signUp(NewMemberDTO newMemberDto) {
		/***
		** 회원 정보를 DB에 저장
		***/
			newMemberDto.setPassword( // DB에 저장 전에 암호 해시화
					passwordEncoder.encode(newMemberDto.getPassword())
			);
			// 서버시간에 서울의 타임존을 적용한 DateTime을 얻는다
			ZonedDateTime nowSeoul = ZonedDateTime.now(ZoneId.of("Asia/Seoul"));
			newMemberDto.setRegistrationDate( // 필요한 형식으로 변경하여 세팅
					nowSeoul.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))
			);
			if(memberMapper.insertMember(newMemberDto) == 1) { // DB에 저장
				System.out.println("회원가입 완료^^");
				return true;
			}
					
			System.out.println("회원정보 DB에 저장 실패");
			return false;
	}
//****************************** 회원 가입-END **************************************************		
	
	

	
	
	public Cookie refreshCookie(HttpServletRequest req, int memberId) {
		String sessionId = req.getSession().getId();
		String cookieValue = sessionId + System.currentTimeMillis();
		Cookie cookie = new Cookie("rememberMe", cookieValue);
		
		System.out.println(cookieValue + "\t" + memberId);
		
		if(memberMapper.deleteRememberMe(memberId) == 1) {
			System.out.println("기존의 쿠키 정보를 DB에서 삭제했습니다.");
		}; // 기존의 쿠키 정보 삭제
		if(memberMapper.insertRememberMe(cookieValue, memberId) == 1) {
			System.out.println("새로운 쿠키 정보를 DB에 입력했습니다.");
		}; // 새로운 쿠키 정보 입력
		
		cookie.setPath("/");
		cookie.setMaxAge(60*60*24*7);
		
		return cookie;
	}


	





//******************************** 로그인 ********************************************
	@Override
	public int logIn(HttpServletRequest req, HttpServletResponse res) {
		String userEmail = req.getParameter("userEmail");
		String password = req.getParameter("userPassword");
		
		Member member = memberMapper.selectMemberByEmail(userEmail);
		
		if(member == null) {
			return 0; // 없는 아이디
		}
		if(!passwordEncoder.matches(password, member.getPassword())) {
			return 1; // 비밀번호 불일치
		}
		
		String isRememberMe = req.getParameter("rememberMe");
		if(isRememberMe.equals("true")) {
			System.out.println("자동 로그인에 체크하셨군요?");
			res.addCookie(refreshCookie(req, member.getId()));
		}
		
		req.getSession().setAttribute("user", member); // 세션에 정보 저장
		return 2; // 로그인 성공
	}
//******************************** 로그인-END ********************************************

	
	
	
	
	
//******************************** 임시 비밀번호 생성 ********************************************	
	@Override
	public String randomPassword(int length) {
		int index = 0;
		char[] charSet = new char[] {
				'0','1','2','3','4','5','6','7','8','9'
				,'A','B','C','D','E','F','G','H','I','J','K','L','M'
				,'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
				,'a','b','c','d','e','f','g','h','i','j','k','l','m'
				,'n','o','p','q','r','s','t','u','v','w','x','y','z'};
		
		StringBuffer sb = new StringBuffer();
		for (int i=0; i<length; i++) {
			index =  (int) (charSet.length * Math.random());
			sb.append(charSet[index]);
		}
		
		return sb.toString();
	}
//******************************** 임시 비밀번호 생성-END ********************************************
	
	
//******************************** 임시 비밀번호 발급 ***************************************	
	@Override
	public String sendTemporaryPassword(String email) {
			// 16자리 숫자, 영문 대, 소문자 조합 난수 생성
		String temporaryPassword = randomPassword(16);
		System.out.println("임시 비밀번호 생성 - " + temporaryPassword);
		
		String content = "임시 비밀번호는 " + temporaryPassword + "이며"
						+ " 발급 화면에서만 유효함을 알려드립니다. 발급 화면에서 임시 비밀번호를 통해 로그인할 경우,"
						+ " 계정의 비밀번호는 로그인에 사용된 임시 비밀번호로 변경되며 이후에 꼭 비밀번호 변경을 통해"
						+ " 보안에 신경쓰실 것을 권고드립니다.";
		
		String hashedPassword = passwordEncoder.encode(temporaryPassword); // 임시 비밀번호 해싱
		 
		MimeMessage message = javaMailSender.createMimeMessage();
        try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
           messageHelper.setSubject("P5에서 임시 비밀번호 발급 안내드립니다."); // 메일제목은 생략이 가능하다
           messageHelper.setText(content); // 메일 내용
           messageHelper.setFrom("p5.email.temporary-password"); // 보내는사람 생략하면 정상작동을 안함
           messageHelper.setTo(email); // 받는사람 이메일
           
           javaMailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
			System.out.println("임시 비밀번호 발급(메일 발송) 실패");
			return ""; // 메일 발송 실패
		}
        
        return hashedPassword;
	}
//******************************** 임시 비밀번호 발급-END ***********************************
	
	
//******************************** 임시 로그인 ********************************************
	@Override
	public boolean temporaryLogIn(HttpServletRequest req) {
			// 로그인 하려는 계정
		String userEmail = req.getParameter("userEmail");
			// 임시 로그인 화면에서 입력한 비밀번호
		String inputPassword = req.getParameter("inputTemporaryPassword");
			// 임시 로그인 화면에서만 유효한 임시 비밀번호(해싱)
		String temporaryPassword = req.getParameter("temporaryPassword");
		
	/***
	** 입력 값과 임시 비밀번호를 비교
	***/
		if(!passwordEncoder.matches(inputPassword, temporaryPassword)) {
			return false; // 불일치
		}
		
	/***
	** 일치하면 해싱된 임시비밀번호로 비밀번호를 변경한다.
	***/
		int userId = memberMapper.selectMemberId(userEmail);
		if(memberMapper.updatePassword(userId, temporaryPassword) == 1) {
			System.out.println("임시비밀번호를 비밀번호로 변경했습니다.");
		}
		
	/***
	** 회원정보를 session에 등록한다. - 로그인
	***/
		Member member = memberMapper.selectMember(userId);
		
		req.getSession().setAttribute("user", member); // 세션에 정보 저장
		
		return true; // 로그인 성공
	}
//******************************** 임시 로그인-END ******************************************
	
	
	
	
	
	
	
//******************************** 회원정보 수정 ********************************************
	@Override
	public boolean updateUserName(HttpServletRequest req) {
		int memberId = getSessionUserId(req);
		String firstName = req.getParameter("firstName");
		String lastName = req.getParameter("lastName");
		if(memberMapper.updateName(memberId, firstName, lastName) == 1) {
			System.out.println("회원정보 수정(이름, 성)을 완료했습니다.");
			refreshUserSession(req); // 세션 갱신
			return true;
		}
		System.out.println("회원정보 수정(이름, 성)에 실패했습니다.");
		return false;
	}
	@Override
	public boolean updateUserBirthDate(HttpServletRequest req, Date birthDate) {
		int memberId = getSessionUserId(req);
		if(memberMapper.updateBirthDate(memberId, birthDate) == 1) {
			System.out.println("회원정보 수정(생년월일)을 완료했습니다.");
			refreshUserSession(req); // 세션 갱신
			return true;
		}
		System.out.println("회원정보 수정(생년월일)에 실패했습니다.");
		return false;
	}
//******************************** 회원정보 수정-END ********************************************
	
	
//******************************** 비밀번호 변경 ********************************************
	@Override
	public boolean checkPresentPassword(HttpServletRequest req) {
		String userPassword = req.getParameter("userPassword");
		int userId = getSessionUserId(req);
		
		Member member = memberMapper.selectMember(userId);
		if(!passwordEncoder.matches(userPassword, member.getPassword())) {
			System.out.println("기존 비밀번호 불일치");
			return false; // 비밀번호 불일치
		}
		System.out.println("기존 비밀번호 일치 확인");
		return true;
	}
	
	@Override
	public boolean updateUserPassword(HttpServletRequest req) {
		String newPassword = req.getParameter("newPassword");
		int userId = getSessionUserId(req);
	
			// 해싱값을 DB에 저장한다.
		String HashedNewPassword = passwordEncoder.encode(newPassword);
		if(memberMapper.updatePassword(userId, HashedNewPassword) == 1) {
			System.out.println("비밀번호 변경 완료");
			return true;
		}
		System.out.println("비밀번호 변경 실패");
		return false;
	}
//******************************** 비밀번호 변경-END ********************************************
	
	
	
	
	
	
	
	
	
	
	

//******************************** 휴대전화 인증 여부 확인 ********************************************
	@Override
	public boolean isMobileAuthentication(HttpServletRequest req) {
		String result = memberMapper.selectMobileAuthentication(getSessionUserId(req));
		if(result.equals("Y")) {
			return true;
		}
		return false;
	}
//******************************** 휴대전화 인증 여부 확인-END ********************************************
	
	
//******************************** 인증 문자메세지 전송 ********************************************
	@Override
	public String sendMobileCode(String mobileNumber) {
			// 6자리 숫자 난수 생성(100000 ~ 999999)
		String code = new Random().nextInt(900000) + 100000 + "";
		String content = "P5입니다^^ 휴대전화 인증번호는 다음과 같습니다 - " + code;
		String hashedCode = passwordEncoder.encode(code); // 인증번호 해싱
		
		String apiKey = "NCS9FLMUM2URIAA9";
	    String apiSecret = "GOOZEG4YKEZFLWDTBCUPWCRTIGTREH3S";
	    Message coolsms = new Message(apiKey, apiSecret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", mobileNumber); // 수신번호
	    params.put("from", "01099641539"); // 발신번호
	    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
	    params.put("text", content); // 문자내용    
	    
	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	      
	      // 잔액 확인..
	      obj = (JSONObject) coolsms.balance();
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	      return "";
	    }
		return hashedCode;
	}
//******************************** 인증 문자메세지 전송-END ********************************************

	
//******************************** 휴대전화 인증(변경) ********************************************
	@Override
	public int mobileAuthentication(HttpServletRequest req) {
		String mobilePhone = req.getParameter("mobilePhone");
		String authenticationCode = req.getParameter("authenticationCode");
		String inputCode = req.getParameter("inputCode");
		int userId = getSessionUserId(req);
		
		/***
		** 인증번호 입력값과 비교
		***/
			if(!passwordEncoder.matches(inputCode, authenticationCode)) {
				return 0;
			}
			
		/***
		** 통과했으면 DB에 결과를 저장
		***/
			if(memberMapper.updateMobileAuthentication(userId, mobilePhone) == 1) {
				System.out.println("휴대전화 인증 결과를 DB에 저장했습니다.");
				refreshUserSession(req); // session 새로고침
				return 1;
			}
			System.out.println("휴대전화 인증 결과를 DB에 저장하지 못했습니다.");
			return 2;
	}
//******************************** 휴대전화 인증(변경)-END ********************************************

	
	
	
	
	
	

	
	
	
	
	





	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//********************************** 프로필 사진 가져오기 *******************************************
	@Override
	public List<ProfilePhoto> getProfilePhotoList(HttpServletRequest req) {
		List<ProfilePhoto> list = memberMapper.selectProfilePhotoList(getSessionUserId(req));
		System.out.println(list.size() + "개의 프로필 사진이 등록되어 있습니다.");
		
		return list;
	}
//********************************** 프로필 사진 가져오기-END *******************************************
	
	

//********************************** 프로필 사진 등록 *******************************************
	@Transactional
	@Override
	public boolean addProfilePhoto(MultipartFile photoFile, HttpServletRequest req) {
		int memberId = getSessionUserId(req);
		String defaultPath = req.getServletContext().getRealPath("/");
		  
	      //파일 기본경로 _ 상세경로
	      String folderPath = defaultPath + "resources" + File.separator + "upload" + File.separator + "profile" + File.separator + memberId + File.separator;
	      System.out.println("저장 경로 : " + folderPath);
	      
		/**
		** 파일을 저장할 폴더가 존재하지 않을 경우 폴더를 생성해준다.
		**/
			File folder = new File(folderPath);
	        if(!folder.exists()) { // 존재하지 않으면
	            if(folder.mkdirs()) { // 폴더를 생성하고 결과를 출력
	            	System.out.println("폴더 생성 완료 : " + folderPath);
	            }
	        }
	        
	    /**
	    ** 서버에 파일을 저장하고 DB에 저장할 정보를 생성.
	    **/
    		// 원본 파일명
    		String originalName = photoFile.getOriginalFilename();
    		// 파일 크기
    		long fileSize = photoFile.getSize();
    		// 파일 확장자
    		String fileExtension =
				originalName.substring(originalName.lastIndexOf("."));
    		
    		// 저장 파일명을 생성
    		ZonedDateTime nowSeoul = ZonedDateTime.now(ZoneId.of("Asia/Seoul"));
    		String saveName = (
				nowSeoul.format(DateTimeFormatter.ofPattern("yyMMdd_HHmmssSSS_")) +
				UUID.randomUUID() + fileExtension		).replace("-", "");
    		
    		// 서버에 저장될 실제 '저장' 경로
    		String savePath = folderPath + saveName;
    		
    		// DB에 저장될 최종 path
    		String path = req.getContextPath() + "/upload/profile/" + memberId + "/" + saveName;
    		System.out.println("이미지 경로 : " + path);
    		
    		ProfilePhotoVO profilePhotoVo = new ProfilePhotoVO(memberId, originalName, fileSize, path);
	    		
	/***
	 ** 서버에 파일 저장
	 ***/
    		File file = new File(savePath);
    		try {
				photoFile.transferTo(file);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
				System.out.println("업로드 파일을 서버에 저장 중에 오류 발생");
				return false;
			}
    		
	/***
	** DB에 파일 정보 저장
	***/
			if(memberMapper.selectProfilePhotoCount(memberId) != 0) { // 기존에 프로필 사진이 있으면
				if(memberMapper.updateIsProfileN(memberId) != 1) { // 프로필 해제시킨 뒤
					System.out.println("프로필 사진 등록 사전 작업 중에 오류 발생");
					return false;
				}
			}
			if(memberMapper.insertProfilePhoto(profilePhotoVo) != 1) { // 프로필 등록과 동시에 변경
				System.out.println("프로필 사진 등록 중에 오류 발생");
				return false;
			}
				// 문제 없이 모든 작업을 마쳤으면
			refreshUserSession(req); // 세션을 갱신
			
			System.out.println("프로필 사진 등록(변경)을 완료했습니다.");
			return true;
	}
//********************************** 프로필 사진 등록-END *******************************************

	
//****************************** 프로필 사진 삭제(서버 파일) ***********************************************
	public boolean deleteServerFile(HttpServletRequest req, int memberId, int hostPhotoId) {
		
		String defaultPath = req.getServletContext().getRealPath("/");
		String folderPath = defaultPath + "resources" + File.separator + "upload" + File.separator + "profile" + File.separator + memberId + File.separator;
		
		String path = memberMapper.selectProfilePhotoPath(hostPhotoId);
		String saveName = path.substring(path.lastIndexOf("/") + 1);
		// 서버에 파일이 저장된 경로
		String deletePath = folderPath + saveName;
		
		File file = new File(deletePath);
		if(file.exists()){
			if(file.delete()){
				System.out.println("파일 삭제 성공");
				return true;
			}else{
				System.out.println("파일 삭제 실패");
				return false;
			} 
		}
		System.out.println("파일이 존재하지 않습니다.");
		return true;
		
	}
//**************************** 프로필 사진 삭제(서버 파일)-END ***********************************************	
//********************************** 프로필 사진 삭제 *******************************************
	@Transactional
	@Override
	public boolean deleteProfilePhoto(HttpServletRequest req) {
		int memberId = getSessionUserId(req);
		int photoId = Integer.parseInt(req.getParameter("photoId"));
		
		if(!deleteServerFile(req, memberId, photoId)) {
			return false;
		}
		if(memberMapper.deleteProfilePhoto(photoId) != 1) {
			System.out.println("프로필 사진 삭제(DB) 중에 오류 발생");
			return false;
		}
			// 대체할 게 있나?
		if(memberMapper.selectProfilePhotoCount(memberId) != 0) { // 있으면
			if(memberMapper.updateAutoProfile(memberId) != 1) { // 대체에 실패
				System.out.println("프로필 사진 삭제(DB) 이후 대체 중에 오류 발생");
				return false;
			}
			System.out.println(photoId + "번 프로필 사진 삭제 + 대체를 완료했습니다.");
		} else { // 없으면
			System.out.println(photoId + "번 프로필 사진 삭제를 완료했습니다.");
		}
			// 문제 없이 모든 작업을 마쳤으면
		refreshUserSession(req); // 세션을 갱신
		
		return true;
	}
//********************************** 프로필 사진 삭제-END *******************************************

	
	
//********************************** 프로필 사진 변경 *******************************************
	@Transactional
	@Override
	public boolean changeProfilePhoto(HttpServletRequest req) {
		int memberId = getSessionUserId(req);
		int photoId = Integer.parseInt(req.getParameter("photoId"));
		
		if(memberMapper.updateIsProfileN(memberId) != 1) {
			System.out.println("프로필 사진 변경 사전 작업 중에 오류 발생");
			return false;
		}
		if(memberMapper.updateIsProfileY(photoId) != 1) {
			System.out.println("프로필 사진 변경 중에 오류 발생");
			return false;
		}
			// 문제 없이 모든 작업을 마쳤으면
		refreshUserSession(req); // 세션 갱신
		
		System.out.println(photoId + "번 사진으로 프로필 사진을 변경했습니다.");
		return true;
	}
//********************************** 프로필 사진 변경-END *******************************************

	
	

	

	

	
	
	
	
	
	




	
	
	
	
//************************** 로그인 세션(user)의 회원정보 ID 검색 ***************************************
	public static int getSessionUserId(HttpServletRequest req) {
		return ((Member)req.getSession().getAttribute("user")).getId();
	}
//************************ 로그인 세션(user)의 회원정보 ID 검색-END ************************************
	
	
//********************************** session 갱신 ********************************************
	public void refreshUserSession(HttpServletRequest req) {
		Member member = memberMapper.selectMember(getSessionUserId(req));
		req.getSession().setAttribute("user", member); // session을 갱신
		System.out.println("session 갱신 완료.");
	}
//******************************** session 갱신-END ******************************************

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//******************************** 백엔드 유효성 검사 결과 ********************************************
	@Override
	public List<ErrorFieldDTO> validationResult(Errors errors) {
		ArrayList<ErrorFieldDTO> list = new ArrayList<>();
		
		if(errors.hasErrors()) {
			for(FieldError error : errors.getFieldErrors()) {
				String name = error.getField();
				String message = error.getDefaultMessage();
				ErrorFieldDTO dto = new ErrorFieldDTO(name, message);
				System.out.println(dto);
				
				list.add(dto);
			}
		}
		System.out.println("유효성 검사 탈락 : " + list.size() + "건");
        return list;
	}
//******************************** 백엔드 유효성 검사 결과-END ********************************************



	@Override
	public void logOut(HttpServletRequest req) {
		int memberId = getSessionUserId(req);
		if(memberMapper.deleteRememberMe(memberId) == 1) {
			System.out.println("자동 로그인 정보를 DB에서 삭제했습니다.");
		}
		req.getSession().invalidate();
		System.out.println("로그아웃을 완료(세션 초기화)했습니다.");
	}



	@Override
	public boolean isEmailAvailable(String email) {
		if(memberMapper.selectEmailCount(email) == 0) {
			return true; // 사용가능
		}
		return false; // 이미 사용중인 이메일
	}



	



	

	
}
