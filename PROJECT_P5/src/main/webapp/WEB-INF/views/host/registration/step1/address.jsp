<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/p5/css/address.css" />
<link rel="stylesheet" href="/p5/css/reset.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%--panTo 사용시 오류, 이전 위치 기억등 잡아줘야할 내용이 많아져서 그냥 보류--%>
<title>위치</title>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6252091adcb28726fdb95ebdf0b78361&libraries=services"></script>
	
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
		$('#progressBar').val('60');
		$('#tabAddress').css('background','#bbb');
	</script>
<div id="wrap">
	<div id="container">
<h1 class="location">숙소의 위치를 입력해주세요</h1> <div class="pin"><h1>핀이 놓인 위치가 정확한가요?</h1>필요한 경우 핀이 정확한 위치에 자리하도록 조정할 수 있어요. 도착 시 숙소를 찾을 수 있도록 예약이 확정된 게스트만 핀을 볼 수 있습니다.</div>
	<div class="vertInput">도로명/지번 : 
	<input type="text" id="sample5_address"
		onclick="sample5_execDaumPostcode()" placeholder="주소 검색하기" readonly></div>
	<!-- <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"> -->
	<!--  <form action="facilities" method="post" name="formAddress"> -->
	<input type="hidden" name="address" readonly="readonly" id="checkAddress" />
	<input type="hidden" name="latitude" readonly="readonly" id="lat" />
	<input type="hidden" name="longitude" readonly="readonly" id="lon"/>
	<!-- </form> -->
	<br>
	<!-- <div id="map" style="width: 300px; height: 300px; margin-top: 10px; display: none"> -->
	<div id="map" style="width: 300px; height: 300px; margin-top: 10px;">

<!-- 		
		<button id="focusbtn"
			style="background-color: #FFFFFF; width: 33px; height: 35px; margin-right: 2px; position: absolute; top: 105px; right: 0; z-index: 5; border: none; border-radius: 10px;"
			onclick="panTo()">
			<img alt="focus" src="../../img/focus.png"
				style="width: 100%; height: 100%;">
		</button>
		
-->	
	</div>
	<div class="mapSetButtons">
	<button id="map-set-btn">조정하기</button>
	<button id="map-save-btn">저장하기</button>
	</div>
	
	<div id="result"></div>
	
	<div id="addressInfo"></div>
		
	<div class="btn-group">
		<a class="registration click-to-save" id="prevBtn" href="./roomCount">이전</a>
		<a class="registration click-to-save" id="nextBtn" onclick="check()">다음</a>
	</div>
	
	<div class="btn-group">
		<a class="modification click-to-save" id="prevBtn" href="./roomCount?hostId=${hostId }">이전</a>
		<a class="modification click-to-save" id="nextBtn" href="./facilities?hostId=${hostId }">다음</a>
	</div>
	<!-- <button id="next" onclick="inputAddress();">다음</button> -->
	 </div>
  <div id="left">
  
  </div>
  </div>
</body>



