<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>메인</title>
<link rel="stylesheet" href="css/reset.css" />
<script src="js/jquery-3.4.1.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script> -->
<script type="text/javascript" src="js/daterangepicker.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<link rel="stylesheet" href="css/daterangepicker.css" />
<style>
table {
	width: 729px;
	height: 222px;
}

#list {
	height: 574px;
	overflow: auto;
	width: 50%;
}

.info-modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 100; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content */
.info-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 568px;
	height: 432px;
	z-index: 10;
} /* The Close Button */
.info-close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.info-tip {
	font-size: 24px;
	font-weight: bold;
	margin-top: 50px;
}

.info-first {
	margin-left: 25px;
	margin-top: 30px;
	color: #484848;
	font-size: 18px;
	font-weight: bold;
}

.info-last {
	/* margin-top: 30px; */
	color: #484848;
	/* font-size: 18px; */
	/* font-weight: bold; */
}

.info-second {
	margin-left: 20px;
	font-size: 18px;
	color: #484848;
	font-weight: bold;
}

.info-third {
	margin-left: 20px;
	font-size: 18px;
	color: #484848;
	font-weight: bold;
}

.second {
	position: relative;
	top: 22px;
	left: -10px;
}

.third {
	position: relative;
	top: 24px;
	left: -7px;
	background-color: black;
	width: 24px;
}

.info-img-first {
	position: relative;
	top: 39px;
	/* left: -7px; */
	float: left;
	left: -5px;
}

#complete {
	color: white;
	background-color: #008489;
	width: 80px;
	height: 48px;
	border: none;
	margin-top: 20px;
	border-radius: 10px;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.description {
	margin: -20px;
}

#wrap {
	width: 80%;
	margin: 0 auto;
	/* display: flex;
	flex-wrap: wrap;
	justify-content: center; */
}

button {
	display: inline;
}

.map-btn {
	display: none;
}

#mapWrapper {
	margin: 5px 5px;
	float: left;
	width: 570px;
	height: 570px;
	top: 110px;
	right: 0;
	z-index: -15;
	border: 2px solid;
	visibility: visible;
	margin-top: 30px;
}

.close-btn {
	display: none;
}

.button-bar {
  	position: relative;
    z-index: 4;
    top: 33px;
    left: -575px;
    text-align: right;
   }

.toggleBG {
    background: #53FF4C;
    width: 62px;
    height: 20px;
    border: 1px solid #53FF4C;
    border-radius: 15px;
    position: relative;
    top: 64px;
    z-index: 5;
    left: 36px;
    box-sizing: border-box;
}

.toggleFG {
	background: #FFFFFF;
    width: 24px;
    height: 24px;
    border: none;
    border-radius: 15px;
    position: absolute;
    top: -1.5px;
    left: 0px;
    border: 1px solid #999;
    box-shadow: 2px 0px 2px rgba(0,0,0,0.4);
}

#button2 {
	width: 100px;
    text-align: center;
}

/* 리스트 */
.list-img {
	width: 100px;
	height: 200px;
	object-fit: contain;
	background: black;
}

table {
	border-collapse: collapse;
}

th, td {
	padding: 0;
}
.img{
width:320px;
}

hr {
	width: 792px;
}

.type {
	color: #717171;
}

.title {
	font-size: 30px;
	
}

.capacity {
	color: #717171;
}

.star-img {
	height: 12px;
	width: 12px;
}

.buttonMap {
	background: rgba(255,255,255,0.85);
    width: 230px;
    height: 40px;
    border-radius: 10px;
}

/* 지도관련 css */
#map {
	width: 100%;
	height: 100%;
	position: relative;
}
</style>

