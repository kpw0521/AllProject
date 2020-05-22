<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<link rel="stylesheet" href="/p5/css/price.css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
<!--   <script type="text/javascript">
    function inNumber(){
    	/*  */
        if(event.keyCode<48 || event.keyCode>57){
         
        	event.returnValue=false;
        }else{
        	
        }
    }
    </script> -->
<title>가격</title>
<style>
.registration, .modification{
	display: none;
}
</style>
</head>
<body>
	<input type="hidden" id="hostId" value="${hostId }" />
	<%@include file="./hostHeaderStep3.jsp"%>


	<script>
		//	$('.hosting-step').empty(); // 없어도 됨
		//	$('.hosting-step').text("3단계 : 숙박 요금을 설정하세요");
		$('nav').css('grid-template-columns', 'repeat(3, 1fr)');
		$('#progressBar').val('80');

		$('#tabPrice').css('background', '#bbb');
	</script>




	<!-- <form action="finish" method="post"> -->

	<!--0부터 9까지 숫자를 입력하지않으면 ""로 replace됨  -->
	<div id="wrap">
		<div id="container">

			<h1>숙소 요금 설정하기</h1>
			<p class="info-text">예약을 받을 가능성을 높이세요</p>
			<p class="description">스마트 요금을 설정하면 숙소가 위치한 지역에 대한 수요에 따라 1박 요금이
				자동으로 조정되어 경쟁력을 유지할 수 있습니다.</p>
			모든 날짜에 동일하게 적용할 기본 요금을 설정하세요
			<!--0부터 9까지 숫자를 입력하지않으면 ""로 replace됨  -->
			<br>
			<h4>기본 요금</h4>
			<h6>이 요금이 기본 요금이 됩니다.</h6>
			<br>
			<div id="price">
				<span class="won">&#8361;</span><input type="text" name="price"
					
					onmouseout="origin()" id="input"/>
			</div>
			<div class="suggestion">
				제안요금:&#8361;20,455<i class="fa fa-question-circle-o" aria-hidden="true"
					onmouseleave="hide()"></i>
				<p class="suggestion-info">제안 가격은 숙소의 퀄리티, 주변 숙소의 요금, 수요에 기반합니다.</p>
			</div>
			<!--  <input type="submit" value="다음" /> -->
			<!-- </form> -->
			<div class="price-btn-group">
				<a href="./calendar?hostId=${hostId }" id="prevBtn" class="previous-link">이전</a>
				<button class="registration" id="nextBtn" onclick="completeStep3()">완료</button>
				<button class="modification" id="nextBtn" onclick="modifyPrice()">완료</button>
			</div>
			
		</div>
		
		
		<div id="left">
			<div id="info">
				<i class="fa fa-lightbulb-o fa-3x" aria-hidden="true"></i><br>낮은
				요금으로 시작하여 예약을 유도 하세요<br> 신규 호스트는 첫 예약을 유도하기 위해 낮은 요금으로 호스팅을
				시작합니다. 제안 요금의 5% 내외로 요금을 설정하면 예약률이 4배가량 늘어납니다.
			</div>
		</div>
	</div>

	<script src="/p5/js/host.js?v=<%=System.currentTimeMillis()%>"></script>
	<script>
	$(function() {
		$('input[type="text"]').click(function(e) {
			$('#price').css("border-color", "#008489");
			$('input[type="text"]').css("border-bottom", " 1px solid #008489");
		});
		$('i.fa.fa-question-circle-o').click(function(e) {
			$('.suggestion-info').toggle();
		});

	});
	//3자리 단위마다 콤마 생성
	function addCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	 
	//모든 콤마 제거
	function removeCommas(x) {
	    if(!x || x.length == 0) return "";
	    else return x.split(",").join("");
	}


	function origin() {
		$('#price').css("border-color", "#EEEEEE");
		$('input[type="text"]').css("border-color", "#EEEEEE");
	}
		function completeStep3() {
			var price = $('input[name="price"]').val();
		
			   price = removeCommas(price);
			  
			if (!price || price == 0) {
				alert("가격을 입력해주세요.");
				$('input[name="price"]').val("");
				$('input[name="price"]').focus();
				return;
			}
			var params = {
				hostId : $('#hostId').val(),
				price :removeCommas(price),
			}
			$.ajax({
				type : "POST",
				url : "/p5/ajax/completeStep3",
				data : params,
				success : function(result) {
					if (result) {
				//		alert("호스트 등록 완료!");
						location.href = "finish?hostId=" + $('#hostId').val();
					} else {
						alert("완료 실패..");
					}
				},
				error : function() {
					alert("통신에 실패..");
				}
			}); // AJAX-END 
		
		}

		function modifyPrice() {
			var price = $('input[name="price"]').val();
			if (!price || price == 0) {
				alert("수정 가격을 입력해주세요.");
				$('input[name="price"]').val("");
				$('input[name="price"]').focus();
				return;
			}
			var params = {
				hostId : $('#hostId').val(),
				price : $('input[name="price"]').val()
			}
			$.ajax({
				type : "POST",
				url : "savePrice",
				data : params,
				success : function(result) {
					if (result) {
						alert("가격 수정 성공^^");
						location.href = "../hostingStatus?hostId="
								+ $('#hostId').val();
					} else {
						alert("가격 수정 실패..");
					}
				},
				error : function() {
					alert("통신에 실패..");
				}
			}); // AJAX-END
		}
	</script>
	<script>

	$("#input").on("focus", function() {
		
	    var x = $(this).val();
	    x = removeCommas(x);
	    $(this).val(x);
	}).on("focusout", function() {
	    var x = $(this).val();
	    if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        x = addCommas(x);
	        $(this).val(x);
	    }
	}).on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});



</script>




</body>

</html>