<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 1. 지도 기본 구성 -->
<script type="text/javascript">
	/* 1. 지도 기본 구성 */
	
	// 지도 디폴트 좌표
	var defaultLatLng =	new daum.maps.LatLng(37.240910457871784, 131.86707687050958);
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
		center : defaultLatLng, // 지도의 중심좌표(디폴트 : 독도좌표)
		level : 1
	// 지도의 확대 레벨
	};
	//지도를 미리 생성
	var map = new daum.maps.Map(mapContainer, mapOption);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다(확대/축소 막대)
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	map.setZoomable(false); //줌 비활성화

	//최대 줌 레벨
	map.setMaxLevel(3);

	// 주소-좌표 변환 객체를 생성
	var geocoder = new daum.maps.services.Geocoder();

	// 빨간(확정) 마커 미리 생성
	var imageSrc1 = '../../img/markerRed.png', // 마커이미지의 주소입니다    
	imageSize1 = new kakao.maps.Size(65, 70), // 마커이미지의 크기입니다
	imageOption1 = {
		offset : new kakao.maps.Point(30, 60)
	}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	var markerImage1 = new kakao.maps.MarkerImage(imageSrc1, imageSize1, imageOption1);
	var markerPosition1 = defaultLatLng; // 마커가 표시될 위치입니다

	// 빨간 마커
	var markerRed = new daum.maps.Marker({
		position : markerPosition1,
		image : markerImage1,
		map : map,
		draggable : false,
		clickable : false,
		zIndex : 3
	});

	// 파란(이동) 마커를 생성합니다
	var imageSrc2 = '../../img/markerBlue.png', // 마커이미지의 주소입니다    
	imageSize2 = new kakao.maps.Size(65, 70), // 마커이미지의 크기입니다
	imageOption2 = {
		offset : new kakao.maps.Point(30, 60)
	}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	var markerImage2 = new kakao.maps.MarkerImage(imageSrc2, imageSize2, imageOption2);
	var markerPosition2 = defaultLatLng; // 마커가 표시될 위치입니다

	// 파란 마커
	var markerBlue = new daum.maps.Marker({
		position : markerPosition2,
		image : markerImage2,
		map : map,
		draggable : false,
		clickable : false,
		zIndex : 4

	});
			
	// 임시마커(markerTemp)는 valueInMap할 때 파란마커 좌표값을 저장, drag시에 초기화. panTo()에서 getCenter() 간섭을 피하기 위해 사용.
	var markerTemp = new kakao.maps.Marker({
	    position: defaultLatLng,
		map : map,
		draggable : false,
		clickable : false,
		zIndex : 1
	});
	
			
	// 서클
	var circle = new kakao.maps.Circle({
		center : defaultLatLng, // 원의 중심좌표 입니다 
		radius : 20, // 미터 단위의 원의 반지름입니다 
		strokeWeight : 5, // 선의 두께입니다 
		strokeColor : '#75B8FA', // 선의 색깔입니다
		strokeOpacity : 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		strokeStyle : 'dashed', // 선의 스타일 입니다
		fillColor : '#CFE7FF', // 채우기 색깔입니다
		fillOpacity : 0.7
	// 채우기 불투명도 입니다   
	});

	// 일단 마커,서클을 숨김
	markerRed.setVisible(false);
	markerBlue.setVisible(false);
	circle.setMap(null);
	
	markerTemp.setVisible(false);
	
	
</script>

