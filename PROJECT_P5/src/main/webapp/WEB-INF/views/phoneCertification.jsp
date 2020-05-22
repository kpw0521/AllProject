<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴대폰 인증</title>
<style>
/* 네이버 나눔 바른고딕 */
@font-face {
	font-family: 'NanumBarunGothic';
	font-style: normal;
	font-weight: 400;
	src:
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
	src:
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix')
		format('embedded-opentype'),
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff')
		format('woff'),
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf')
		format('truetype');
}

@font-face {
	font-family: 'NanumBarunGothic';
	font-style: normal;
	font-weight: 700;
	src:
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.eot');
	src:
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.eot?#iefix')
		format('embedded-opentype'),
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.woff')
		format('woff'),
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebBold.ttf')
		format('truetype')
}

@font-face {
	font-family: 'NanumBarunGothic';
	font-style: normal;
	font-weight: 300;
	src:
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.eot');
	src:
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.eot?#iefix')
		format('embedded-opentype'),
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.woff')
		format('woff'),
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWebLight.ttf')
		format('truetype');
}

.nanumbarungothic * {
	font-family: 'NanumBarunGothic', sans-serif;
}

* {
	font-family: NanumBarunGothic;
	/* transition: 0.5s; */
}

#phoneCetificationNumberInputBlock {
	display: none;
	margin-top: 20px !important;
}

#wrap {
	width: 100%;
	margin: auto;
}

.phone-logo {
	border: 1px solid #E51E51;
	margin: auto;
	text-align: center;
	box-sizing: border-box;
}

#logoImg {
	width: 50px;
	height: 50px;
	object-fit: contain;
	object-position: center;
}

.phone-block {
	margin: 20px auto;
	width: 80%;
	border: 1px solid;
	height: 400px;
	box-sizing: border-box;
	padding: 10px;
	text-align: center;
	
}

.phone-value-block {
	margin: 20px auto;
	font-size: 18px;
	vertical-align: middle;
	display: inline-block;
	width: 100%;
}

input[type=text] {
	width: 60%;
	height: 30px;
	margin: 10px;
	min-width: 200px;
	padding: 5px;
	font-size: 15px;
	font-family: inherit;
	border: 0.5px solid;
}

input[type=text]:disabled {
	background: white;
	outline: none;
	border: 0.5px solid;
}

button {
	width: 100px;
	height: 44px;
	font-size: 15px;
	font-family: inherit;
	padding: 5px;
	background: white;
	outline: none;
	text-decoration: none;
	border: 1px solid #E51E51;
	border-radius: 10px;
}

button:disabled {
	border: 1px solid #bbb;
}

.phone-value-title {
	font-weight: bold;
}
/* 
.phone-block span {
    display: block;
    box-sizing: border-box;
    position: absolute;
    width: 78%;
    height: 400px;
    left: 50px;;
}

.phone-block span:nth-child(1) {
	transform: rotate(0deg);
}

.phone-block span:nth-child(2) {
	transform: rotate(90deg);
}

.phone-block span:nth-child(3) {
	transform: rotate(180deg);
}

.phone-block span:nth-child(4) {
	transform: rotate(270deg);
}

.phone-block span:before {
	content: '';
	position: absolute;
	width: 100%;
	height: 2px;
	background: #E51E51;
	animation: animate 4s linear infinite;
}

@keyframes animate { 
	0% {
		transform: scaleX(0);
		transform-origin: left;
	}

	50% {
		transform:scaleX(1);
		transform-origin:left;
	}
	
	50.1 % {
		transform: scaleX(1);
		transform-origin: right;
	}

	100%{
		transform:scaleX(0);	  
		transform-origin:right;
	}
	 */
</style>


<link rel="stylesheet" href="/p5/css/reset.css" />
</head>

