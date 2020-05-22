
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소명</title>
<script src="/p5/js/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/p5/css/name.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<style>
.registration, .modification{
	display: none;
}
</style>
</head>
<body>
	<input type="hidden" id="hostId" value="${hostId }" />
	<%@include file="./hostHeaderStep2.jsp"%>

	<script>
		//	$('.hosting-step').empty();
		//	$('.hosting-step').text("2단계:상세정보를 입력하세요");
		$('nav').css('grid-template-columns', 'repeat(3, 1fr)');
		$('#progressBar').val('80');

		$('#tabTitle').css('background', '#bbb');
	</script>


	<div id="wrap">
		<div id="container">
			<h1>숙소의 제목을 만드세요.</h1>
			<h3>숙소의 특징과 장점을 강조하는 제목으로 게스트의 관심을 끌어보세요.</h3>


			<!--2단계마지막  -->
			<input type="text" name="name"  class="title"placeholder="숙소 이름" id="inputText" onkeyup="countWords()" />
			<span id="descriptionWord"></span>
			<div class="warning"></div>
			
			<div class="btn-group">
				<a href="./description?hostId=${hostId }" class="previous-link click-to-save" id="prevBtn">이전</a>
				<a class="registration" onclick="completeStep2()" id="nextBtn">다음</a>
				<a class="modification click-to-save" id="nextBtn" href="../hostingStatus?hostId=${hostId }">다음</a>
			</div>
		
		</div>
		
		
		<div id="left">
			<div id="info">
				<i class="fa fa-lightbulb-o fa-3x" aria-hidden="true"></i><br>경치가
				좋은 Anam-dong, Seongbuk-gu 숙소
			</div>
		</div>
		
	</div>
	<!-- </div> -->
	<script src="/p5/js/jquery-3.4.1.js"></script>
	<script src="/p5/js/host.js?v=<%=System.currentTimeMillis()%>"></script>
	<script>
	$( document ).ready(function() {
		var content1 = $("#inputText").val();
	
		
		var someVarName3 = localStorage.getItem("someVarKey3");
	
		$("#descriptionWord").html(someVarName3 );
		
		$(".title").val(localStorage.getItem("someVarKey4"));
		
	});
		function completeStep2() {
			var name = $('input[name="name"]').val();
			if (!name.trim()) {
				alert("숙소 이름을 입력해주세요.");
				$('input[name="name"]').val("");
				$('input[name="name"]').focus();
				return;
			}
			if(name.length>50){
				$('#inputText').focus();
					 return;
				 }
			var params = {
				hostId : $('#hostId').val(),
				name : name
			}
			$.ajax({
				type : "POST",
				url : "saveName",
				data : params,
				success : function(result) {
					if (result) {
				//		alert("호스트 등록 2단계 완료~");
						location.href = "../hostingStatus?hostId="
								+ $('#hostId').val();
					} else {
						alert("등록 2단계 완료 실패..");
					}
				},
				error : function() {
					alert("통신에 실패..");
				}
			}); // AJAX-END
		}
		/*글자수 구하기  */
		function countWords(){
			 var content = $("#inputText").val();
		if(content.length>50){
			$('.warning').html("제목을 50자 이하로 줄여주세요.");
			$('.warning').show();
			
			$('#inputText').css("outline-color","red");
			  $('#inputText').val($('#inputText').val().substr(0,50));
			
		}else{
			$('.warning').hide();
			$('#inputText').css("outline-color","#008489");
		}
		var someVarName3 = 50- content.length;
		var someVarName4 =  $("#inputText").val();
		localStorage.setItem("someVarKey3", someVarName3);
		localStorage.setItem("someVarKey4",   $("#inputText").val());
		

			 $("#descriptionWord").html(50-content.length);

		}
	</script>
</body>
<!-- <script>
$(document).on('keydown', '#inputText', function() {

	$.ajax({
	    type: "POST",
	    url: "",
	    data : 'name=' + $('#inputText').val(),
	    success:function(data){
	 	   if(!data){
	 		   alert("값을 입력해주세요");
	 	   } else{
	 		   $("#inputText").val(data); // 새로운 인증번호 값 적용
	 	   }
	    },
	    error: function() {
	         alert("통신 실패..");
	    }
	});
});



</script> -->
</html>