<!-- 2. 페이지 실행시 기본 구성 -->
<script type="text/javascript">
	
	// 기본적으로 맵 div자체를 숨김
 	$('#map').hide();
 	
	// ### 버튼 ###
	$('#map-set-btn').hide(); // 기본적으로  조정하기 버튼 숨김
	$('#map-save-btn').hide(); // 기본적으로  저장하기 버튼 숨김
	
	// ### 변수 ###
	var checkMemoryToggle = false;	// host.js에서 넘어온 값. 유:T, 무:F(default) 
	var toggleButton;		
	// F -> set  클릭시  -> (버튼: set-btn:off / save-btn:on ) -> (드래그,포커스,지도 설정) -> 상태전환(F -> T)
	// T -> save 클릭시  -> (버튼: set-btn:on  / save-btn:off) -> (드래그,포커스,지도 설정) -> 상태전환(T -> F)
	var dragFlag = false;
	var searchFlag = false;
	
	// ### 이벤트 ###
	$(document).on('click','#map-set-btn', state);	// 조정하기 클릭시 조정중
	$(document).on('click','#map-save-btn', state);	// 저장하기 클릭시 저장됨
	
	kakao.maps.event.addListener(map, 'center_changed', function() {
		
		console.log("CENTER_CHANGED!");

		// 지도 중심좌표를 얻어옵니다 
		var latlng = map.getCenter();
		//console.log("중심변경시 getCenter: " + latlng);
		markerBlue.setPosition(latlng);	// 지도 움직일때 마다 센터좌표 => 파란마커
		//console.log("getCenter로 설정한 마커2(getPosition) : " + markerBlue.getPosition());
	});
	
	// 지도 드래그시 주소출력 변경
	kakao.maps.event.addListener(map, 'dragend', moveMap);
			
	// ### 메서드 ###
	// 소수점 아래 4자리까지 올림하여 반환(표준좌표로 설정)
	function ceil(x) {
		
		//console.log("계산전:" + x);
		var digit = Math.pow(10,4);	//소수점 아래 5자리에서 올림하여 4자리까지 표기
		
		return Math.ceil(x * digit) / digit;

	}//end-ceil(x)
	
	// 표준좌표로 비교하여 같으면 True, 다르면 False
	function ApproximatelyEqual(x,y){

		var xLat = x.getPosition().getLat();
		var xLng = x.getPosition().getLng();
		
		var yLat = y.getPosition().getLat();
		var yLng = y.getPosition().getLng();
		
		// 값 비교시 
		/* 
			x = 10.4491 과 y = 10.4500 를 비교 
			소수점 아래 4자리에서 올림하여 3자리까지 표기한다고 할 때
			x' = 10.450 , y' = 10.451
			그러므로
			x, y를 각각 (n+1)자리에서 올림하여 n자리까지 표기하였을 때
			값 비교는 x, y의 (n-1)자리까지 비교가 되어야함			
		*/
		
		console.log("계산후 xLat : " + ceil(xLat));
		console.log("계산후 yLat : " + ceil(yLat));
		console.log("계산후 xLng : " + ceil(xLng));
		console.log("계산후 yLng : " + ceil(yLng));
		
		var d = ceil(xLat).substring(0, (ceil(xLat).length - 1))	
		console.log(d);
		
/* 		
		if( () && () ){
			return true;
		}else{
			return false;
		}
*/					
	}//end-ApproximatelyEqual(x,y)
	
	function moveMap() {
					
		if(!toggleButton) {
			console.log("MOVE_MAP!");
			dragFlag = true;
			// markerTemp 초기화
			markerTemp.setPosition(markerBlue.getPosition());
			markerTemp.setVisible(false);
			console.log("markerTemp 초기화!");
			//markerBlue.setPosition(map.getCenter());
					
			var latlng = markerBlue.getPosition();// 중심 좌표 기준 값을 파란 마커로
			
			//console.log("드래그시 값 비교!");
			//console.log("지도중심 : " + map.getCenter() + " != 파란마커 : " + latlng + "끝자리가 1 다르거나 같음 주의");
			console.log("파란마커 : " + latlng);
	
			var geocoder0 = new kakao.maps.services.Geocoder();
					
			var callback = function(result, status) {
				
				if (status === kakao.maps.services.Status.OK) {
	
					var addressName = result[0].address.address_name;
					var resultAddress = '';
					
					if(!!result[0].road_address){
						var roadAddressName = result[0].road_address.address_name;
	  
						resultAddress +=
							'  <label><input type="radio" name="address1" value="' + roadAddressName + '" />'
						+	' 도로명 주소 : ' + roadAddressName + '</label><br />	'
						+	'  <label><input type="radio" name="address1" value="' + addressName + '" />	'
						+	' 지번 주소 : ' + addressName + '</label><br />	'
						+	' 상세 주소 : <input id="address2" type="text" placeholder="선택 사항" />'
						;
					} else{
						resultAddress +=
							' 지번 주소 : <span id="address1">' + addressName + '</span><br />'
						+	' 상세 주소 : <input id="address2" type="text" placeholder="선택 사항" />'
						;
					}
				     
					$('#addressInfo').empty();
					$('#addressInfo').append(resultAddress);
					$('input[name="latitude"]').val(latlng.getLat());
					$('input[name="longitude"]').val(latlng.getLng());
				}
			};
			geocoder0.coord2Address(latlng.getLng(), latlng.getLat(), callback);
		
			markerBlue.setVisible(true);	
		}
		//afterLatLng = latlng;	// 파란마커 좌표가 이동후 좌표
		//console.log("MoveMap하고 after좌표: " + afterLatLng);
		//console.log("MoveMap하고 getCenter: " + map.getCenter());
		
	}
	
	
	function valueInMap(latitude, longitude) {
	// 지도 세팅 메서드

		// 받은 좌표로 지도 중심 설정
		var mapLatLng = new daum.maps.LatLng(latitude, longitude);
		
		
		// 지도를 보여준다.
		//mapContainer.style.display = "block";
		//map.relayout();	==> 지도의 중심좌표를 재설정해줘서 지양
		$('#map').show();

		// 파란마커,원을 결과값으로 받은 위치로 옮긴다.
		markerBlue.setPosition(mapLatLng);
		circle.setPosition(mapLatLng);
		
		//markerTemp에 파란마커 좌표를 입력
		markerTemp.setPosition(mapLatLng);
		
		console.log("markerBlue : " + markerBlue.getPosition());
		console.log("markerTemp : " + markerTemp.getPosition());
		
		

		// 지도에  표시합니다 
		markerRed.setVisible(false);
		markerBlue.setVisible(true);
		circle.setMap(map);
		
		
		console.log("========(valueInMap)중심좌표 정렬 확인!========");
		console.log("받아 온 좌표 : " + mapLatLng);
		console.log("레드마커 : " + markerRed.getPosition());
		console.log("블루마커 : " + markerBlue.getPosition());
		console.log("서클 : " + circle.getPosition());
		console.log("markerTemp : " + markerTemp.getPosition());
		

		// 지도 중심을 변경한다.
		map.setCenter(mapLatLng);	// center_changed를 실행해서 이후에 블루마커위치가 미세하게 달라짐
	}	//end - valueInMap()
	
	function state() {
		
		// toggle 버튼 클릭시 toggleButton 상태
		//console.log("처리전 toggle 상태 : " + toggleButton);
		// 포커스 버튼 활성/비활성 여부
		
		// 드래그 활성/비활성 여부
		map.setDraggable(toggleButton);
		
		if(toggleButton){
			
			// 조정하기
			$('#map-set-btn').hide();
			$('#map-save-btn').show();
			
			// 레드마커 OFF, 블루마커 ON
			markerRed.setVisible(false);
			markerBlue.setVisible(true);			
			
			settingAddress();
			
		}else{
			if(!savingAddress()){
				console.log("false 반환");
				map.setDraggable(true);
				return false;
			}
			// 저장하기
			$('#map-set-btn').show();
			$('#map-save-btn').hide();
			

			
			// 레드마커 위치 조정, ON
			//markerRed.setPosition(markerBlue.getPosition());
			markerRed.setPosition(markerTemp.getPosition());

			markerRed.setVisible(true);			
			console.log("저장 시 레드:" + markerRed.getPosition());
			
			// 저장시 원 위치 조정
			circle.setPosition(markerBlue.getPosition());
			
			// markerTemp 위치 조정
			markerTemp.setPosition(markerBlue.getPosition());
			
			// 레드마커 ON, 블루마커 OFF
			markerRed.setVisible(true);			
			markerBlue.setVisible(false);
			//markerBlue.setMap(null);

			

		}
		
		//상태 전환
		//console.log("toggleButton 상태전환");
		toggleButton = !toggleButton;
		
		// 처리 후 toggleButton 상태
		//console.log("처리후 toggle 상태 : " + toggleButton);

		
	}	// end - state
	
	function settingAddress() {	// 조정 클릭시 실행
		
		dragFlag = false;
		searchFlag = false;
		
		console.log("========조정!========");
		memoryAddress = $('input[name="address"]').val(); // 메모리 어드레스에 넣고
		$('input[name="address"]').val(""); // 초기화
		
      
	}//end - settingAddress()
	
	function savingAddress(){	// 저장 클릭시 실행
		
		console.log("========저장!========");
		console.log("레드마커 : " + markerRed.getPosition());
		console.log("블루마커 : " + markerBlue.getPosition());
		console.log("서클 : " + circle.getPosition());
		console.log("markerTemp : " + markerTemp.getPosition());
		
		//if(markerRed.getPosition().equals(markerTemp.getPosition())){
		//if(ApproximatelyEqual(markerTemp, markerRed)){
		console.log("드래그 : " + dragFlag + ", 주소검색 : " + searchFlag);	
		if(dragFlag || searchFlag) {
		
			console.log("움직임o");
			dragFlag = false;	//초기화
			searchFlag = false;
			
			var radioCount = $('input:radio[name="address1"]').length;
		      
			var address1;
			
			if(!radioCount){
				address1 = $('#address1').text(); // 선택 주소 or 지번 주소
			} else{
				address1 = $('input:radio[name="address1"]:checked').val();
	 	  		if(!address1){
					alert("주소를 선택하세요.");
	 		  		return false;
				}
			}
			var address2 = $.trim($('#address2').val()); // 상세 주소(선택 사항)	// jquery.trim(str) 수정
			var address = $.trim((address1 + " " + address2));
			
			$('input[name="address"]').val(address);
			//$('input[name="latitude"]').val(markerRed.getPosition().getLat());
			//$('input[name="longitude"]').val(markerRed.getPosition().getLng());
			$('input[name="latitude"]').val(markerTemp.getPosition().getLat());
			$('input[name="longitude"]').val(markerTemp.getPosition().getLng());
			
			$('#addressInfo').empty();
			$('#addressInfo').append( '확정 주소 : ' + address);
			memoryAddress = address;
			console.log('확정 주소 : ' + address);
			
		}else{
			
			console.log("움직임x");
				
			console.log("memory : " + memoryAddress);
			
			// 메모리에 있던 기존 주소를 다시 넣어줌
			$('input[name="address"]').val(memoryAddress);
			
			$('#addressInfo').empty();
			$('#addressInfo').append( '확정 주소 : ' + memoryAddress);
				
		}
		return true;

	}	// end - savingAddress()

	function check(){
		var la=$('#lat').val();
		var lo=$('#lon').val();
		var address=$('#checkAddress').val();
if(!la||!lo||!address){
	alert("주소입력하세요");
	return;
}
else{
	location.href="./facilities ";
	}
	}
	
	
