<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>숙소등록 완료</title>

<style>

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
#wrap {
	width: 100%;
	max-width: 1100px;
	margin: auto;
}

.finish {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
}

.finish-block {
	margin-top: 35px;
}

.finish-value-block {
	margin-top: 30px;
}

/* 이미지 */
.finish-img-value {
	padding: 0px 100px;
}

#finishTitleImg {
	width: 500px;
	height: 700px;
	object-fit: contain;
	object-position: center;
}

.finish-btn-group {
	margin: 100px 0px;
    display: flex;
    justify-content: space-between;
}

.modification {
	text-decoration: underline;
	color: #008489;
	font-size: 20px;
	background: white;
	border: none;
}

.home {
	border: 1px solid white;
	box-sizing: border-box;
	background: #E51E51;
	color: white;
	font-size: 15px;
	width: 100px;
	height: 40px;
}

.text {
	font-size: 15px;
	margin: 20px 0px;
}
/* .tip {

} */
.finish-img {
	width: 100px;
	height: 300px;
}
</style>
</head>
<body>
	<input type="hidden" value="${hostId }" />

	<div id="wrap">

		<div class="finish">
			<div class="finish-block">
				<h1>숙소등록이 성공적으로 끝마쳤습니다!</h1>
				<div class="finish">모두 완료되었습니다 메인페이지로 이동하기전에 다음사항을 참고하세요</div>

				<div class="finish-value-block">
					<div class="tip">
						<div class="info">
							<img src="/p5/img/finish-info2.png" alt=""
								class="finish-img-value" />
							<div class="text">달력과 요금설정이 올바른지 확인하세요</div>
						</div>
						<div class="precautions">
							<img src="/p5/img/finish-info.png" alt=""
								class="finish-img-value" />
							<div class="text">호스트 ,프로필 사진 등록이 안되었을 경우 검색페이지에 노출되지 않습니다.</div>
						</div>
					</div>
					<div class="finish-btn-group">
						<button class="home">
							<i class="fa fa-home fa-2x" aria-hidden="true"></i>홈으로
						</button>
						<button class="modification">수정 페이지로</button>
					</div>
					<br /> <br /> <br />
					<div>${newHost }</div>
					<!-- 숙소 옆 빈공간 (이미지가 들어갈 자리) -->
				</div>
			</div>


			<div class="finish-img-cover">
				<img id="finishTitleImg" src="/p5/img/hostingStatus.jpg" alt="" />
			</div>

		</div>

	</div>
</body>
<script>
	$(function() {
		$('.home').click(function(e) {

			location.href = "../../";
		});
		$('.modification').click(function(e) {
			location.href = "../hostingStatus?hostId=${hostId }";
		});

	});
</script>
</html>