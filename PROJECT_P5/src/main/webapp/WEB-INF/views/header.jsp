<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>

<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="/p5/js/daterangepicker.js"></script>

<!-- Link Swiper's CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet"
	href="https://unpkg.com/swiper/css/swiper.min.css">
<link rel="stylesheet" href="/p5/css/daterangepicker.css" />
<link rel="stylesheet" href="/p5/css/reset.css" />
<link rel="stylesheet" href="/p5/css/header.css" />

<body>
	<div id="widthTest"></div>
	<header>
		<button id="headerMobileButton">
			<i class="fas fa-search fa-3x"></i>
		</button>
		
		<div class="title-logo-img">
			<a href="/p5"><img src="/p5/img/p5_logo.png" id="titleLogoImg" /></a>
			<!-- 로고 이미지 들어갈 자리 -->
		</div>


		<!-- 정보입력-->
		<div class="input-info">
			<form action="/p5/reservationList" method="post">

				<!--지역 입력  -->
				<div class="input-search-value-input">
					<div class="input-location-block">
						<span class="input-text"><i
							class="fas fa-map-marked-alt fa-2x"></i></span> <span class="inputWrap">
							<input class="input-serach-value" type="text" name="address"
							id="address" placeholder="어디로 여행가세요?" /> <input type="button"
							id="locationReset" value="&#xf01e">
						</span>
					</div>

					<!--날짜 입력  -->
					<div class="input-date-block">
						<span class="input-text"> <i
							class="fas fa-calendar-alt fa-2x"></i>
						</span> <span class="inputWrap"> <input class="input-serach-value"
							type="text" id="checkDate" name="checkInDatecheckOutDate"
							autocomplete="off" placeholder=" 날짜는?" onchange="countDate()" />
							<input type="button" id="dateReset" value="&#xf01e">
						</span>
					</div>

					<!--인원  -->
					<div class="input-guestCount-block">
						<span class="input-text"> <i class="fas fa-user-alt fa-2x"></i>
						</span> <span class="inputWrap"> <input type='text'
							id="guestCount" name='guestCount' class="guestCount_input"
							autocomplete="off" placeholder="  인원은?" readonly="readonly"
							value="">
							<button id="decreaseQuantity">
								<i class="fas fa-minus fa-xs"></i>
							</button>
							<button id="increaseQuantity">
								<i class="fas fa-plus fa-xs"></i>
							</button> <input type="button" id="guestCountReset" value="&#xf01e">
						</span>
					</div>
					<!--인원 카운트 다운 0미만은 줄일수 없게함  -->

					<input type="submit" id="searchBtn" value="&#xf002"
						onclick="return checkValue();" />
				</div>
			</form>
		</div>

		<script>
			//버튼 on/off display 작성하기~ val() 뽑아서
		</script>

		<div class="useradd-login-form">
			<%
				if (session.getAttribute("user") == null) {
			%>
			<!--클릭시 로그인  modal pop-up -->
			<button id="login-btn" class="btn">로그인</button>
			<!--클릭시 회원가입 modal pop-up -->
			<button id="useradd-btn" class="btn">회원가입</button>
			<%
				} else {
			%>
			<!-- 이름만 출력 -->
			<!-- <a href='host/registration/roomType'>호스트 등록</a> -->
			<button class='btn' onclick='isMobileAuthentication()'>호스트
				등록</button>
			<button class="user-drop-down-btn btn">
				<span id="userImgBlock"> <c:set var="defaultProfilePhotoPath"
						value="/p5/img/defaultProfile.png" /> <c:choose>
						<c:when test="${empty user.profilePhotoPath}">
							<img id="userImg" src="${defaultProfilePhotoPath }" alt="" />
						</c:when>
						<c:otherwise>
							<img id="userImg" src="${user.profilePhotoPath }" alt="" />
						</c:otherwise>
					</c:choose>
				</span> 
				<span id="userFirstNameSpan">${user.firstName }</span>
			</button>

			<script>
				//////////////////////////////사용자 dropdown창.
				$(".user-drop-down-btn").on('click', function() {
					if ($('.user-drop-down').css("display") == "none") {

						$('.user-drop-down').css("display", "block");
					} else {
						$('.user-drop-down').css("display", "none");
					}
				});
			</script>

			<div class="user-drop-down">
				<p class="user-drop-down-label">Host</p>
				<div class="user-drop-down-menu-btn" id='btnHostReservationList'>등록한
					숙소보기</div>
				<p class="user-drop-down-label">Guest</p>
				<div class="user-drop-down-menu-btn" id='btnUserInfoUpdate'>회원정보</div>
				<div class="user-drop-down-menu-btn" id='btnUserReservationList'>예약
					숙소 리스트</div>
				<div class="user-drop-down-menu-btn" id='btnLogOut'>로그아웃</div>
			</div>
			<script>
				$('#btnHostReservationList').on('click', function() {
				//	alert("등록한 숙소 리스트로 이동");
					location.href = "/p5/host/hostList";
				});

				$('#btnUserInfoUpdate').on('click', function() {
				//	alert("회원정보수정으로 이동");
					location.href = "/p5/userInfoUpdate";
				});

				$('#btnUserReservationList').on('click', function() {
				//	alert("예약 숙소리스트로 이동");
					
					var userId = ${user.id};
					/*jQuery form 전송 방식*/
					// create element(form)
					var newForm = $('<form><form>');
					
					// set attribute(form)
					newForm.attr("name","newForm");
					newForm.attr("method","POST");
					newForm.attr("action","/p5/userInfoReservationList");
					//newForm.attr("target","_blank");
					newForm.attr("target","_self");
					
						/*
						target 속성!
						<form> 태그의 target 속성은 폼 데이터(form data)를 서버로 제출한 후
						받는 응답이 열릴 위치를 명시합니다. 
						(기본값은 _self : 응답을 링크가 위치한 현재 프레임에서 보여줌)
						_blank : 응답을 새로운 윈도우나 탭에서 보여줌
						*/
					// create element & set attribute (input)
					newForm.append($('<input/>', {type: 'hidden', name: 'memberId', value: userId}));
							
					// append form(to body)	
					newForm.appendTo('body');
					
					// submit form
					newForm.submit();
					
					//location.href = "userInfoReservationList";
					
				});
			</script>

			<%
				}
			%>
		</div>

	</header>

	<div class="modalBack"></div>

	<div id="modalLogin" class="modal">
		<!-- 닫기버튼 -->
		<span id="login-close" class="close">&times;</span>

		<div class="modal-popup">
		<div class="modalWrap">
			<br><br><br>
			<h1>로그인</h1>
			<hr>
			<form action="" onsubmit="return userLogin()">
				<div class="loginTitle">이메일</div>
				<div class="loginInput">
					<input type="text" class="user-login-input-value" id="userEmail"
						name="userEmail" />
				</div>

				<div class="loginTitle">비밀번호</div>
				<div class="loginInput">
					<input type="password" class="user-login-input-value"
						id="userPassword" name="userPassword" />
				</div>
				<div class="rememberLogin">
					<input type="checkbox" id="rememberMe" /> <label for="rememberMe">자동
						로그인</label>
				</div>
				<div class="loginCheck"></div>
				<input type="submit" value="로그인" class="loginButtons login" />
			</form>
			<input type="button" value="카카오 로그인" class="loginButtons kakao" onclick="alert('준비중입니다.')"/>
			<br>
			<input type="button" id="emailUserAdd" value="이메일로 가입하기" class="loginButtons" /><br>
			<button id="makeshiftPasswordBtn" class="loginButtons" >비밀번호를 잊어버리셨나요?</button>
			<br><br><br>&nbsp;
		</div>
		</div>
	</div>

	<!-- 회원가입 -->
	<form name="newMember">
		<div id="modalUseradd" class="modal">

			<!-- 닫기버튼 -->
			<span id="useradd-close" class="close">&times;</span>

			<!-- 회원가입 1단계 ( 정보입력 )  -->
			<div class="modal-popup">
			<div class="modalWrap">
				<br><br><br>
				<h1>회원가입</h1>
				<hr>
				<div class="formTitle">이메일</div>
				<div class="formInput">
					<input type="text" class="input-value" id="inputEmail" name="email" />
				</div>
				<div class="form-input-check" id="idCheck"></div>

				<div class="formTitle">비밀번호</div>
				<div class="formInput">
					<input type="password" class="input-value" id="inputPassword"
						name="password" />
				</div>
				<div class="form-input-check" id="passwordCheck"></div>

				<div class="formTitle">비밀번호 확인</div>
				<div class="formInput">
					<input type="password" class="input-value" id="inputPasswordCheck"
						name="passwordCheck" />
				</div>
				<div class="form-input-check" id="passwordReCheck"></div>

				<div class="formTitle">이름</div>
				<div class="formInput">
					<input type="text" class="input-value" id="inputFirstName"
						name="firstName" />
				</div>
				<div class="form-input-check" id="firstNameCheck"></div>

				<div class="formTitle">성</div>
				<div class="formInput">
					<input type="text" class="input-value" id="inputLastName"
						name="lastName" />
				</div>
				<div class="form-input-check" id="lastNameCheck"></div>

				<div class="formTitle">생년월일</div>
				<div class="formInput">
					<input type="date" class="input-value" id="inputDate"
						name="birthDate" />
				</div>
				<div class="form-input-check" id="dateCheck"></div>

				<div class="formTitle">휴대전화</div>
				<div class="formInput">
					<input type="text" class="input-value" id="inputTel"
						name="mobilePhone"
						onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
				</div>
				<div class="form-input-check" id="telCheck"></div>
				<input type="button" value="다음" id="btnSendEmail" class="nextButton" />
				<!-- <input type="submit" value="다음" /> -->
				<!-- 이후에 바로 이메일 인증받는 페이지로 이동 -->
				<br><br><br>&nbsp;
			</div>
			</div>
		</div>
	</form>

	<!-- 회원가입 2단계 ( 이메일 인증 )  -->
	<div id="modalEmailCheck" class="modal">
		<span id="emailCheckBack" class="back">&lt;</span> <span
			id="emailCheckClose" class="close">&times;</span>
		<div class="modal-popup">
			<div class="modalWrap">
				<br><br><br>
				<h1>이메일 인증</h1>
				<hr>
				<!-- 이메일 인증 input -->
				<div id="toEmail"></div>
				<div class="emailCheckWrap">
				<input type="text" id="inputCode" /> <input type="button"
					value="재요청" id="rerequest" class="nextButton reEmail"/>
					</div>
				<!-- 이메일 인증번호 input -->
				<input type="hidden" id="authenticationCode" /><input type="button"
					value="완료" id="completeSignUp" class="nextButton compEmail" />
					<br><br><br>&nbsp;
			</div>
		</div>
	</div>

	<!-- 임시비밀번호 modal -->
	<div id="makeshiftPasswordModal" class="modal">
		<span id="makeshiftPasswordBack" class="back">&lt;</span> <span
			id="makeshiftPasswordClose" class="close">&times;</span>
		<div class="modal-popup">
		<div class="modalWrap">
		<br><br><br>
			<h1>임시 비밀번호 발급</h1>
			<hr>
			<br>
			<div class="makeshift-password-input-wrap">
				<div class="makeshift-password-input-block">
					<div class="makeshift-password-input-title">이메일</div>
					<div class="makeshift-password-input-value">
						<input type="text" id="makeshiftInputEmail" />
					</div>
				</div>
				<br>
				<div id="temporaryPasswordButtonBlock">
					<button id="sendTemporaryPassword" class="nextButton"
						onclick='sendTemporaryPassword()'>요청</button>
				</div>
				<div class="makeshift-password-input-error"></div>


				<div id="temporaryPasswordInputBlock">
					<div class="makeshift-password-input-title">비밀번호</div>
					<div class="makeshift-password-input-value">
						<input type="hidden" id="temporaryPassword" /> <input
							type="password" id="inputTemporaryPassword" />
					</div>
					<div>
					<br>
						<button onclick='temporaryLogIn()' class="loginButtons login">로그인</button>
					</div>
				</div>
				</div>
				<br><br><br>&nbsp;
			</div>
		</div>
	</div>
	
	<!-- ajax 로딩 -->
	<div class="ajax-loading">
		<img id="loadingBarImg" src="/p5/img/loading.gif" alt="" />
	</div>



