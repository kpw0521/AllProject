<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인원</title>
<link rel="stylesheet" href="/p5/css/roomCount.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
.registration, .modification {
	display: none;
}
</style>
</head>
<body>
	<input type="hidden" id="hostId" value="${hostId }" />

	<%@include file="./hostHeaderStep1.jsp"%>

	<!-- 등록과 수정시에 처리될 script -->
	<script>
		$('#progressBar').val('30');
		$('#tabRoomCount').css('background', '#bbb');
	</script>
	
	<div id="wrap">
		<div id="container">
			<h1>숙소에 얼마나 많은인원이 숙박할 수 있나요?</h1>
			<h4>모든게스트가 편안하게 숙박할 수 있도록 침대가 충분히 구비되어 있는지 확인하세요.</h4>
			최대 숙박인원 <br> <input type="text" name="capacity"
				class="maximum-stay" readonly="readonly" value="1" />
			<button id="maximum-increase-quantity"></button>
			<button id="maximum-decrease-quantity"></button>
			<br> 방 갯수를 입력해볼까요? <br>
			<input type="text" name="roomCount" class="room-count"
				readonly="readonly" value="1" />
			<button id="count-increase-quantity"></button>
			<button id="count-decrease-quantity"></button>
			<br> 게스트가 사용할 수 있는 침대가 몇 개 인가요?<br> <input type="text"
				name="bedCount" class="bed-count" readonly="readonly" value="0" />
			<button id="bed-increase-quantity"></button>
			<button id="bed-decrease-quantity"></button>
			<br> 게스트가 사용할 수 있는 욕실은요?<br> <input type="text"
				name="bathroomCount" name="bathroomCount" class="bathroom-count"
				readonly="readonly" value="1" />
			<button id="bathroom-increase-quantity"></button>
			<button id="bathroom-decrease-quantity"></button>
			
			
			<script>
				/*최대 숙박인원  */
				$(function() {
					$('#maximum-decrease-quantity').click(function(e) {
						e.preventDefault();
						var stat = $('.maximum-stay').val();
						var num = parseInt(stat, 10);
						num--;
						if (num <= 0) {
							/* 	alert("더이상 줄일수 없습니다") */
							num = 1;

						}
						$('.maximum-stay').val(num);
					});
					$('#maximum-increase-quantity').click(function(e) {
						e.preventDefault();
						var stat = $('.maximum-stay').val();
						var num = parseInt(stat, 10);
						num++;

						$('.maximum-stay').val(num);
					});
				});

				/*방갯수  */
				$(function() {
					$('#count-decrease-quantity').click(function(e) {
						e.preventDefault();
						var stat = $('.room-count').val();
						var num = parseInt(stat, 10);
						num--;
						if (num <= 0) {
							/* 	alert("더이상 줄일수 없습니다") */
							num = 1;

						}
						$('.room-count').val(num);
					});
					$('#count-increase-quantity').click(function(e) {
						e.preventDefault();
						var stat = $('.room-count').val();
						var num = parseInt(stat, 10);
						num++;

						$('.room-count').val(num);
					});
				});
				/*게스트가 사용할 침대개수  */
				$(function() {
					$('#bed-decrease-quantity').click(function(e) {
						e.preventDefault();
						var stat = $('.bed-count').val();
						var num = parseInt(stat, 10);
						num--;
						if (num < 0) {
							/* 	alert("더이상 줄일수 없습니다") */
							num = 0;

						}
						$('.bed-count').val(num);
					});
					$('#bed-increase-quantity').click(function(e) {
						e.preventDefault();
						var stat = $('.bed-count').val();
						var num = parseInt(stat, 10);
						num++;

						$('.bed-count').val(num);
					});
				});
				/*욕실  */
				$(function() {
					$('#bathroom-decrease-quantity').click(function(e) {
						e.preventDefault();
						var stat = $('.bathroom-count').val();
						var num = parseInt(stat, 10);
						num--;
						if (num <= 0) {
							/* 	alert("더이상 줄일수 없습니다") */
							num = 1;

						}
						$('.bathroom-count').val(num);
					});
					$('#bathroom-increase-quantity').click(function(e) {
						e.preventDefault();
						var stat = $('.bathroom-count').val();
						var num = parseInt(stat, 10);
						num++;

						$('.bathroom-count').val(num);
					});
				});
			</script>
			<!--페이지 넘어가기(임시방안)  -->
			<div class="room-count-btn-group">
				<a class="registration click-to-save" id="prevBtn" href="./roomType">이전</a>
				<a class="registration click-to-save" id="nextBtn" href="./address">다음</a>
			</div>
			
			<div class="room-count-btn-group">
				<a class="modification click-to-save" id="prevBtn" href="./roomType?hostId=${hostId }">이전</a> 
				<a class="modification click-to-save" id="nextBtn" href="./address?hostId=${hostId }">다음</a>
			</div>
		</div>
		<div id="left"></div>
	</div>

	<script src="/p5/js/host.js?v=<%=System.currentTimeMillis()%>"></script>
</body>
</html>