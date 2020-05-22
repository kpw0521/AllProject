<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>

/*진행바  */
progress {
	width: 100%;
	-webkit-appearance: none;
	border: 1px solid;
	border-radius: 100px;
	background: white;
}

progress::-webkit-progress-bar-value {
	-webkit-appearance: none;
	background: orangered;
}

progress {
	color: lightblue;
}

progress::-webkit-progress-value {
	background: white;
}

progress::-moz-progress-bar {
	background: lightcolor;
}

progress::-webkit-progress-value {
	background: #008489;
	border-radius: 100px;
}

progress::-webkit-progress-bar {
	background: white;
}
/* progress end  */


#logoImg{
	position: static;
}


header img {
    width: 50px;
    height: 50px;
    vertical-align: middle;
    object-fit: contain;
    object-position: center;
}


.hosting-step {
	display: inline;
	margin-left: 30px;
	font-size: 20px;
}

nav {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	text-align: center;
	margin-top: 20px;
}

.step-tab {
	border: 1px solid #008489;
	padding: 10px;
	color: black;
	text-decoration: none;
	position: static;
}

.step-tab:visited, .step-tab:focus, .step-tab:visited {
	color: black;
}

.step-tab:hover {
	background: #bbb;
}

.fifty {
	top: 60px !important;
}


</style>
</head>
<body>
	<header>
		<a class="click-to-save" id="logoImg" href="../hostingStatus?hostId=${hostId}"><img src="/p5/img/p5Host.png" alt="안보임" /></a>
		<div class="hosting-step">2단계 : 숙소에 대한 정보(사진, 설명, 제목)</div>
		
		<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
		<c:set var="isRegistration" value="${fn:startsWith(path, '/host/registration/')}" />
		<c:set var="isModification" value="${fn:startsWith(path, '/host/modification/')}" />
		<%-- 내용 확인
	     ${path }<br />
	     ${isRegistration }<br />
	     ${isModification }<br /> --%>
	     
	      
	     
		<c:choose>
			<c:when test="${isRegistration }">
			
				<!--  등록  -->
			<div class='progress-bar'>
				<progress value="10" max="100" id="progressBar"></progress>
			</div>
			
	<!-- 		<div class="bar">
				<div class="fifty">
					<p></p>
			</div> -->

		</div>
			
			</c:when>
			<c:when test="${isModification }">
			
				<!-- 수정  -->
			<nav>
				<a class="step-tab click-to-save" href="./photo?hostId=${hostId }" id="tabPhoto">사진등록</a>
				<a class="step-tab click-to-save" href="./description?hostId=${hostId }" id="tabDescription">숙소설명</a>
				<a class="step-tab click-to-save" href="./name?hostId=${hostId }" id="tabTitle">숙소명</a>
			</nav>
			
			</c:when>
		</c:choose>
		
		<%-- 
		<!--  등록  -->
		<div class='progress-bar'>
			<progress value="10" max="100" id="progressBar"></progress>
		</div>
		
		<!-- 수정  -->
		<nav class="modification-tab">
		<a class="step-tab" href="./roomType?hostId=${hostId}" id="tabRoomType">숙소형태</a>
		<a class="step-tab" href="./roomCount?hostId=${hostId}" id="tabRoomCount">인원</a>
		<a class="step-tab" href="./address?hostId=${hostId}" id="tabAddress">위치</a> 
		<a class="step-tab" href="./facilities?hostId=${hostId}" id="tabFacilities">편의시설</a>
		</nav>
		 --%>
		
	</header>
	

<!-- 
<script src="/p5/js/jquery-3.4.1.js"></script> -->

</body>
</html>