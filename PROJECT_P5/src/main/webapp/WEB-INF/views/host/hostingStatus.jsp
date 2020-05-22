<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호스팅 등록상황</title>
<script src="/p5/js/jquery-3.4.1.js"></script>
<style>
#wrap {
	width: 100%;
	max-width: 1100px;
	margin: auto;
}

/* 숙소 상태를 총괄 */
.hosting-status {
	display: grid;
	grid-template-columns: 60% 40%;
	margin: 30px 0px;
	height: 800px;
}

/* 숙소상태페이지 타이틀 */
.hosting-status-title {
	font-size: 30px;
	margin: 30px 0px;
}

/* 숙소상태 단계별 block */
.hosting-status-block {
	margin: 10px;
	padding: 20px;
	border-bottom: 0.5px solid #bbb;
}

/* 단계별 표시 */
.hosting-status-step {
	font-size: 15px;
	font-weight: bold;
	color: #aaa;
	margin: 5px;
}

.hosting-status-description {
	margin-bottom: 10px;
}

/* 숙소 등록시 보여줄 멘트 */
.hosting-status-register {
	font-size: 30px;
    margin: 20px 0px;
}

/* 숙소수정관련 이미지 */
.hosting-status-img {
	background: #bbb;
	height: 700px;
}

/* 숙소 변경,계속 버튼 */
.modify-btn, .continue-btn {
	text-decoration: none;
	color: #E51E51;
}

.modify-btn:visited, .continue-btn:visited {
	color: #E51E51;
}

/* 변경버튼에 마우스를 올렸을 때 */
.modify-btn:hover {
	text-decoration: underline;
}

/* 계속 버튼 */
.continue-btn {
	width: 60px;
	height: 36px;
	background: #E51E51;
	color: white !important;
	font-size: 14px;
	font-weight: bold;
	padding: 6px 15px;
	border-radius: 5px;
}

#hostingStatusImg {
	width:100%;
	height:100%;
	object-fit: fill;
    object-position: center;
}
</style>

<!-- viewport  -->
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
</head>
<body>
	<%@include file="../header.jsp" %>
	
	<input type="hidden" id="hostId" value="${hostId }" />
	<div id="wrap">
	
		<!-- hosting status를 관리  -->
		<div class="hosting-status">
			<!-- 숙소상태,수정  -->
			<div class="hosting-status-main">

				<div class="hosting-status-title"></div>

				<div class="hosting-status-block">
					<div class="hosting-status-step">1단계</div>
					<div class="hosting-status-description">숙소형태,인원,위치,편의시설</div>
					<div>
						<a class="modify-btn" href="modification/roomType?hostId=${hostId }">변경</a>
					</div>
				</div>

				<div class="hosting-status-block">
					<div class="hosting-status-step">2단계</div>
					<div class="hosting-status-description">사진등록,숙소명,숙소설명</div>

					<div id="registerStep2">
						<div class="hosting-status-register">상세정보를 제공해 주세요.</div>
						<a class="continue-btn" href="registration/photo?hostId=${hostId }">계속</a>
					</div>
					<div id="modifyStep2">
						<a class="modify-btn" href="modification/photo?hostId=${hostId }">변경</a>
					</div>

				</div>
				<div class="hosting-status-block">
					<div class="hosting-status-step">3단계</div>
					<div class="hosting-status-description">숙박일,예약불가날짜,금액</div>

					<div id="registerStep3">
						<div class="hosting-status-register">게스트를 맞이할 준비를 하세요.</div>
						<a class="continue-btn" href="registration/stayDate?hostId=${hostId }">계속</a>
					</div>
					<div id="modifyStep3">
						<a class="modify-btn" href="modification/stayDate?hostId=${hostId }">변경</a>
					</div>
				</div>
			</div>

			<!-- 숙소 옆 빈공간 (이미지가 들어갈 자리) -->
			<div class="hosting-status-img">
				<img id="hostingStatusImg" src="/p5/img/hostingStatus.jpg" alt="" />
			</div>

		</div>

	</div>

	
	<script>
	
		$(window).bind("pageshow", function(event) {

			$.ajax({
				type : "POST",
				url : "/p5/ajax/isIdentified",
				data : "hostId=" + $('#hostId').val(),
				success : function(result) {
					if (!result) {
						alert("접근 권한이 없는 페이지입니다.");
						location.replace("/p5"); // 홈으로 이동
						return;
					}
					// 접근 권한 통과하면 화면 갱신 수행
					refresh();

				},
				error : function() {
					alert("로그아웃 되신 듯..");
					location.replace("/p5"); // 홈으로 이동
				}
			}); // AJAX-END

			$.ajax({ // 1단계 등록완료하고 세션 초기화
				type : "POST",
				url : "registration/reset",
			}); // AJAX-END
		});

		function refresh() {

			$.ajax({
				type : "POST",
				url : "hostingStatus/getHost",
				data : "hostId=" + $('#hostId').val(),
				success : function(host) {
					//	alert(JSON.stringify(host)); // 내용 확인
					$('.hosting-status-title').text('오류가 발생했어요'); 
					if (!host.name) { // step2 미완료
						
						
						
						$('#modifyStep2').remove(); // step2 변경 X
						$('#registerStep3').remove(); // step3 계속 X
						$('#modifyStep3').remove(); // step3 변경 X
						$('.hosting-status-title').text('숙소등록을 계속 진행해볼까요?');
						return;
					}
					if (!host.creationDate) { // step3 미완료
						$('#registerStep2').remove(); // step2 계속 X
						$('#modifyStep3').remove(); // step3 변경 X
						$('.hosting-status-title').text('이제 마지막 단계입니다!');
						return;
					}
					// step3 완료(등록 완료된 호스트 수정시 화면)
					$('#registerStep2').remove(); // step2 계속 X
					$('#registerStep3').remove(); // step3 계속 X
					$('.hosting-status-title').text('최신 상태를 유지하세요!');
					
				},
				error : function() {
					alert("호스팅 상태 보기 실패..");
				}
			}); // AJAX-END

		}
	</script>
	
	<jsp:include page="../footer.jsp"/>
</body>
</html>