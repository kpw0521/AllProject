<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호스트 등록</title>
<style>
 li {
	list-style: none;
}

#wrap {
	width:100%;
	max-width: 1100px;
	margin: auto;
}

/* hostingList 총괄 */
.hosting-list {
	margin: 30px 0px; 
	padding: 30px 0px;
}


/* 메인 제목 */
.hosting-list-main-title {
	font-size: 30px;
	font-weight: bold;
	margin: 40px 0px;
}

.hosting-list-li,
.hosting-list-li-old {
	margin: 60px 0px;
}

/* hostingList 설명 block */
.hosting-list-description {
    display: inline-table;
    vertical-align: middle;
    margin-left: 20px;
    width: 30%;
}

/* 제목  */
.hosting-list-title {
	width: 100%;
    display: table;	
    padding-bottom: 10px;
}

/* 설명 */
.hosting-list-room {
	color: #bbb;
}

/* list block */
.hosting-list-block {
    padding: 50px 300px 50px 20px;
    border-bottom: 0.5px solid #bbb;
}

/* 호스트가 등록한 사진 */
.hosting-list-img {
	width: 96px;
	height: 64px;
	object-fit: contain;
	object-position:center;
	display: inline-block;
    vertical-align: middle;
}

/* 라디오 버튼 label 처리 */

input[type=radio] {
	display: none;
}

input[type=radio]:checked+label {
	border: 1px solid #ed2d55;
	box-sizing: border-box;
}


 
/* 미등록 숙소   */
.hosting-list-type {
	font-size: 20px;
}

.hosting-list-btn {
	position: relative;
	padding-top: 40px;
}

#nextBtn {
	margin-left: 40%;
	background: #E51E51;
	font-size: 15px;
	font-weight: bold;
	color: white;
	border: none;
}

#nextBtn,
#deleteBtn {
	width: 15%;
	height: 30px;
	box-sizing: border-box;
	outline: none;
	border-radius: 10px;
}

#deleteBtn {
	font-size: 15px;
	font-weight: bold;
	color: #E51E51;
	background: white;
	border: 1px solid #E51E51;
}

</style>
</head>
<body>
	<%@include file="../header.jsp" %>
	<!-- <form action=""> -->
	<div id="wrap">
	
		<div class="hosting-list">
			<div class="hosting-list-main-title">새로운 숙소 진행을 시작해볼까요?</div>
			<div id="list">
				<ul id="hosting-list-ul">
					<!-- 새로운 숙소 등록  -->
					<li class="hosting-list-li">
						<input class="hosting-list-input" id="newHosting" type="radio" name="hostId" value="0" /> 
						<label for="newHosting" class="hosting-list-block"> 
							<img class="hosting-list-img" src="/p5/img/defaultImg.jpg" alt="사진" /> 
							<span class="hosting-list-description">
								<span class="hosting-list-title">새로운 숙소 등록하기</span>
							</span>
						</label>

					</li>

					<li><span class="hosting-list-type"></span></li>
					
					
				</ul>
			</div>
			<!-- 버튼 -->
			<div class="hosting-list-btn">
				<button onclick="deleteHost()" id="deleteBtn">삭제</button>
				<button onclick="next()" id="nextBtn">다음</button>
			</div>
		</div>
	</div>
	
<script>

	function next() {
		// 체크 여부
		var isChecked = $('input[name="hostId"]:checked').length;
		// 선택 호스팅의 호스트ID
		var hostId = $('input[name="hostId"]:checked').val();

		if (!isChecked) { // 체크하지 않았으면
			alert("호스팅을 선택해주세요.");
		} else { // 체크했으면
			location.href = "hostingStatus?hostId=" + hostId;
		}

	} // next-END

	$(window).bind("pageshow",function(event) {
		refresh(); // 화면 갱신

		$.ajax({
			type : "POST",
			url : "./registration/reset",
		}); // AJAX-END
	});
	
	
	// 화면 갱신
function refresh(){
	$.ajax({
		type : "POST",
		url : "getHostingList",
		//			async : false,
		success : function(hostingList) {
			if(hostingList.length == 0){
				$('.hosting-list-li-old').remove();
				$('.hosting-list-type').text('새로운 숙소를 등록해주세요.');
			}else{
				
		
			//	alert(hostingList.length);
			var result = ''; var hostName; 
			
			$.each(hostingList,function(i, hosting) {
				var hostingListId;
				if(!hosting.hostName){
					hostName = "";
				} else{
					hostName = hosting.hostName;
				}
				hostingListId='hostingListId_'+i;
				
				
				result += '	<li class="hosting-list-li-old"> '
						+ '	<input id="'+ hostingListId + '" type="radio" name="hostId" value="' + hosting.hostId + '" />	'
						+ ' <label for="'+ hostingListId +'" class="hosting-list-block" >'
						+ '	<img class="hosting-list-img" src="' + hosting.coverPhotoPath +'" onError='+'"this.src='+"'/p5/img/defaultImg.jpg'"+'" />	' 
						+ ' <span class="hosting-list-description">'
						+ ' <span class="hosting-list-title">' + hostName +  ' </span> '
						+ ' <span class="hosting-list-room"> '+ hosting.roomTypeName +' </span> '
						+ ' </span> ' 
						+ '	</label></li>';
						
			
				}); // each-END

				
			$('.hosting-list-li-old').remove();
			$('.hosting-list-type').text('등록중인 숙소');
			$('#hosting-list-ul').append(result);
			
			}
		},
		
		error : function() {
			alert("통신 실패..");
		}
	});
}	
	
	
	
	// 호스트 삭제 메소드
	function deleteHost(){
		// 체크 여부
		var isChecked = $('input[name="hostId"]:checked').length;
		// 선택 호스팅의 호스트ID
		var hostId = $('input[name="hostId"]:checked').val();
		
		if (!isChecked || hostId == 0) { // 체크하지 않았으면 or 새로운 숙소 등록하기 선택
			alert("삭제할 호스팅을 선택해주세요.");
			return;
		}
	
		var deleteValue = confirm("삭제하시겠습니까?");
		if (deleteValue) {
			$.ajax({
				type : "POST",
				url : "deleteHost",
				data : "hostId=" + hostId,
				success : function(result) {
					if (result) { // 호스트 삭제 성공
						refresh(); // 화면 갱신 
					} else {
						alert("호스팅 삭제 실패..");
					}
				},
				error : function() {
					alert("통신 실패..");
				}
			});
		}
	}
</script>
	
	<jsp:include page="../footer.jsp"/>


</body>
</html>