<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<body onload="window.focus();">

	<div id="wrap">
		<div class="phone-logo">
			<img src="/p5/img/p5_logo.png" alt="" id="logoImg" />
		</div>
		
		
			<div class="phone-block">
			<span></span> <span></span> <span></span> <span></span>
				<h1>휴대폰 인증</h1>

				<div class="phone-value-block">
					<div class="phone-value-title">전화번호</div>
					<div class="phone-value">
						<input type="text" id="phoneInput" name=mobileNumber value="${user.mobilePhone }" />
						<button id="phoneCetificationNumberBtn" onclick='sendCerificationNumberMail()'>인증하기</button>
					</div>
					<div id="phoneError"></div>
					<input type="hidden" id="phoneCheck" value="y" />
				</div>


				<div id="phoneCetificationNumberInputBlock">
					<div class="phone-value-block">
						<div class="phone-value-title">인증번호</div>
						<div class="phone-value">
							<input type="text" id="mobileInputCode" /> 
							<input type="hidden" id="mobileAuthenticationCode" />
							<button onclick='completeMobileAuthentication()'>완료</button>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>


	<script>
		$(document).ready(function() {
			//	var parentUrl = window.opener.document.URL;
			//	alert(parentUrl);
		})

		// 전화번호 유효성 
		var phoneInput = $('#phoneInput'); // 전화번호 입력 
		var phoneCheck = $('#phoneCheck'); // 유효성 검사 결과값 
		var phoneError = $('#phoneError'); // 유효성 검사 결과 text

		phoneInput
				.blur(function() {

					var checkPhone = RegExp(/^01[016789]-?([0-9][0-9]{2,3})-?([0-9]{4})$/);// 전화번호 유효성

					if (phoneInput.val() == '' || phoneInput.val() == null) { // 전화번호 입력값이 null
						phoneError.text('전화번호를 입력해주세요.');
						phoneCheck.val('n');
					} else {// 전화번호 값이 입력이 되었을 때		
						/* alert('입력된 전화번호: '+ phoneInput.val()); */
						if (checkPhone.test(phoneInput.val())) { //전화번호가 유효성을 통과했을 때
							var replace = phoneInput.val().replace(/\-/g, '');
							phoneInput.val(replace);
							phoneError.text('사용가능합니다. 인증하기를 눌러주세요.');
							phoneCheck.val('y');

						} else {
							phoneError.text('번호만 입력해주세요.');
							phoneCheck.val('n');
						}

					}

				});

		function sendCerificationNumberMail() {
			// 전화번호 인증이 통과되었을 때
			if (phoneCheck.val() == 'y') {

				$.ajax({
					type : "POST",
					url : "ajax/sendMobileAuthenticationCode",
					data : 'mobileNumber='
							+ $('input[name=mobileNumber]').val(),
					success : function(data) {
						if (!data) {
							alert("인증문자 발송에 실패했습니다.");
						} else {
							$("#mobileAuthenticationCode").val(data); // 새로운 인증번호 값 적용
							$('#phoneCetificationNumberInputBlock').css(
									"display", "block");
							$('#phoneCetificationNumberBtn').attr('disabled',
									true);
							$('input[name=mobileNumber]')
									.attr('disabled', true);
						}
					},
					error : function() {
						alert("통신 실패..");
					}
				});
			} else {
				alert('전화번호를 확인해주세요.')
			}
		}

		function completeMobileAuthentication() {
			var params = {
				mobilePhone : $('input[name=mobileNumber]').val(),
				inputCode : $('#mobileInputCode').val(),
				authenticationCode : $('#mobileAuthenticationCode').val()
			}

			$.ajax({
				type : "POST",
				url : "ajax/completeMobileAuthentication",
				data : params,
				success : function(result) {
					if (result == 0) { // 인증번호 불일치
						alert("인증번호가 일치하지 않습니다.");
					} else if (result == 1) { // 인증번호 일치 , DB에 저장 성공
						alert("휴대전화 인증을 완료했습니다.");

						/* **
						 ** 부모창이 회원정보 페이지면 새로고침
						 ** */
						var parentUrl = window.opener.document.URL;
						var start = parentUrl.indexOf("/p5");
						var end = parentUrl.length;
						var urlInfo = parentUrl.substring(start, end);
						if (urlInfo.indexOf('/p5/userInfoUpdate') !== -1) {
							window.opener.location.reload(); // 부모창 새로고침
						}
						window.close(); // 팝업창 닫기
					} else if (result == 2) { // 인증번호 일치, DB에 적용 실패
						alert("휴대전화 인증을 정상적으로 완료하지 못했습니다.");
					}
				},
				error : function() {
					alert("통신 실패..");
				}
			});
		}
	</script>
</body>
</html>