</body>
<script>

// ajax loading
$(document).ready(function(){
	$(document).ajaxStart(function() {
		$('.ajax-loading').show();
	});
	$(document).ajaxStop(function() {
		$('.ajax-loading').fadeOut();
	})
	
}); 



	var flag = true; // 날짜 출력 여부

	var date = new Date();
	var maxDate = new Date();

	var checkInDatecheckOutDate = '${checkInDatecheckOutDate}';

	var startDate = '${startDate}';
	var endDate = '${endDate}';

	maxDate.setMonth(date.getMonth() + 3);

	$(function() {
		$('#checkDate').daterangepicker(
				{
					"autoApply" : true,
					"minDate" : date,
					"maxDate" : maxDate
				},
				function(start, end, label) {

					var startDay = start.format("YYYY.MM.DD");
					var endDay = end.format("YYYY.MM.DD");

					// start 선택하고 end로 min 또는 자신 선택못함 
					if (startDay == endDay) {
						$('#checkDate').data('daterangepicker').setStartDate();
						$('#checkDate').data('daterangepicker').setEndDate();
						alert("호스트의 최소 숙박일 수가 1박 2일 부터 입니다.");

						flag = false;

					} else {
						flag = true;
					}

					if (checkInDatecheckOutDate == null
							|| checkInDatecheckOutDate == '') {
						$('#checkDate').val('');

					}

				});

		function parse(str) { // String -> Date 파싱
			var y = str.substr(0, 4);
			var m = str.substr(5, 2);
			var d = str.substr(8, 2);
			return new Date(y, m - 1, d);
		}
		var date1 = parse(startDate);
		var date2 = parse(endDate);
		console.log("start : " + date1);
		console.log("end : " + date2);

		if (checkInDatecheckOutDate != '' || checkInDatecheckOutDate != null) {
			$("#checkDate").val(checkInDatecheckOutDate);
		} else {
			$("#checkDate").val(''); // 초기 입력 없으면 '날짜 선택' 값 = null
		}

		if (startDate != '' && endDate != '') {

			$('#checkDate').data('daterangepicker').setStartDate(date1);
			$('#checkDate').data('daterangepicker').setEndDate(date2);
		}
	});

	function countDate() {
		if (!flag) {
			$("#checkDate").val('');
		}
	}

	$('#locationReset').click(function() {
		$('#address').val('');
	});

	$('#dateReset').click(function() {
		$('#checkDate').val('');
	});

	$('#guestCountReset').click(function() {
		$('#guestCount').val('');
	});

	$('#guestCount').click(function() {
		if ($('#guestCount').val() == '' || $('#guestCount').val() == null) {
			$('#guestCount').val(0);
		}
	});

	$('html').click(function(e) {
		var guestCount = $('#guestCount').val();
		if (!$(e.target).hasClass("guestCount_input") && guestCount == 0) { // 다른곳 클릭시  값이 부적절하면 리셋
			$('#guestCount').val('');
		}
	});

	$('html').click(function(e) {
		var guestCount = $('#guestCount').val();
		if (!$(e.target).hasClass("guestCount_input") && guestCount == 0) { // 다른곳 클릭시  값이 0이면 리셋
			$('#guestCount').val('');
		}
	});

	function checkValue() {

		if ($('#address').val() == '' || $('#address').val() == null) {

			$('#address').focus();
			return false;
		} else {
			return true;
		}

	}

	var address = '${address}';
	var guestCount = '${guestCount}';

	if (address != '') {
		$('#address').val(address);
	}

	if (guestCount != '') {
		$('#guestCount').val(guestCount);
	}

	//////인원수 
	$(function() {
		$('#decreaseQuantity').click(function(e) {
			e.preventDefault();

			if ($('#guestCount').val() != '') {
				var stat = $('.guestCount_input').val();
				var num = parseInt(stat, 10);
				num--;

				if (num < 0) {
					alert('더이상 줄일수 없습니다.');
					num = 0;
				}

				$('.guestCount_input').val(num);
			}

		}); /* click이벤트  */

		$('#increaseQuantity').click(function(e) {
			e.preventDefault();
			if ($('#guestCount').val() != '') {
				var stat = $('.guestCount_input').val();
				var num = parseInt(stat, 10);
				num++;

				$('.guestCount_input').val(num);
			} else {
				num = parseInt("1");
				$('.guestCount_input').val(num);
			}
		});
	});

	var width_size = $(window).width();
	var isURLmain = false;
	
	if (window.location.pathname == "/p5/") {
		isURLmain = true;
	}
	

	var mobileSwitch = false;
	var headerHeight = $('header').innerHeight();
	
	function headerSizeView() {
		headerHeight = $('header').innerHeight();
		if (window.location.pathname == "/p5/") {
			isURLmain = true;
		} else {
			isURLmain = false;
		}
		
		
		width_size = $(window).width();
		var height = $(document).scrollTop();
		
		var a = 607;
		var b = 843;
		
		if (isURLmain == true) {
			a = 607;
			b = 843;
		} else {
			a = 843;
			b = -100;				
		}
		
		if (height > headerHeight) { // 스크롤의 위치가 80보다  클경우(scroll)
			$('header').css({
				"position" : "fixed",
				"box-shadow" : "1px 1px 10px 0px #bbb",
				"opacity" : "0.97"
			});

			$('.fa-2x').css("font-size", "1em");
			$('.inputWrap').css("display", "contents");
			$('.title-logo-img ').css("height", "80px");

			$('#presentationTitle').css("padding-top", "120px");
			
			if (width_size <= a) {
				$('#headerMobileButton').css("display", "block");
				if(mobileSwitch = true) {
 					$('.title-logo-img ').css("height", "50px");
					$('.input-info').css("display", "none");
					$('.useradd-login-form').css("display", "none");

					$('.title-logo-img').css("display", "block");
					$('.useradd-login-form').css("display", "none");
					$('.fa-2x').css("font-size", "2em");
				} else {
					$('.input-info').css("display", "block");
					$('.useradd-login-form').css("display", "block");
					$('.title-logo-img ').css("height", "80px");
				}
			} else if (width_size <= b) {
				$('.title-logo-img ').css("height", "80px");
				$('#headerMobileButton').css("display", "none");
				$('.input-info').css("display", "block");
				$('.useradd-login-form').css("display", "block");

				$('.title-logo-img').css("display", "none");
				$('.useradd-login-form').css("display", "none");

			} else {
				$('.title-logo-img').css("display", "block");
				$('.useradd-login-form').css("display", "block");
				$('#headerMobileButton').css("display", "none");
			}

		} else { /// 80보다 낮은 위치라면(top)
			$("header").css({
				"position" : "static",
				"box-shadow" : "0px 0px"
			});
			$('.fa-2x').css("font-size", "2em");
			$('.inputWrap').css("display", "block");
			$('.title-logo-img').css("display", "block");

			$('#presentationTitle').css('padding-top', '0px');
			
			if (width_size <= a) {
				if(mobileSwitch = false) {
 					$('.title-logo-img ').css("height", "50px");
					$('#headerMobileButton').css("display", "block");
					$('.input-info').css("display", "none");
					$('.useradd-login-form').css("display", "none");

					$('.title-logo-img').css("display", "block");
					$('.useradd-login-form').css("display", "none");
				} /* else {
					$('.input-info').css("display", "block");
					$('.useradd-login-form').css("display", "block");
					$('.title-logo-img ').css("height", "80px");
				}
				*/
			
		} else {
			$('.title-logo-img ').css("height", "100px");
			$('.useradd-login-form').css("display", "block");
			$('.input-info').css("display", "block");
			$('#headerMobileButton').css("display", "none");
		}
	}
}
	
	$(window).resize(headerSizeView);
	$(window).scroll(headerSizeView);
	$(window).scroll(function() {
		mobileSwitch = false;
	});
	
	$('#headerMobileButton').click(function() {
		if (mobileSwitch == false) { /* 모바일 메뉴 버튼 off */
			$('.input-info').css("display", "block");
			$('.useradd-login-form').css("display", "block");
			$('.title-logo-img ').css("height", "80px");
			
			mobileSwitch = true;
		} else { /* 모바일 메뉴 버튼 on */
			$('.input-info').css("display", "none");
			$('.useradd-login-form').css("display", "none");
			$('.title-logo-img ').css("height", "50px");

			mobileSwitch = false;
		}
	})
	
	//==========================================================================
	//======================= 회원가입, 로그인, 로그아웃 =============================
	//==========================================================================

	//modal OFF
	function modalOff() {
		$('#modalLogin').css("display", "none");
		$('#modalUseradd').css("display", "none");
		$('#modalEmailCheck').css("display", "none");
		$('#makeshiftPasswordModal').css('display', 'none');
	}
	// 로그인 modal ON	
	function logInModalOn() {
		modalOff();
		$('.user-login-input-value').val("");
		$('.loginCheck').empty();
		$('#rememberMe').prop("checked", false);
		$('#modalLogin').css("display", "block");
		$('#userEmail').focus();
	}

	// 임시비밀번호 modal ON
	function makeshiftPasswordModalOn() {
		modalOff();
		$('#makeshiftInputEmail').val("");
		$('#makeshiftInputEmail').attr("readonly", false);
		$('#temporaryPasswordInputBlock').css("display", "none");
		$('#temporaryPasswordButtonBlock').css("display", "block");
		$('#makeshiftPasswordModal').css("display", "block");
		$('#makeshiftInputEmail').focus();
	}

	// 회원가입 modal ON
	function signUpModalOn() {
		modalOff();
		$('.input-value').val("");
		$('#modalUseradd').css("display", "block");
		$('#inputEmail').focus();
	}
	// 이메일인증 modal ON
	function emailAuthenticationModalOn() {
		modalOff();
		$('#toEmail')
				.text($('input[name="email"]').val() + "으로 인증번호가 전송되었습니다.");
		$('#inputCode').val("");
		$('#modalEmailCheck').css("display", "block");
		$('#inputCode').focus();
	}
	// 인증메일 발송
	function sendEmailAuthenticationCode(inputEmail) {
		$("#authenticationCode").val(""); // 인증번호 값을 초기화

		$.ajax({
			type : "POST",
			url : "/p5/ajax/sendEmailAuthenticationCode",
			data : "email=" + inputEmail,
			success : function(data) {
				if (!data) {
					alert("인증메일 발송에 실패했습니다.");
				} else {
					$("#authenticationCode").val(data); // 새로운 인증번호 값 적용
				}
			},
			error : function() {
				alert("통신 실패..");
			}
		});
	}

	/// 임시 비밀번호 이메일로 보내기
	function sendTemporaryPassword() { // 로딩이미지 들어가야됨
		var email = $('#makeshiftInputEmail');
		var reEmail = RegExp(/^[A-Za-z0-9]([-_\.]?[A-Za-z0-9])*@[A-Za-z0-9]([-_\.]?[A-Za-z0-9])*\.[A-Za-z]{2,3}$/i);
		if(!email.val().trim()){
			alert("이메일을 입력하세요.");
			email.val("");
			email.focus();
			return;
		}
		if(!reEmail.test(email.val())){
			alert("이메일을 확인해주세요.");
			email.focus();
			return;
		}
		
		$.ajax({
			type : "POST",
			url : "/p5/ajax/sendTemporaryPassword",
			data : 'userEmail=' + email.val(),
			/* async : false, */
			success : function(data) {
				if (!data) {
					alert("임시 비밀번호 발송에 실패했습니다.");
				} else {
					$('#makeshiftInputEmail').attr("readonly", true);
					$('#temporaryPasswordButtonBlock').css("display", "none");
					$('#temporaryPassword').val(data); // 임시비밀번호(해싱) 적용
					$('#inputTemporaryPassword').val("");
					$('#temporaryPasswordInputBlock').css("display", "block");
					$('#inputTemporaryPassword').focus();
				}
			},
			error : function() {
				alert("통신 실패..");
			}
		});
	}

	// 임시 로그인
	function temporaryLogIn() { // 로딩이미지 필요
		
		var inputTemporaryPassword = $('#inputTemporaryPassword');
		if(!inputTemporaryPassword.val()){
			alert("임시 비밀번호를 입력하세요.");
			inputTemporaryPassword.focus();
			return;
		}
		var params = {
			userEmail : $('#makeshiftInputEmail').val(),
			temporaryPassword : $('#temporaryPassword').val(),
			inputTemporaryPassword : inputTemporaryPassword.val()
		}

		$.ajax({
			type : "POST",
			url : "/p5/ajax/temporaryLogIn",
			data : params,
			async : false,
			success : function(data) {
				if (data) { // 입력한 임시 비밀번호가 올바르면;
					alert("임시비밀번호로 변경됐습니다.");
					alert("비밀번호를 변경해주세요.");
					location.href = "/p5/userInfoUpdate?t=1"; // 비밀번호 변경을 위해 마이페이지로 보냄
				} else { // 아니면
					alert("비밀번호가 일치하지 않습니다. 발급받은 임시비밀번호를 사용해주세요.");
					inputTemporaryPassword.focus();
				}
			},
			error : function() {
				alert("통신 실패..");
			}
		});
	}

	/// 호스트 등록을 눌렀을 때
	function isMobileAuthentication() {
		$
				.ajax({
					type : "POST",
					url : "/p5/ajax/isMobileAuthentication",
					async : false,
					success : function(data) {
						if (data) { // 휴대전화 인증자이면
							location.href = "/p5/host/hostingList";
						} else { // 아니면
							alert("휴대전화 인증 이후에 이용 가능한 서비스입니다.");
							////////// 팝업창
							var phoneURL = '/p5/phoneCertification';
							var phoneOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";
							window.open(phoneURL, "", phoneOption);
						}
					},
					error : function() {
						alert("통신 실패..");
					}
				});
	}

	// modal 닫기
	$('.close').on('click', modalOff);
	// '로그인' 클릭
	$('#login-btn').on('click', logInModalOn);
	// '이메일로 가입하기' 클릭
	$('#emailUserAdd').on('click', signUpModalOn);
	// '회원가입' 클릭
	$('#useradd-btn').on('click', signUpModalOn);
	// '임시비밀번호' 클릭
	$('#makeshiftPasswordBtn').on('click', makeshiftPasswordModalOn);

	// 회원가입 modal에서 '다음' 클릭
	$('#btnSendEmail').on(
			'click',
			function() {
			
			 	var email = $('input[name="email"]').val();
				var password = $('input[name="password"]').val();
				var passwordCheck = $('input[name="passwordCheck"]').val();
				var firstName = $('input[name="firstName"]').val();
				var lastName = $('input[name="lastName"]').val();
				var birthDate = $('input[name="birthDate"]').val();
				var mobilePhone = $('input[name="mobilePhone"]').val(); 
				
				var reEmail = RegExp(/^[A-Za-z0-9]([-_\.]?[A-Za-z0-9])*@[A-Za-z0-9]([-_\.]?[A-Za-z0-9])*\.[A-Za-z]{2,3}$/i);
				var rePassword = RegExp(/^[A-Za-z0-9~!@#$%^&*()_+|<>?:{}]{8,16}$/);
				var reFirstName = RegExp(/^[가-힣]{1,20}$|^[A-Za-z]{1,60}$/);
				var reLastName = RegExp(/^[가-힣]{1,10}$|^[A-Za-z]{1,30}$/);
				var reMobilePhone = RegExp(/^01[016789]([1-9][0-9]{2,3})([0-9]{4})$/);
				
			//	alert(email+"\n"+password+"\n"+passwordCheck+"\n"+firstName+"\n"+lastName+"\n"+birthDate+"\n"+mobilePhone);
//============================ 이메일 유효성 ===============================				
				if(!email.trim()){
					alert("이메일을 입력하세요.");
					$('input[name="email"]').val("");
					$('input[name="email"]').focus();
					return;
				}
				if(!reEmail.test(email)){
					alert("이메일을 확인해주세요.");
					$('input[name="email"]').focus();
					return;
				}
				var isEmailAvailable;
				$.ajax({
					type : "POST",
					url : "/p5/ajax/isEmailAvailable",
					data : "email=" + email,
					async : false, // 동기
					success : function(result) {
						isEmailAvailable = result; // 결과를 담는다
					},
					error : function() {
						alert("이메일 중복확인 통신 실패..");
					}
				}); // ajax-end 	
				if(!isEmailAvailable){ // 이미 사용중이면
					alert("이미 사용중인 이메일입니다.");
					$('input[name="email"]').focus();
					return;
				}
//==========================================================================
	
//============================ 비밀번호 유효성 ===============================		
				if(!password){
					alert("비밀번호를 입력하세요.");
					$('input[name="password"]').focus();
					return;
				}
				if(!rePassword.test(password)){
					alert("비밀번호는 8~16자리의 영문, 숫자, 특수문자만 사용 가능합니다.\n사용가능 특수문자 :\n~!@#$%^&*()_+|<>?:{}");
					$('input[name="password"]').focus();
					return;
				}
				if(password !== passwordCheck){
					alert("비밀번호가 일치하지 않습니다.");
					$('input[name="passwordCheck"]').focus();
					return;
				}
//============================================================================	
	
//============================ 이름, 성, 생년월일 유효성 ===============================
				if(!firstName.trim()){
					alert("이름을 입력해주세요.");
					$('input[name="firstName"]').val("");
					$('input[name="firstName"]').focus();
					return;
				}
				if(!reFirstName.test(firstName)){
					alert("이름은 한글 20자, 또는 영문60자 이하로 입력해주세요.");
					$('input[name="firstName"]').focus();
					return;
				}
				if(!lastName.trim()){
					alert("성을 입력해주세요.");
					$('input[name="lastName"]').val("");
					$('input[name="lastName"]').focus();
					return;
				}
				if(!reLastName.test(lastName)){
					alert("성은 한글 10자, 또는 영문30자 이하로 입력해주세요.");
					$('input[name="lastName"]').focus();
					return;
				}
				if(!birthDate){
					alert("생년월일을 입력해주세요.");
					$('input[name="birthDate"]').focus();
					return;
				}
//===========================================================================			
				
//=========================== 휴대전화 유효성 ===============================
				if(!mobilePhone){
					alert("휴대전화번호를 입력해주세요.");
					$('input[name="mobilePhone"]').focus();
					return;
				}
				if(!reMobilePhone.test(mobilePhone)){
					alert("휴대전화번호를 확인해주세요.");
					$('input[name="mobilePhone"]').focus();
					return;
				}
//===========================================================================		
				
			//	alert("모든 유효성 통과^^!");
	
				sendEmailAuthenticationCode(email); // 인증메일 발송
				emailAuthenticationModalOn(); // 화면 전환
			});
	
	
	

	// 이메일 인증에서 뒤로가기
	$('#emailCheckBack').on('click', function() {
		modalOff();
		// 비밀번호 관련 input만 초기화
		$('#inputPassword').val("");
		$('#inputPasswordCheck').val("");
		$('#modalUseradd').css("display", "block");
		$('#inputPassword').focus();
	});
	// 임시비밀번호에서 뒤로가기
	$('#makeshiftPasswordBack').on('click', function() {
		modalOff();
		$('.user-login-input-value').val("");
		$('.loginCheck').empty();
		$('#rememberMe').prop("checked", false);
		$('#modalLogin').css("display", "block");
		$('#userEmail').focus();
	});

	// 인증메일 재요청
	$("#rerequest").on("click", function() {
		var inputEmail = $('#inputEmail').val();

		sendEmailAuthenticationCode(inputEmail); // 인증메일 발송
		alert("인증번호를 재전송합니다. 새로운 인증번호만 유효합니다.");
	});

	// '(회원가입)완료' 클릭
	$("#completeSignUp").on("click", function() { // 로딩이미지 필요
		if(!$('#inputCode').val().trim()){
			alert("인증번호를 입력해주세요.");
			$('#inputCode').val("");
			$('#inputCode').focus();
			return;
		}
		var params = {
			authenticationCode : $('#authenticationCode').val(), // 인증번호(해시)
			inputCode : $('#inputCode').val().trim()
		// 입력값
		};
		var paramsNewMember = $('form[name="newMember"]').serialize(); // 방금 입력한 회원정보
		
		$.ajax({
			type : "POST",
			url : "/p5/ajax/emailAuthentication",
			data : params,
			async : false,
			success : function(result) {
				if (result) { // 인증번호 일치(통과)

					$.ajax({
						type : "POST",
						url : "/p5/ajax/completeSignUp",
						data : paramsNewMember,
				//		async : false,
						success : function(result) {
							if (result) { // DB에 저장 성공 

								alert("회원가입을 완료했습니다.");
								logInModalOn(); // 로그인 modal 전환

							} else { // DB에 저장 실패
								alert("회원가입에 실패했습니다. 다시 시도해주세요.");
							}
						},
						error : function() {
							alert("통신 실패..");
						}
					});

				} else { // 인증번호 불일치
					alert("인증번호가 일치하지 않습니다.");
					$('#inputCode').focus();
				}
			},
			error : function() {
				alert("통신 실패..");
			}
		});
	});

	// 로그인 시도
	function userLogin() { // 로딩이미지 필요
		var email = $('#userEmail').val();
		if(!email.trim()){
			$('.loginCheck').empty();
			$('.loginCheck').css({
				"color" : "red"
			});
			$('.loginCheck').append('아이디를 입력하세요.');
			$('#userEmail').val("");
			$('#userEmail').focus();
			return false;
		}
		
		var params = {
			userEmail : email,
			userPassword : $('#userPassword').val(),
			rememberMe : $('#rememberMe').prop("checked")
		};
		
		$.ajax({
			type : "POST",
			url : "/p5/ajax/logIn",
			data : params,
			success : function(result) {
				if (result == 0) { // 존재하지 않는 ID
				
					$('.loginCheck').empty();

					$('.loginCheck').css({
						"color" : "red"
					});

					$('.loginCheck').append('아이디가 존재하지 않습니다.');
					$('#userEmail').focus();

				} else if (result == 1) { // 비밀번호 불일치

					$('.loginCheck').empty();

					$('.loginCheck').css({
						"color" : "red"
					});
					
					$('.loginCheck').append('비밀번호가 일치하지 않습니다.');
					$('#userPassword').focus();

				} else if (result == 2) { // 로그인 성공

					/* alert("로그인 성공"); */
					location.reload();

				}
			},
			error : function() {
				alert("통신 실패..");
			}
		});

		return false; //submit은 동작하지 않게
	}

	//// 카카오톡으로 가입하기 버튼을 눌렀을 때 처리.

	// '로그아웃' 클릭
	$('#btnLogOut').on('click', function() {
		$.ajax({
			type : "POST",
			url : "/p5/ajax/logOut",
			async : false,
			success : function() {

				alert("로그아웃되었습니다.");
				/* 	location.reload(); // 페이지 새로 고침 */
				location.href = "/p5/";

			},
			error : function() {
				alert("통신 실패..");
			}
		});
	});

	
</script>

</html>