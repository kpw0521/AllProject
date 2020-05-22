<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소형태</title>
<link rel="stylesheet" href="/p5/css/roomType.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
.registration, .modification{
	display: none;
}
</style>
</head>
<body>
	<input type="hidden" id="hostId" value="${hostId }" />

	<%@include file="./hostHeaderStep1.jsp"%>

	<!-- 페이지별 헤더 변경사항 -->
	<script>
		$('#tabRoomType').css('background', '#bbb'); // 숙소형태 tab
	</script>




	<div id="wrap">
		<div id="container">
			<h1>숙소 등록을 시작해볼까요?</h1>
			<h2>숙소종류를 등록해봐요</h2>
			<!--숙소 종류 
value를 0부터 2까지 설정 0이면 아파트 1이면 주택 2이면 팬션 -->
			<select name="hostTypeId" id="checkType">
				<option value="" class="registration">선택</option>
				<option value="A1">아파트</option>
				<option value="B2">주택</option>
				<option value="C3">팬션</option>
			</select>
			<!--숙소 유형 
value를 0부터 2까지 설정 0이면 전체 1이면 개인실 2이면 다인실 -->
			<h2>숙소유형을 등록해봐요</h2>
			<select name="roomTypeId" id="checkRoom">
				<option value="" class="registration">선택</option>
				<option value="A1">집 전체</option>
				<option value="B2">개인실</option>
				<option value="C3">다인실</option>
			</select>
			<!-- <input type="submit" value="다음" /> -->
			<!-- </form> -->
			<!--페이지 넘어가기(임시방안)  -->
			<!--페이지 넘어가기(임시방안)  -->
		
			<!-- The Modal -->
			<div id="myModal" class="modal">
	
				<!-- Modal content -->
				<div class="modal-content">
					<span class="close">&times;</span>
					<p class="reset-title">입력하신 내용을 저장하세요</p>
					<p>몇 가지 세부정보만 추가하시면 숙소 정보를 저장할 수 있습니다. 호스트 되기나 숙소 등록에 관해 궁금한 점이
						있으시면 P5 도움말 센터를 방문하여 다 자세히 알아보시기 바랍니다.</p>
					<button class="reset">저장하지 않고 나가기</button>
				</div>

			</div>
			<!--  <a class="registration" href="../hostingList">이전</a> -->
			<div class="room-type-btn-group" >
				<button id="reset-info" class="registration">
					<span class="previous">이전</span>
				</button>
				<a class="registration" id="nextBtn" onclick="check()">다음</a>
			</div >
			<div class="room-type-btn-group">
				<a class="modification click-to-save" id="reset-info" href="../hostingStatus?hostId=${hostId }">이전</a>
				<a class="modification click-to-save" id="nextBtn" href="./roomCount?hostId=${hostId }">다음</a>
			</div>
		</div>
	</div>


	<script>
		/*유효성 */
		function check() {

			var check = $("#checkType option:selected").val();
			var check2 = $("#checkRoom option:selected").val();
			console.log(check);
			
			if (!check || !check2) {
				alert("선택해주세요");
				return;
			} else {
				saveParams();
				location.href = "roomCount";
			}
		}
	</script>
	<script>
		/*이전 버튼 누르고난후 모달창으로 한번더 알려줌  */
		// Get the modal
		var modal = document.getElementById("myModal");

		// Get the button that opens the modal
		var btn = document.getElementById("reset-info");

		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];

		// When the user clicks the button, open the modal 
		btn.onclick = function() {
			modal.style.display = "block";
		}

		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			modal.style.display = "none";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}
		$(function() {
			$('.reset').click(function(e) {
				location.href = "../hostingList";
			});
		});
	</script>
	<script src="/p5/js/host.js?v=<%=System.currentTimeMillis()%>"></script>
</body>
</html>