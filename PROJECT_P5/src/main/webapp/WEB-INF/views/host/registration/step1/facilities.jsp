<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>편의시설</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/p5/css/facilities.css" />
<style>
.registration, .modification{
	display: none;
}
</style>
</head>
<body>
	<input type="hidden" id="hostId" value="${hostId }" />
	<%@include file="./hostHeaderStep1.jsp" %>
	<script>
		$('#progressBar').val('80');
		$('#tabFacilities').css('background','#bbb');
	</script>
			<div id="wrap">
		<div id="container">
<!-- <form action="photo" method="post"> -->
<h1>편의시설이 어떤게 있나요?</h1>
<div class="text">일반적으로는 게스트가 기대하는 편의시설 목록입니다 숙소를 등록한후 언제든 편의 시설을 추가할수 있어요</div> 
<br>

<input class="check-Facilities" class="available"type="checkbox" id="TV" name="isTv" value="Y" /><label for="TV">TV</label><hr noshade="noshade"/><br>

<input class="check-Facilities"class="available"type="checkbox" id="WiFi" name="isWifi" value="Y" /><label for="WiFi">Wifi</label><hr noshade="noshade" /><br>

<input class="check-Facilities"class="available"type="checkbox"  ID="airConditioner" name="isAirConditioner" value="Y" /><label for="airConditioner">에어컨</label><hr noshade="noshade" /><br>

<input class="check-Facilities"class="available"type="checkbox" id="airPurifier" name="isAirPurifier" value="Y" /><label for="airPurifier">공기청정기</label><hr noshade="noshade"/><br>

<input class="check-Facilities"class="available" type="checkbox" id="hairDryer" name="isHairDryer" value="Y" /><label for="hairDryer">헤어드라이기</label><hr noshade="noshade"/><br>

<input class="check-Facilities" class="available" type="checkbox"  id="iron" name="isIron" value="Y" /><label for="iron">다리미</label><hr noshade="noshade"/><br>



<h1 class="available-facilities">이용가능한 시설</h1>
<div class="text">등록하고자하는 숙소에서 게스트가 이용가능한 공용공간을 선택하세요</div>
<br>
<input class="available" class="check-Facilities" type="checkbox" id="kitchen"  name="isKitchen" value="Y" /><label for="kitchen">주방</label><hr noshade="noshade"/><br>

<input class="available" class="check-Facilities"type="checkbox"  id="washingMachine"name="isWashingMachine" value="Y" /><label for="washingMachine">세탁기</label><hr noshade="noshade"/><br>

<input class="available"type="checkbox"class="check-Facilities"  id="Elevator" name="isElevator" value="Y" /><label for="Elevator">앨리베이터</label><hr noshade="noshade"/><br>

<input class="available" type="checkbox"class="check-Facilities"  id="parkingLot" name="isParkingLot" value="Y" /><label for="parkingLot">주차</label><hr noshade="noshade"/><br>


	
	<div class="btn-group">
		<a class="registration click-to-save" id="prevBtn"href="./address">이전</a>
		<a class="registration" id="nextBtn" onclick="completeStep1()">다음</a>
	</div>
	
	<div class="btn-group">
		<a class="modification click-to-save" id="prevBtn" href="./address?hostId=${hostId }">이전</a>
		<a class="modification click-to-save"id="nextBtn" href="../hostingStatus?hostId=${hostId }">다음</a>
	</div>

</div>
<div id="left">
</div>
</div>
	
	<script>
		function completeStep1() {
			var params = setParams();
			$.ajax({
				type : "POST",
				url : "step1/complete",
				data : params,
				success : function(hostId) {
					location.href = "../hostingStatus?hostId=" + hostId;
				},
				error : function() {
					alert("통신 오류..");
				}
			}); // AJAX-END
		}
	</script>
	<script src="/p5/js/host.js?v=<%=System.currentTimeMillis()%>"></script>
</body>
</html>