</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	
	<script>
	$(document).ready(function(){
		$('footer').css('clear','both'); 
	});
	</script>

	<div id="wrap">
		<div class="list-map-block"></div>
		<div id="mapWrapper">

			<div id="map" style=""></div>
		</div>
		<!-- 반응형 시, 나타나는 버튼-->
		<button class="close-btn">&times;</button>



		<div class="test1"> 
			<div id="button1" class='toggleBG'>
				<button class='toggleFG' style="left: -1px"></button>
			</div>
			<button id="button1" class="buttonMap button-bar">
				<strong><font size="2"> 지도를 움직이며 검색 &nbsp; </font></strong>
			</button>
		 </div> 

		<!-- <div class="test2" style="vertical-align: middle; text-align: center;  position: fixed; top: 116px; right: 300px; z-index: 4;"> -->
			<button id="button2" class="buttonMap button-bar">
				<strong><font size="2"> 이 지역 검색 &nbsp; </font></strong>
			</button>
	<!-- 	</div> --> 
		
		

		<div id="loading" class="buttonMap"
			style="vertical-align: middle; text-align: center; float: right; position: fixed; top: 116px; right: 300px; z-index: 6;">
			<img alt="loading" src="img/loading.gif"
				style="width: 35px; height: 35px;">
		</div>


		<!-- 	<h1>지도 좌표 정보</h1> -->
		<div id="info"></div>

		<h1>리스트</h1>
		<div id="list"></div>
		<!--테블릿,모바일버전 지도보이기 아이콘  -->
		<button class="map-btn">지도보이기</button>

		<script type="text/javascript">
			var toggle = true;
			$('#button2').hide();
			$('#loading').hide();

			$(document).on('click', '#button1', function() {
				var toggleBG = $('.toggleBG');
				var toggleFG = $('.toggleBG').find('.toggleFG');
				var left = toggleFG.css('left');

				if (left == '-1px') {

					toggleBG.css('background', '#CCCCCC');
					toggleActionStart(toggleFG, 'TO_RIGHT');
					console.log("스위치 꺼짐");
					toggle = false;

				} else if (left == '39px') {

					toggleBG.css('background', '#53FF4C');
					toggleActionStart(toggleFG, 'TO_LEFT');
					console.log("스위치 켜짐");
					toggle = true;
				}
			});

			// 토글 버튼 이동 모션 함수
			function toggleActionStart(toggleBtn, LR) {
				// 0.01초 단위로 실행
				var intervalID = setInterval(function() {
					// 버튼 이동
					var left = parseInt(toggleBtn.css('left'));
					left += (LR == 'TO_RIGHT') ? 5 : -5;
					if (left >= -1 && left <= 39) {
						left += 'px';
						toggleBtn.css('left', left);
					}
				}, 10);
				setTimeout(function() {
					clearInterval(intervalID);
				}, 201);
			}
		</script>

		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6252091adcb28726fdb95ebdf0b78361&libraries=services"></script>
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(37.240910457871784,
						131.86707687050958), // 지도의 중심좌표
				level : 3
			// 지도의 확대 레벨
			};
			
			// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
			/* var infowindow = new kakao.maps.InfoWindow({
				zIndex : 1
			}); */

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);
			
			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다(확대/축소 막대)
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

			map.setZoomable(false); //줌 비활성화

			$(document).ready(searchPlace); // 페이지 로드시 검색결과 기본맵정보 가져옴

			$(document).ready(mapInfo); // 페이지 로드시 검색내에 DB맵정보 가져옴

			kakao.maps.event.addListener(map, 'idle', mapInfo);
			// 지도 중심 좌표나 확대 수준이 변경되면 발생한다. 단, 애니메이션 도중에는 발생하지 않는다.

			function searchPlace() {

				var keyword = $('#address').val();

				/* 
				$('#info').empty();
				$("#info").append(keyword);
				 */

				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();

				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(keyword,function(result, status) {

					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {

						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						// 결과값으로 받은 위치를 마커로 표시합니다
						var marker = new kakao.maps.Marker({map : map,position : coords});

						// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						map.setCenter(coords);

					}else { //주소검색 실패 => 키워드검색

						// 장소 검색 객체를 생성합니다
						var ps = new kakao.maps.services.Places();

						// 키워드로 장소를 검색합니다
						ps.keywordSearch(keyword,placesSearchCB);

						// 키워드 검색 완료 시 호출되는 콜백함수 입니다
						function placesSearchCB(data, status,pagination) {
							if (status === kakao.maps.services.Status.OK) {
								// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
								// LatLngBounds 객체에 좌표를 추가합니다
								var bounds = new kakao.maps.LatLngBounds();

								for (var i = 0; i < data.length; i++) {
									displayMarker(data[i]);
									bounds.extend(
										new kakao.maps.LatLng(
											data[i].y,
											data[i].x));
									}

									// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
									map.setBounds(bounds);
								}
						}

						// 지도에 마커를 표시하는 함수입니다
						function displayMarker(place) {

							// 마커를 생성하고 지도에 표시합니다
							var marker = new kakao.maps.Marker({
								map : map,
								position : new kakao.maps.LatLng(place.y,place.x)
							});

							/* // 마커에 클릭이벤트를 등록합니다
							kakao.maps.event.addListener(marker,'click',function() {
								// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
								infowindow.setContent(
										'<div style="padding:5px;font-size:12px;">'
									+ place.place_name
									+ '</div>'
								);
								infowindow.open(map,marker);
							}); */

						}

					}

				}); //end-addressSearch

			} //end-searchPlace

			function gogo(id) { //postPage로
				var checkInDatecheckOutDate = $('#checkInDatecheckOutDate')
						.val();
				var guestCount = $('#guestCount').val();
				var startDate = "${startDate}";
				var endDate = "${endDate}";
				var address = "${address}";

				location.href = "postPage?id=" + id + "&address=" + address
						+ "&startDate=" + startDate + "&endDate=" + endDate
						+ "&guestCount=" + guestCount;
			}

			function mapInfo() {

				// 지도 영역정보를 얻어옵니다 
				var bounds = map.getBounds();

				// 영역정보의 남서쪽 정보를 얻어옵니다 
				var swLatlng = bounds.getSouthWest();

				// 영역정보의 북동쪽 정보를 얻어옵니다 
				var neLatlng = bounds.getNorthEast();

				// 지도 중심좌표를 얻어옵니다 
				var latlng = map.getCenter();

				// 지도의  레벨을 얻어옵니다
				var level = map.getLevel();

				var message = '<p>지도 레벨은 ' + level + ' 이고</p>';
				message += '<p>중심 좌표는 위도 ' + latlng.getLat() + ', 경도 '
						+ latlng.getLng() + '입니다</p>';

				var message = '<p>영역좌표는 <br>남서쪽 위도, 경도는  '
						+ swLatlng.toString() + '이고 <br>';
				message += '북동쪽 위도, 경도는  ' + neLatlng.toString() + '이고 <br>';
				message += '<p>지도 레벨은 ' + level + ' 이고</p>';
				message += '<p>중심 좌표는 위도 ' + latlng.getLat() + ', 경도 '
						+ latlng.getLng() + '입니다</p>';

				/*
				var resultDiv = document.getElementById('result');   
				resultDiv.innerHTML = message; 
				 */
				/* 
				$('#info').empty();
				$('#info').append(message);
				 */
				if (!toggle) {
					/* $('#button1').hide(); */
					$('.test1').hide();
					$('#button2').show();

					/* 이 지역 검색을 눌렀을 때 */
					$('#button2').on('click', function() {
						console.log("button2 입력");
						ajaxAction();

						$('.test1').show();
						
						$('#button2').hide();
						
					});
				}

				// ajax로 요청
				if (toggle) {
					ajaxAction();
				}

				function ajaxAction() {

					var searchInputDTO = {
						"swLatlng" : swLatlng.toString(),
						"neLatlng" : neLatlng.toString(),
						"guestCount" : "${guestCount}",
						"startDate" : "${startDate}",
						"endDate" : "${endDate}"
					};

					$
							.ajax({
								type : 'POST',
								url : 'ajax/Hosts',
								data : JSON.stringify(searchInputDTO),
								dataType : 'json',
								contentType : "application/json",
								success : function(result) {

									$('#list').empty();

									$
											.each(
													result,
													function(index, item) {

														var ss = '';
														
														var review = '';
														if(item.reviewCount != 0 && item.rateAvg != null){
															
															review = item.rateAvg + '(' + item.reviewCount + ')';
														
														}else{
															
															review = 'new';
															
														}
														
														ss += '<article onclick="gogo('
																+ item.id
																+ ')" id="place'
																+ index
																+ '">'
																+ '<div>'
																+ '<table border="1">'
																+ '<tr>'
																+ '<td rowspan="4" align = "center" class="img">'
																+ '<img class="list-img" alt="' + item.originalName + '" src="' + item.path  + '"  style="width: 300px; height: 200px; margin-left:10px;"  >'

																+ '</td>'
																+ '</tr>'
																+ '<tr>'
																+ '<td class="type">'

																+ item.htName
																+ '/ '
																+ item.rtName
																+ "</td>"
																+ "<td>"

																+ '<td><div class="reviewStarRating">'
																+ '<img src="/p5/img/listStar.png" alt="" class="star-img"/>'

																+ '</div>'
																+ review
																+ '</td>'
																+ '</tr>'
																+ '<tr>'
																+ '<td class="title">'

																+ item.name

																+ '</td>'
																/* + '<td>'
																+ '&nbsp; address :'
																+ item.address
																+ '</td>' */
																+ '</tr>'
																+ '<tr>'
																+ '<td class="capacity">'
																+ '&nbsp;인원: '
																+ item.capacity
																+ '명'
																+ '&nbsp;'
																+ '&middot;'
																+ '방'
																+ item.roomCount
																+ "개"
																+ '&middot;'
																+ ' 침대 '
																+ item.bedCount
																+ "개"
																+ '&middot;'
																+ '욕실'
																+ item.bathroomCount
																+ "개"

																+ '</td>'
																+ '</tr>'
																+ '<tr>'
																/* + '<td>'
																+ 'room : '
																+ item.description
																+ '</td>'
																+ '<td>'
																+ 'guests :'
																+ item.descriptionEtc
																+ '</td>' */
																+ '</tr>'
																+ '</table>'
																+ '</div>'
																+ '</article>'
																+ '<hr>'
																+ '<br>';

														//console.log(ss);

														//마커 추가
														var imageSrc1 = './img/markerBlue.png', // 마커이미지의 주소입니다    
														imageSize1 = new kakao.maps.Size(
																45, 50), // 마커이미지의 크기입니다
														imageOption1 = {
															offset : new kakao.maps.Point(
																	20, 50)
														}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

														// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
														var markerImage1 = new kakao.maps.MarkerImage(
																imageSrc1,
																imageSize1,
																imageOption1), markerPosition1 = new kakao.maps.LatLng(
																item.latitude,
																item.longitude); // 마커가 표시될 위치입니다
														// 기본 마커를 생성합니다
														var marker = new kakao.maps.Marker(
																{
																	position : markerPosition1,
																	image : markerImage1, // 마커이미지 설정
																	title : item.name

																});

														// 이벤트 마커 이미지
														//마커 추가
														var imageSrc2 = './img/markerRed.png', // 마커이미지의 주소입니다    
														imageSize2 = new kakao.maps.Size(
																65, 70), // 마커이미지의 크기입니다
														imageOption2 = {
															offset : new kakao.maps.Point(
																	30, 60)
														}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

														var markerImage2 = new kakao.maps.MarkerImage(
																imageSrc2,
																imageSize2,
																imageOption2), markerPosition2 = new kakao.maps.LatLng(
																item.latitude,
																item.longitude); // 마커가 표시될 위치입니다

														// 마커를 생성합니다
														var marker0 = new kakao.maps.Marker(
																{
																	position : markerPosition2,
																	image : markerImage2, // 마커이미지 설정
																	title : item.name,
																	zIndex : 4

																});
																
														// 마커가 지도 위에 표시되도록 설정합니다
														marker.setMap(map);
														marker0.setMap(null);
														$("img[src$='./img/markerRed.png']").css("display", "none");

														// 마커에 클릭이벤트를 등록합니다
													/* 	kakao.maps.event.addListener(marker,'click',function() {
															// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
															infowindow
																					.setContent('<div style="padding:6px;font-size:13px;">'
																							+ item.name
																							+ '</div>');
																			infowindow
																					.open(
																							map,
																							marker);
																		}); */
														
																			const reulstList = document.getElementById('list');
														
														// 마커에 마우스 커서를 올리면 발생한다.
														kakao.maps.event.addListener(marker, 'mouseover', function() {
																			$('#place'+ index).css("color","red");
																			marker.setMap(map);
																			marker0.setMap(map);
																			$('img[src$="./img/markerRed.png"])', this).css("display", "block");
																			
																			reulstList.scrollTo(0, (221.6 + 34) * index);
																		});

														// 마우스 커서가 마커에서 벗어나면 발생한다.
														kakao.maps.event
																.addListener(
																		marker0, 'mouseout', function() {
																			$('#place'+ index).css("color","black");
																			marker.setMap(map);
																			marker0.setMap(null);
																		});
														
														kakao.maps.event
																.addListener(
																		marker0, 'mouseleave', function() {
																			$('#place'+ index).css("color","black");
																			marker.setMap(map);
																			marker0.setMap(null);
																		});
														
														$('#list').append(ss);

														$('#place' + index).hover(function() {
															$(this).css("color","red");

															marker.setMap(null);
															marker0.setMap(map);

														},
														function() {
															$(this).css("color","black");

															marker0.setMap(null);
															marker.setMap(map);
														});

													});

									if (result == '') {

										$('#list').empty();
										console.log("조건에 맞는 데이터 없음");

										$('#list')
												.append(
														'<br> <h2> 조회하신 조건에 맞는 숙소가 존재하지 않습니다. </h2>');
									}

								},
								beforeSend : function() {

									$("#loading").show();

								},
								complete : function() {

									$("#loading").hide();

								},
								error : function() {
									alert("통신 실패");
								}

							}) // end-ajax

				} // end-ajaxAction

			}; // end-mapInfo

			/*지도 보이기  */
			$('.map-btn').click(function(e) {
				$('#mapWrapper').css("visibility", "visible");
				$('.buttonMap').css("visibility", "visible");
				$('.toggleBG').css("visibility", "visible");
				$('.close-btn').css("visibility", "visible");
				$('.tip-info').css("visibility", "hidden");
				$('#list').css("visibility", "hidden");
				$('#info').css("visibility", "hidden");

			});
			$('.close-btn').click(function(e) {
				$('#mapWrapper').css("visibility", "hidden");
				$('.buttonMap').css("visibility", "hidden");
				$('.toggleBG').css("visibility", "hidden");
				$('.close-btn').css("visibility", "hidden");
				$('.tip-info').css("visibility", "visible");
				$('#list').css("visibility", "visible");
				$('#info').css("visibility", "visible");
				$(window).resize(function() {
					if ($(window).width() > 1024) {
						$('#mapWrapper').css("visibility", "visible");
						$('.buttonMap').css("visibility", "visible");
						$('.toggleBG').css("visibility", "visible");
						$('.close-btn').css("visibility", "visible");
						$('.tip-info').css("visibility", "visible");
						$('#list').css("visibility", "visible");
						$('#info').css("visibility", "visible");
					}

				});

			});
			$(window).resize(function() {
				if ($(window).width() > 1024) {
					$('#mapWrapper').css("visibility", "visible");
					$('.buttonMap').css("visibility", "visible");
					$('.toggleBG').css("visibility", "visible");
					$('.close-btn').css("visibility", "visible");
					$('.tip-info').css("visibility", "visible");
					$('#list').css("visibility", "visible");
					$('#info').css("visibility", "visible");

				}

				if ($(window).width() <= 768) {
					$('#mapWrapper').css("visibility", "hidden");
					$('.buttonMap').css("visibility", "hidden");
					$('.toggleBG').css("visibility", "hidden");
					$('.close-btn').css("visibility", "hidden");
					$('.tip-info').css("visibility", "visible");
					$('#list').css("visibility", "visible");
					$('#info').css("visibility", "visible");
				}

			});
			/* 			/*정보  */

			// Get the modal
			/* var modal = document.getElementById("myModal");

			 // Get the button that opens the modal
			 var btn = document.getElementById("myBtn");

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
			 }/*지도 보이기  */
			/* $('.close').click(function(e) {
			
			 $('.modal').hide();

			 }); */

	
		
			
		</script>

</div>
	
	<%@include file="./footer.jsp" %>
	
</body>
</html>