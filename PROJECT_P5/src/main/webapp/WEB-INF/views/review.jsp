<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>

<link rel="stylesheet" href="css/reset.css" />
<style type="text/css">

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

#wrap {
	width: 100%;
	max-width: 600px;
}

#wrap hr {
	margin: 0;
    border: 2px outset rgba(255,255,255,0.5); 
}

.review {
	text-align: center;
}

.reviewTitle {
	margin: 20px 0;
	font-size: 20px;
	font-weight: bolder;
}

.reservNumber {
	font-size: 80%;
	margin-bottom: 7px;
}

.reservInfo {
	width: 100%;
	margin: 0px auto 10px;
	height: 130px;
}

.reservInfo img {
	height: 50px;
	vertical-align: middle;
}

.reservInfo th {
	background: #ed2d55;
	color: white;
}

.reservInfo tr {
	border: 1px solid black;
	background: #eee;
}

.reservInfo th, tr, td {
	vertical-align: middle;
}

.reservInfo td:nth-child(4) {
	padding-right: 20px;
}
.reservInfo td:first-child {
	width: 15%;
	padding-left: 20px;
}

.reservInfo td:nth-child(3), td:nth-child(4) {
	width: 20%;
	font-size: 85%;
}

.comment textarea {
	width: 80%;
    height: 100px;
    BACKGROUND: #eee;
    border: none;
    resize: none;
    padding: 20px;
    box-sizing: border-box;
}

/* 별점 */
.star {
	display: inline-block;
	width: 15px;
	height: 30px;
	cursor: pointer;
}

.starBox {
	font-family: none;
}

.starLeft {
	background: url(img/star2.png) no-repeat 0 0;
	background-size: 30px;
	margin-right: -3px;
}

.starRight {
	background: url(img/star2.png) no-repeat -15px 0;
	background-size: 30px;
	margin-left: -3px;
}

.star.on {
	background-image: url(img/star1.png);
}

#commentUpButton {
    width: 25%;
    height: 30px;
    border: none;
    border-radius: 10px;
    background: #ed2d55;
    color: white;
}

</style>
</head>
<body>
	<div id="wrap">
		<div class="review">
			<div class="reviewTitle">숙소 이용은 어떠셨나요?</div>
			<hr>
			<table class="reservInfo">
				<tr>
				<th colspan="2">
				숙소 이름</th>
				<th>체크인</th>
				<th>체크아웃</th>
				</tr>
				<tr>
					<td><img src="${hostPhotoPath}" alt="${hostPhotoName}"/></td>
					<td><div class="reservNumber">[예약번호:${bookingId}]</div>
					${hostName}</td>
					<td>${checkInDate}</td>
					<td>${checkOutDate}</td>
				</tr>
			</table>
			<br>
			<div class="starBox">
				<span class="star starLeft"></span> <span class="star starRight"></span>
				<span class="star starLeft"></span> <span class="star starRight"></span>
				<span class="star starLeft"></span> <span class="star starRight"></span>
				<span class="star starLeft"></span> <span class="star starRight"></span>
				<span class="star starLeft"></span> <span class="star starRight"></span>
				<span class="starNumber" id="starNum">0</span>
			</div>
			<br>
			<div class="comment">
				<textarea id="commentReview" placeholder="후기를 입력해주세요."></textarea>
				<br> <br>
			</div>
			<input type="button" value="등록" id="commentUpButton"
				onclick="commentUp()" />
				<br>
		</div>
	</div>
</body>

<script type="text/javascript">
	/* 후기 등록 */
	function commentUp() {
		
		var userId = "${user.id}";
		var bookingId = "${bookingId}";
		var rate = $("#starNum").text();
		var commentReview = $("#commentReview").val();
		
		//alert(rate);
		//alert(commentReview);
		
		alert("후기가 등록되었습니다.");
		
		/*jQuery form 전송 방식*/
		// create element(form)
		var newForm = $('<form><form>');
		
		// set attribute(form)
		newForm.attr("name","newForm");
		newForm.attr("method","POST");
		newForm.attr("action","registReview");
		newForm.attr("target","_self");
		
		// create element & set attribute (input)
		newForm.append($('<input/>', {type: 'hidden', name: 'memberId', value: userId}));
		newForm.append($('<input/>', {type: 'hidden', name: 'bookingId', value: bookingId}));
		newForm.append($('<input/>', {type: 'hidden', name: 'rate', value: rate}));
		newForm.append($('<input/>', {type: 'hidden', name: 'commentReview', value: commentReview}));
	
		// append form(to body)	
		newForm.appendTo('body');
		
		// submit form
		newForm.submit();
		
		window.close();
	}

	/* 별점 */
	
	var printIdx = 0;
	
	$(".star").on('mouseover', function() {
		var idx = $(this).index();
		$(".star").removeClass("on");
		for (var i = 0; i <= idx; i++) {
			$(".star").eq(i).addClass("on");
		}
	});
	
	$(".starBox").on('mouseleave', function() {
		idx = printIdx*2;
		$(".star").removeClass("on");
		for (var i = 0; i < idx; i++) {
			$(".star").eq(i).addClass("on");
		}
	});
	
	$(".star").on('click', function() {
		var idx = $(this).index();
		$(".star").removeClass("on");
		for (var i = 0; i <= idx; i++) {
			$(".star").eq(i).addClass("on");
		}
		printIdx = idx + 0.5;
		if (printIdx >= 1)
			printIdx = (idx / 2) + 0.5;

		$(".starNumber").html(parseFloat(printIdx));
	});
</script>
</html>