</script>

<!-- 3. 주소/좌표 input값 확인 및  host.js에서 넘어온 값 확인 -->

<!-- <script type="text/javascript">
	var memoryAddress; // host.js로 부터 받아오는 값 담을 변수
	var memoryLatitude; // host.js로 부터 받아오는 값 담을 변수
	var memoryLongitude; // host.js로 부터 받아오는 값 담을 변수

	var checkValue = setInterval(
			function() {
				//실행할 스크립트 
				memoryAddress = $('input[name="address"]').val();
				memoryLatitude = $('input[name="latitude"]').val();
				memoryLongitude = $('input[name="longitude"]').val();

				if (memoryAddress != "" && memoryLatitude != 0 && memoryLongitude != 0) {
					
					checkMemoryToggle = true;
					console.log("메모리 값 있음" + memoryAddress + "/" + memoryLatitude + "/" + memoryLongitude);
					
					// 넘어온 값(좌표)으로 지도 세팅
					// valueInMap(memoryLatitude, memoryLongitude);	////////////잊지말자 수정//////////
					// 저장완료 O 된 상태 = '조정하기'버튼출력된 상태
					
					//toggleButton = false;
					//state();

					// 넘어온 값(주소) 뿌려주기
					// 해당 주소에 대한 좌표를 받아서
			        var memoryLatLng = new daum.maps.LatLng(memoryLatitude, memoryLongitude);
			                          
			        // 지도를 보여준다.
 					$('#map').show();
			        
 					map.setDraggable(false);
 					// 지도 세팅
					valueInMap(memoryLatitude, memoryLongitude);
 					
					$('#map-set-btn').show();
					$('#map-save-btn').hide();
					
					markerRed.setPosition(memoryLatLng);
					markerRed.setVisible(true);		
					
					console.log("저장 시 레드:" + markerRed.getPosition());
					
					// 레드마커 ON, 블루마커 OFF
					markerRed.setVisible(true);			
					markerBlue.setVisible(false);
					
					toggleButton = true;
					
					$('input[name="address"]').val(memoryAddress);
					$('input[name="latitude"]').val(markerRed.getPosition().getLat());
					$('input[name="longitude"]').val(markerRed.getPosition().getLng());
					
					$('#addressInfo').empty();
					$('#addressInfo').append( '확정 주소 : ' + memoryAddress);
					
					console.log('확정주소 memoryAddress	: ' + memoryAddress);
					console.log('memoryLatitude		: ' + memoryLatitude);
					console.log('memoryLongitude	: ' + memoryLongitude);
					console.log('레드 위도 : ' + markerRed.getPosition().getLat());
					console.log('레드 경도 : ' + markerRed.getPosition().getLng());
					
					
					
				}else{
					checkMemoryToggle = false;
					console.log("메모리 값 없음");
				}
				clearInterval(checkValue); //host.js에서 넘어온 값 확인되면 checkValue 종료

			}, 1000);
	
