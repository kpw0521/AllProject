<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title>P5 :: ${host.name}</title>

<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>


<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/home.css" />
<link rel="stylesheet" href="css/header.css" />

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />

<link rel="stylesheet"
	href="https://unpkg.com/swiper/css/swiper.min.css">

<link rel="stylesheet" href="css/daterangepicker.css" />
<link rel="stylesheet" href="css/postPage.css" />

</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	<div id="wrap">
		<div class="postImgSlide">
			<!-- 사진 데이터 입력 시 반목문으로  >  .postImgSlide[0] 아래로 append
         <div class="postImg">
            <div class="postImgNumber">(i값)/(전체 사진 갯수)</div>
            <img src="이미지 링크" onclick="modalOn()">
         </div>
         -->

			<!-- start 호스트포토 리스트 출력 작업 by 허민 -->
			<c:forEach var="photo" items="${hostPhoto}" varStatus="status">
				<div class="postImg">
					<div class="postImgNumber">${status.count}/
						${fn:length(hostPhoto)}</div>
					<img src="${photo.path}" alt="${photo.originalName}"
						onclick="modalOn()">
				</div>

			</c:forEach>

			<!-- end 호스트포토 리스트 출력 작업 by 허민 -->

			<div class="postImgSlideButton">
				<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a
					class="next" onclick="plusSlides(1)">&#10095;</a>
			</div>

			<div class="postImgThumbnails">
				<div class="postImgThumbnail"></div>
			</div>
		</div>
		<!-- postImgSlide end -->

		<div class="modalImgSlide">

			<!-- start 호스트포토 modal 출력 작업 by 허민 -->

			<c:forEach var="photo" items="${hostPhoto}" varStatus="status">
				<div class="modalImg">
					<div class="modalImgNumber">${status.count}/
						${fn:length(hostPhoto)}</div>
					<img src="${photo.path}" alt="${photo.originalName}"
						onclick="modalOff()">
				</div>

			</c:forEach>

			<!-- end 호스트포토 modal 출력 작업 by 허민 -->

			<div class="modalImgSlideButton">
				<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a
					class="next" onclick="plusSlides(1)">&#10095;</a>
			</div>

			<div class="modalImgThumbnails">
				<div class="modalImgThumbnail"></div>
			</div>

		</div>
		<hr>

		<div class="postContent">
			<table class="postContentTable">
				<tr>
					<td>
						<div class="contentIntro">
							<table>
								<tr>
									<td><div class="contentTitle">${host.name}</div></td>
									<td rowspan="4"><span class="contentProfile"><img
											src="${profilePhoto.path}" alt="${profilePhoto.originalName}" /></span><br>${host.firstName }님</td>
								</tr>
								<tr>
									<td>작성일 ${host.creationDate }<%-- | 수정일${host.modificationDate } --%></td>
								</tr>
								<tr>
									<td><span class="contentLocation">${host.address }</span></td>
								</tr>
								<tr>
									<td>${host.htName }/ ${host.rtName }|인원 ${host.capacity }명
										방 ${host.roomCount }개 침대 ${host.bedCount }개 욕실
										${host.bathroomCount }개</td>
								</tr>
							</table>
						</div> <!-- postContentIntro end -->
						<hr>
						<div class="contentConven" id="contentConven">
							<div class="contentConven Title">편의시설</div>
						</div>
						<hr>
						<div class="contentExplain">
							<div class="contentExplain Title">숙소 설명</div>
							<pre>${host.description }</pre>
						</div>
						<hr>

						<div class="contentEct">
							<div class="contentEct Title">기타 사항</div>
							<pre>${host.descriptionEtc }</pre>
						</div>
						<hr>
						<div class="contentMap">
							<div class="contentMap Title">지도</div>
							<div id="map" class="map" style="width: 90%">
								<button
									style="background: #FFFFFF; width: 33px; margin-right: 2px; padding: unset; position: absolute; top: 125px; right: 0; z-index: 5; border: none; border-radius: 10px;"
									onclick="panTo()">
									<img alt="focus" src="./img/focus.png"
										style="width: 30px; height: 30px;">
								</button>
							</div>
						</div> <script type="text/javascript"
							src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6252091adcb28726fdb95ebdf0b78361"></script>
						<script>
                     var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                         mapOption = { 
                             center: new kakao.maps.LatLng(37.240910457871784, 131.86707687050958), // 지도의 중심좌표
                             level: 3 // 지도의 확대 레벨
                         };
                     
                     var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
                     
                     map.setMinLevel(1);
                     map.setMaxLevel(5);
                     
                     var latitude = ${host.latitude};
                     var longitude = ${host.longitude};
                     
                     map.setCenter(new kakao.maps.LatLng(latitude, longitude));
                  
                     // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
                     var zoomControl = new kakao.maps.ZoomControl();
                     map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
                     
                     
                     // center 좌표에 마커 생성
                     var imageSrc = './img/markerRed.png', // 마커이미지의 주소입니다    
                         imageSize = new kakao.maps.Size(65, 70), // 마커이미지의 크기입니다
                         imageOption = {offset: new kakao.maps.Point(30, 60)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                     
                     var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
                         markerPosition = new kakao.maps.LatLng(latitude, longitude); // 마커가 표시될 위치입니다
                         
                     // 마커를 생성합니다
                     var marker = new kakao.maps.Marker({
                        position: markerPosition,
                        image: markerImage, // 마커이미지 설정
                        title: "${host.name}",
                        zIndex: 4
                     });
                     // 마커가 지도 위에 표시되도록 설정합니다
                     marker.setMap(map);
                     
                     function panTo() {
                         // 이동할 위도 경도 위치를 생성합니다 -> 마커 위치로
                         var moveLatLon = markerPosition;
                         
                         // 지도 중심을 부드럽게 이동시킵니다
                         // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
                         map.panTo(moveLatLon);            
                     }    
                     
                     function resizeMap() {
                    	    var mapContainer = document.getElementById('map');
                    	    mapContainer.style.width = '90%';
                    	    /* mapContainer.style.height = '650px'; */ 
                    	}

                    	function relayout() {
                    	    map.relayout();
                    	}
                    	
                    	resizeMap();
                    	relayout();

                    	</script>
						<hr>
						<div class="contentReview">
							<div class="contentReview Title">
								후기 <span class="contentReviewStar"> <img src="/p5/img/star1.png" alt="" /> ${reviewAvg} (${reviewCount})</span>
							</div>
							<table class="contentReviewList" id="reviewList">
							<tbody>
								<!-- 
								<tr><td><img src="img/room1.jpg" alt="" /><br>라마바</td><td>★1<br>별로입니다.</td></tr>
								<tr><td><img src="img/room1.jpg" alt="" /><br>가나다</td><td>★4<br>숙소가 굉장히 좋아요! 주변에 관광지도 많고 무엇보다 Host분이 굉장히 친절하세요!!</td></tr>
								-->
								<c:forEach var="review" items="${reviewList}">
									<tr>
										<td><img src="${review.path}" alt="${review.originalName}" /><div class="reviewFirstName">${review.firstName}</div><div class="reviewDate">${review.creationDate}</div></td>
										<td><div class="reviewStarRating"><img src="/p5/img/star1.png" alt="" /> ${review.rating}</div><pre>${review.content}</pre></td>
									</tr>
								
								</c:forEach>
								
							</tbody>
								<!-- 					<tr></tr> -->
							</table>
							<!-- <div class="pagination">
								<div class="pagingPrev">
									<a class="paging" onclick="commentLoad(nowCommentPage-1)">&laquo;</a>
								</div>
								<div class="pagingNum">
									<a class="paging active" onclick="commentLoad(1)">1</a> <a
										class="paging" onclick="commentLoad(2)">2</a> <a
										class="paging" onclick="commentLoad(3)">3</a> <a
										class="paging" onclick="commentLoad(4)">4</a> <a
										class="paging" onclick="commentLoad(5)">5</a>
								</div>
								<div class="pagingNext">
									<a class="paging" onclick="commentLoad(nowCommentPage+1)">&raquo;</a>
								</div>
							</div> -->
						</div> <!-- contentReview end --> <br> <br>
						<hr>
						<div class="contentRefund">
							<div class="contentRefund Title">환불정책</div>
							체크인 30일 전까지는 전액환불 가능합니다.<br><br>
							7일 이상 ~ : 100%<br>5일 이상 ~ 7일 미만 : 75%<br>3일 이상 ~ 5일 미만 : 50%<br>1일 이상 ~ 3일 미만 : 25%<br>당일 : 0% (환급 없음)
						</div>
					</td>
					<td class="reservTab"></td>
				</tr>
				<tr>
			</table>
		</div>
		<!-- postContent end-->

		<div class="contentReserv">

			<c:set var="userId" value="${user.id}" />
			<c:set var="hostMemberId" value="${hostMID}" />
			<c:choose>
				<c:when test="${userId eq hostMemberId}">
					
					<div class="contentReservTitle">예약</div>
					<br>
					<div>
						본인 숙소에는<br>예약할 수 없습니다.
					</div>
					<br>
					
				</c:when>
				<c:when test="${userId != null}">
					<form id="formToBooking" action="reservationPurchase" method="post"
						onsubmit="return isMobileAuthentication();">
						<table>
							<tr>
								<td><div class="contentReservTitle">예약</div>
									${host.price}/1박</td>
								<td>
									<div class="contentReservTitle">날짜</div> <input type="text"
									id="reservationDate" name="reservationDate"
									autocomplete="off" placeholder="날짜 선택" onchange="countRDate()" />
									<!-- header 와 구분 -->
								</td>
								<td><div class="contentReservTitle">인원</div> <span
									class="guestInput"><input type='text' name='guestCount'
										id="guestCount_reserve" class="guestCount_reserve" value="" readonly="readonly">

										<button id="increaseQuantity" onclick="return increase();">▲</button>
										<button id="decreaseQuantity" onclick="return decrease();">▼</button>

								</span></td>
							</tr>
						</table>
						<div id="dateCount"></div>
						<input type="hidden" id="hostId" name="hostId" value="${host.id}">
						<input type="hidden" id="hostName" name="hostName"
							value="${host.name}"> <input type="hidden" id="hostPrice"
							name="hostPrice" value="${host.price}"> <input
							type="hidden" id="dateCnt" name="dateCnt" value=""> <input
							type="submit" id="goPurchase" value="예약하기"
							onclick="return gogo();" /> <input type="hidden" id="userId"
							name="userId" value="${user.id}">

					</form>
				</c:when>
				<c:otherwise>
					<div class="contentReservTitle">예약</div>
					<br>
					<div>
						로그인 후에<br>이용가능합니다.
					</div>
					<br>
					<input type="button" id="goLogin" value="로그인" />
				</c:otherwise>
			</c:choose>
		</div>



	</div>
	<!-- wrap end -->
<jsp:include page="./footer.jsp" />
</body>

<script type="text/javascript">
	
	var sw = true;	// 날짜 출력 여부
	var userId = "${user.id}";
	var hostMemberId = "${hostMID}";
	/*호스트 == 유저 면 예약막기 */
	
   /* 이미지 슬라이드 */
   var slideIndex = 1;
   showSildes(slideIndex);

   function showSildes(n) {
      var i;
      var slides = document.getElementsByClassName("postImg");
      var slidesList = document.getElementsByClassName("postImgSlide");
      var thumb = document.getElementsByClassName("postImgThumbnail");
      var thumbList = document.querySelector(".postImgThumbnails");

      var Mslides = document.getElementsByClassName("modalImg");
      var MslidesList = document.getElementsByClassName("modalImgSlide");
      var Mthumb = document.getElementsByClassName("modalImgThumbnail");
      var MthumbList = document.querySelector(".modalImgThumbnails");

      if (n > slides.length) {
         slideIndex = 1;
      }
      if (n < 1) {
         slideIndex = slides.length;
      }

      for (var i = 0; i < thumb.length; i++) {
         thumb[i].className = thumb[i].className.replace(" active", "");
         thumb[i].style.display = "none";
         Mthumb[i].className = Mthumb[i].className.replace(" active", "");
         Mthumb[i].style.display = "none";
      }

      for (var i = 0; i < slides.length; i++) {
         slides[i].style.display = "none";
         Mslides[i].style.display = "none";
      }

      slides[slideIndex - 1].style.display = "block";
      Mslides[slideIndex - 1].style.display = "block";

      thumbList.innerHTML = "";
      MthumbList.innerHTML = "";

      for (var i = -3; i < 2; i++) {
         if (slideIndex + i < 0) {
            thumbList.innerHTML += '<div class="postImgThumbnail"><img src="'
                  + slides[slideIndex + i + slides.length]
                        .getElementsByTagName("img")[0].src
                  + '" onclick="currentSlide('
                  + (slideIndex + i + slides.length + 1) + ')" /></div>';
            MthumbList.innerHTML += '<div class="modalImgThumbnail"><img src="'
                  + Mslides[slideIndex + i + slides.length]
                        .getElementsByTagName("img")[0].src
                  + '" onclick="currentSlide('
                  + (slideIndex + i + slides.length + 1) + ')" /></div>';
         } else if (slideIndex + i >= slides.length) {
            thumbList.innerHTML += '<div class="postImgThumbnail"><img src="'
                  + slides[slideIndex + i - slides.length]
                        .getElementsByTagName("img")[0].src
                  + '" onclick="currentSlide('
                  + (slideIndex + i - slides.length + 1) + ')" /></div>';

            MthumbList.innerHTML += '<div class="modalImgThumbnail"><img src="'
                  + Mslides[slideIndex + i - slides.length]
                        .getElementsByTagName("img")[0].src
                  + '" onclick="currentSlide('
                  + (slideIndex + i - slides.length + 1) + ')" /></div>';
         } else {
            thumbList.innerHTML += '<div class="postImgThumbnail"><img src="'
                  + slides[slideIndex + i].getElementsByTagName("img")[0].src
                  + '" onclick="currentSlide('
                  + (slideIndex + i + 1)
                  + ')" /></div>';

            MthumbList.innerHTML += '<div class="modalImgThumbnail"><img src="'
                  + slides[slideIndex + i].getElementsByTagName("img")[0].src
                  + '" onclick="currentSlide('
                  + (slideIndex + i + 1)
                  + ')" /></div>';
         }
      }
      thumb[2].className += " active";
      Mthumb[2].className += " active";
   }

   function plusSlides(n) {
      showSildes(slideIndex += n);
   }

   function currentSlide(n) {
      showSildes(slideIndex = n);
   }

   /* 모달 이미지 */

   function modalOn() {
      var modalImgSlide = document.getElementsByClassName("modalImgSlide");
      modalImgSlide[0].style.display = "block";
   }

   function modalOff() {
      var modalImgSlide = document.getElementsByClassName("modalImgSlide");
      modalImgSlide[0].style.display = "none";
   }

   function spanOnoff() {
      var conventCount = 0;
      var convenList = ["${host.isTv }", "${host.isWifi }", "${host.isAirConditioner }", "${host.isAirPurifier }", "${host.isHairDryer }", "${host.isIron }", "${host.isKitchen }", "${host.isWashingMachine }", "${host.isElevator }", "${host.isParkingLot }"];

      for (var i = 0; i < convenList.length; i++) {
         if(convenList[i] == "Y") {
            switch (i) {
            case 0:
               $("#contentConven").append('<span class="convenImg Tv"><img src="./img/tv.png" alt="" /> TV </span>');
               conventCount++;
               break;
            case 1:
               $("#contentConven").append('<span class="convenImg Wifi"><img src="./img/wifi.png" alt="" /> WiFi </span>');
               conventCount++;
               $("#contentConven").append('&nbsp;&nbsp;');
               break;
            case 2:
               $("#contentConven").append('<span class="convenImg Airconditioner"><img src="./img/airconditioner.png" alt="" /> 에어컨 </span>');
               conventCount++;
               break;
            case 3:
               $("#contentConven").append('<span class="convenImg Airpurifier"><img src="./img/airpurifier.png" alt="" /> 공기청정기 </span>');
               conventCount++;
               break;
            case 4:
               $("#contentConven").append('<span class="convenImg Hairdryer"><img src="./img/hairdryer.png" alt="" /> 헤어드라이어 </span>');
               conventCount++;
               break;
            case 5:
               $("#contentConven").append('<span class="convenImg Iron"><img src="./img/iron.png" alt="" /> 다리미 </span>');
               conventCount++;
               break;
            case 6:
               $("#contentConven").append('<span class="convenImg Kitchen"><img src="./img/kitchen.png" alt="" /> 주방 </span>');
               conventCount++;
               break;
            case 7:
               $("#contentConven").append('<span class="convenImg Washingmachine"><img   src="./img/washingmachine.png" alt="" /> 세탁기 </span>');
               conventCount++;
               break;
            case 8:
               $("#contentConven").append('<span class="convenImg Elevator"><img src="./img/elevator.png" alt="" /> 엘리베이터 </span>');
               conventCount++;
               break;
            case 9:
               $("#contentConven").append('<span class="convenImg Parking"><img src="./img/parking.png" alt="" /> 주차장 </span>');
               conventCount++;
               break;
            default:
               break;
            }
            $("#contentConven").append('&nbsp;');
         }
/*        if(conventCount == 5) $("#contentConven").append('<br>'); */  

      }
   }
   spanOnoff();
   
   
   /* 댓글 */
   var commentCount = 0;
   var commentStar = 0;

   function commentLoad() {
      $("#reviewList").children("tbody").after('<tr>'+'<td><img src="img/room1.jpg" alt="" /><br>가나다</td>'
            + '<td>★4<br>숙소가 굉장히 좋아요! 주변에 관광지도 많고 무엇보다 Host분이 굉장히 친절하세요!!</td>'
            + '</tr>');
      $("#reviewList").children("tbody").after('<tr>'+
      '<td><img src="img/room1.jpg" alt="" /><br>라마바</td><td>★1<br>별로입니다.</td></tr>');
   }
   commentLoad();
   
   function commentMore() {
      /* 댓글 더보기 (상단부터 오래된 댓글) -> 화면 프린트 시 최근 댓글이 위로 프린트됨 */
       $("#reviewList").children("tr:last").after('<tr>'+'<td><img src="img/berry.jpg" alt="" /><br>가나다</td>'
            + '<td>★5<br>숙소가 굉장히 좋아요! 주변에 관광지도 많고 무엇보다 Host분이 굉장히 친절하세요!!</td>'
            + '</tr>');
      $("#reviewList").children("tr:last").after('<tr>'+
      '<td><img src="img/room1.jpg" alt="" /><br>라마바</td><td>★2<br>별로입니다.</td></tr>');
      
      /* (만약 next가 없다면) */
/*       $("#reviewList").children("tr:last").after('<tr>'+
      '<td colspan="2">마지막 후기입니다.</td></tr>'); */
   }
   
   /* 캘린더 */
   
	// 로그인 안되어있을시에 로그인 유도 
	$('#goLogin').on('click', logInModalOn);
   

   

   
   var pMinDate = new Date();
   var pMaxDate = new Date();
   pMaxDate.setMonth(pMinDate.getMonth() + 3);
    
   	var blockingStr = "${blocking}";
   	console.log("블로킹날짜 : " + blockingStr);
	var blockingArr = blockingStr.split(',');
/* 	
	for(var i in blockingArr){
		console.log("blocking : " + i);
	}
*/


   var minimumStay = ${host.minimumStay};
   var maximumStay = ${host.maximumStay};
   
   console.log("최소 숙박 : " + minimumStay + ", 최대 숙박 : " + maximumStay);
   
   function getFormatDate(date){	// YYYY.MM.DD형태로
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '.' + month + '.' + day;
	}

	function getFormatPrevDate(date){	// YYYY-MM-DD형태로
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = (date.getDate() - 1);                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '-' + month + '-' + day;
	}

	function getFormatNextDate(date){	// YYYY-MM-DD형태로
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = (date.getDate() + 1);                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '-' + month + '-' + day;
	}
	
	//  변수날짜보다 -1일 날짜 => MM/DD/YYYY 형태로
	function getOtherFormat(date){
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = (date.getDate() - 1);                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  month + '/' + day + '/' +  year;
	}
	
	function getKoreanFormat(date){
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return year + '년 ' + month + '월 ' + day + '일';
	}

	function getMinDateFormat(date){
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate() + minimumStay;                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return year + '.' + month + '.' + day;
	}
	
	function parse(str) {	// String -> Date 파싱
	    var y = str.substr(0, 4);
	    var m = str.substr(5, 2);
	    var d = str.substr(8, 2);
	    return new Date(y,m-1,d);
	}
	
	// 받은 start, end 데이트 파싱
/*
	var	startDate = '${startDate}';
	var endDate = '${endDate}';
	
 	if((startDate == '' || startDate == null) && (endDate == '' || endDate == null)) {
		startDate = endDate = getFormatDate(new Date());		 
	}

	var sDate = parse(startDate);
	var eDate = parse(endDate);
	
	console.log("start : " + sDate);
	console.log("end : " + eDate);
*/	
	
   $(function() {
      $('#reservationDate').daterangepicker({	
               "autoApply" : true,
               /* "startDate" : sDate,
               "endDate" : eDate, */
               "minDate" : pMinDate,
               "maxDate" : pMaxDate,
               "maxSpan" : {"days" : maximumStay},
               "isP5InvalidDate" : function(ele) {
                   var currDate = moment(ele._d).format('YYYY.MM.DD');
                   
                   return [${blocking}].indexOf(currDate) != -1;
            	}
               
            }, function(start, end, label) {
            	
            	sw = true;
            	var startDayP = start.format("YYYY.MM.DD");
            	var endDayP = end.format("YYYY.MM.DD");
    			
            	// start 선택하고 end로 min 또는 자신 선택못함 
				if(startDayP == endDayP) {
					$('#reservationDate').data('daterangepicker').setStartDate();
					$('#reservationDate').data('daterangepicker').setEndDate();
            		alert("호스트의 최소 숙박일 수가 " + minimumStay + "박" + (minimumStay+1) + "일 부터 입니다." );
					sw = false;
            	}else{
            		sw = true;
            	}

            	
				// endDate가 비활성날짜보다 클 때 비활성 이전 날짜로 알림 후 맞춰짐(x)
				// 그냥 오늘 날짜로 초기화 하기로 함.
				blockingArr.forEach(function(item){
					console.log("blocking : " + item);
					var blockDate = new Date(item).getTime();
					console.log("blocking stamp : " + blockDate);
					
	            	if(end >= blockDate && start < blockDate){
	            		
	            		var koreanDate = getKoreanFormat(new Date(blockDate));	// yyyy년 MM월 DD일
	            		
	            		//$('#reservationDate').data('daterangepicker').setEndDate(setTypeXDate);
	            		$('#reservationDate').data('daterangepicker').setStartDate();
						$('#reservationDate').data('daterangepicker').setEndDate();
	            		
	            		alert("호스트의 사정으로 " + koreanDate + "는 예약이 불가능합니다.");
	            		sw = false;
	            	}
	            	
				});
				
				

            });	   
      		/* var reservationDate = '${checkInDatecheckOutDate}';
			
			console.log("date 확인 : " + reservationDate);
			
			if(reservationDate != ''){
				$("#reservationDate").val(reservationDate);
			}else{
			  	$("#reservationDate").val('');	// 초기 입력 없으면 '날짜 선택' 값 = null
			} */

   });
   
   function countRDate() {


	 	
	   	if(sw){
			var date = $("#reservationDate").val().split(" - ");
			var checkInDate = date[0].split(".");
			var checkInDate1 = new Date(checkInDate[0], checkInDate[1]-1, checkInDate[2]);
			var checkOutDate = date[1].split(".");
			var checkOutDate1 = new Date(checkOutDate[0], checkOutDate[1]-1, checkOutDate[2]);
			var dateCount = parseInt(checkOutDate1-checkInDate1)/(24*60*60*1000);
			
			$('#dateCnt').val(dateCount);
			
			$("#dateCount").html(dateCount + "박 " + (dateCount+1) + "일/" + ("${host.price }"*dateCount) + "원");
			
	   	}else{
	   		
	   		$("#reservationDate").val('');
	   		$('#dateCnt').val('');
	   		$("#dateCount").empty();
			$("#dateCount").html("날짜를 선택해주세요."); 
			
	   		
	   	}
	}
	
	/* 인원 선택 */
	/* button 태그 사용하면 submit되서 input 태그 또는 button태그 내에 button 타입을 부여했으나 버튼 적용이 안되서 정정함 */
	$(document).ready(function() {
		var guestCountVal = '${guestCount}';
			
		if(guestCountVal == -1 || guestCountVal == null || guestCountVal == ''){
			$('#guestCount_reserve').val(1);
		}else{
			$('#guestCount_reserve').val(guestCountVal);
		}
	});
	function decrease() {
		var stat = $('#guestCount_reserve').val();
		var num = parseInt(stat, 10);
		
		if (num > 1) {
		   //alert('1명미만으로 예약할 수 없습니다');
			num--;
		}
		
		$('#guestCount_reserve').val(num);

		return false;
	}
	
	function increase() {
		var stat = $('#guestCount_reserve').val();
        var num = parseInt(stat, 10);
        num++;
        var capacity = "${host.capacity}";
        if(num > capacity){
       	 alert("해당 host의 최대 수용 인원은 " + capacity + "명 입니다.");
       	 num--;
        }
        $('#guestCount_reserve').val(num);
        
        return false;
        
	}
	
   /* 페이징 */
   
   var nowCommentPage = 1;
	commentLoad(nowCommentPage);
 
	function commentLoad(n) {
			nowCommentPage = n;
			var nn = Math.ceil(n/5)-1;
	 
			/* 댓글 정보 리스트 */
	/* 		var commentWriterImgList = ["img/back.jpg", "img/berry.jpg", "img/bread.jpg", "img/coffee.jpg", "img/fox.jpg", "img/water.jpg", "img/flower.jpg"];
			var commentWriterList = ["가나", "다라", "마바", "사아", "자차", "카타", "파하"];
			var commentStarList = ["1", "1.5", "2", "2.5", "3", "4.5", "5"];
			var commentContentList = ["좋아요", "숙소가 굉장히 좋아요!", "주변에 관광지도 많아요", "무엇보다 Host분이 굉장히 친절하세요!!", "별로입니다.", "그냥 그래요", "ㅁㅇㅁㄴㅇㅁㅇㅁㄴㅇ" ];
	 */		
			/* 한페이지당 댓글 출력 갯수 3개로 설정 */
		  var paging = document.getElementsByClassName("paging");
	
	/* 		var commentNum = 3;
		   var pagingNumber = Math.ceil(commentWriterList.length/commentNum); 
		  */
		   /* 화살표 */
	/* 	   if(n == 1){
			   $(".pagingPrev").css("display", "none");
		   } else if(n == pagingNumber){
			   $(".pagingNext").css("display", "none");
		   } else {
			   $(".pagingPrev").css("display", "block");
			   $(".pagingNext").css("display", "block");
		   }
	 */	   
		   /* 페이징 번호 */
	/* 	   $(".pagingNum").html("");
		   for (var i = (1+nn*5); i < (1+nn*5+5); i++) {
			   $(".pagingNum").append('<a class="paging" onclick="commentLoad(' + i + ')">' + i + '</a>');
		}
		    */
		   /* for (var i = 0; i < paging.length; i++) {
			   paging[i].className = paging[i].className.replace(" active", "");
			}
		    
			paging[n].className += " active";	 */	    
		   /* paging[n-(nn*5)].className += " active"; */
		   
		   /* 01234
		   56789
		   1011121314 
		   n-(nn*5)
		   */
		   /* 1 123
		   	2 456
		   	3 789
		   */
		   /* 
		   var startNum = 1+(commentNum*(n-1))-1;
				$("#reviewList").children("tbody").html('<tr>'+'<td><img src="' + commentWriterImgList[startNum] +'" alt="" /><br>' + commentWriterList[startNum] + ' </td>'
			            + '<td>★' + commentStarList[startNum] +'<br>'+ commentContentList[startNum] +'</td></tr>');
				
				$("#reviewList").children("tbody").children("tr:last").after('<tr>'+'<td><img src="' + commentWriterImgList[startNum+1] +'" alt="" /><br>' + commentWriterList[startNum+1] + ' </td>'
			            + '<td>★' + commentStarList[startNum+1] +'<br>'+ commentContentList[startNum+1] +'</td></tr>');
				$("#reviewList").children("tbody").children("tr:last").after('<tr>'+'<td><img src="' + commentWriterImgList[startNum+2] +'" alt="" /><br>' + commentWriterList[startNum+2] + ' </td>'
			            + '<td>★' + commentStarList[startNum+2] +'<br>'+ commentContentList[startNum+2] +'</td></tr>');
 */ 
	}
  
	
	
	// 휴대전화 인증 여부 검사
	function isMobileAuthentication(){
		var isAuthentication = false;
		
		$.ajax({
			type : "POST",
			url : "ajax/isMobileAuthentication",
			async : false,
			success : function(data){
				if(data){ // 휴대전화 인증자이면
					
					isAuthentication = true; // submit을 허락
					
				} else{ // 아니면
					
					alert("휴대전화 인증 이후에 이용 가능한 서비스입니다.");
				////////// 팝업창
					var phoneURL = '/p5/phoneCertification';
					var phoneOption =  "width=370, height=360, resizable=no, scrollbars=no, status=no;";
					window.open(phoneURL,"",phoneOption);
					
				}
			},	
			error : function(){
				alert("통신 실패..");
			}
		});
		
		return isAuthentication;
	}
	
    // purchase으로 가시전 날짜 유효성 확인
   	function gogo() {
    	
    	if($('#dateCnt').val() == null || $('#dateCnt').val() == "" || 
    			$("#reservationDate").val() == null || $("#reservationDate").val() == null){
    		
			sw = false;
			$('#reservationDate').val("");
			$('#reservationDate').focus();
			
    	}else{
    	
			var date = $("#reservationDate").val().split(" - ");
			var checkInDate = date[0].split(".");
			var checkInDate1 = new Date(checkInDate[0], checkInDate[1]-1, checkInDate[2]);
			var checkOutDate = date[1].split(".");
			var checkOutDate1 = new Date(checkOutDate[0], checkOutDate[1]-1, checkOutDate[2]);
			var dateCount = parseInt(checkOutDate1-checkInDate1)/(24*60*60*1000);
		   	
			if(dateCount == 0){
				sw = false;
				$('#reservationDate').val("");
				$('#reservationDate').focus();
			}
    	}
		if(!sw){
			alert("날짜를 선택하세요!");
			return false;
		}else{
			return true;
		}
	}// end -gogo()
	
</script>

</html>