</script> -->

<!-- 4. 주소검색 기본구성 -->
<script type="text/javascript">
	//주소 검색 해서 지도 세팅
	function sample5_execDaumPostcode() {

		new daum.Postcode({
			oncomplete : 
				function(data) {

					var addr = data.address; // 최종 주소 변수
		
					// 주소 정보를 해당 필드에 넣는다.
					document.getElementById("sample5_address").value = addr;
					// 주소로 상세 정보를 검색
					geocoder.addressSearch(data.address, function(results, status) {
						
						// 정상적으로 검색이 완료됐으면
						if (status === daum.maps.services.Status.OK) {
							map.setLevel(1);

							var result = results[0]; //첫번째 결과의 값을 활용

							// 해당 주소에 대한 좌표를 받아서
							var geoLatLng = new daum.maps.LatLng(result.y, result.x);
							
							// setPosition으로 마커에 넣고 그 주소를 세팅값으로 보내면 geocoder좌표와 다를걱정 없음
							// 만만한 파란마커를 사용
							markerBlue.setPosition(geoLatLng);
							var LatLng = markerBlue.getPosition();
							
							// 다른걸 확인가능 : geoLatLng는 소수점아래 13자리 고정, LatLng는 소수점아래 14,15자리 15자릿수가 0일때 14인듯.
							// LatLng의 소수점아래 15자리에서 반올림 14자리에서 다시 반올림해서 13자리의 geoLatLng가 되는듯? 신기한건 geoLatLng에서 LatLng가 복원이 가능하다는점
							//console.log("geoLatLng : " + geoLatLng);
							//console.log("LatLng : " + LatLng);
							
							// 지도 세팅
							valueInMap(LatLng.getLat(),LatLng.getLng());
														


							// 선택 , 상세 주소
							$('#addressInfo').empty();
							$('#addressInfo').append(
								' 선택 주소 : <span id="address1">'+ result.address.address_name + '</span><br />');
							$('#addressInfo').append(
								' 상세 주소 : <input id="address2" type="text" placeholder="선택 사항" />');

							$('input[name="latitude"]').val(result.y);
							$('input[name="longitude"]').val(result.x);
							
							
							toggleButton = true;
							state();
							
							searchFlag = true;



						}
					});
				}
		}).open();

		
	}
</script>







<!-- host.js에서 값을 받아옴 -->
<script src="/p5/js/host.js?v=<%=System.currentTimeMillis()%>"></script>

</html>