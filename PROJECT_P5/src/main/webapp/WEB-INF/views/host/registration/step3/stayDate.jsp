<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙박일</title>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<link rel="stylesheet" href="/p5/css/stayDate.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
</head>
<style>
#minium-warning {
	display: block;
}
</style>
<body>
	<input type="hidden" id="hostId" value="${hostId }" />
	<%@include file="./hostHeaderStep3.jsp"%>

	<script>
		//	$('.hosting-step').empty(); // 없어도 됨
		//	$('.hosting-step').text("3단계 : 최소, 최대 숙박일을 설정하세요");
		$('nav').css('grid-template-columns', 'repeat(3, 1fr)');
		$('#progressBar').val('10');

		$('#tabStayDate').css('background', '#bbb');
	</script>



	<div id="wrap">
		<div id="container">

			<h1>게스트가 얼마 동안 숙박할 수 있나요?</h1>
			<div id="minimum">
				<input type="number" name="minimumStay" class="minimum-date"
					value="1" /><span class="text-info">박(최소)</span>
				<button id="minimum-date-decrease-quantity">-</button>
				<button id="minimum-date-increase-quantity">+</button>
				<br>
				<div id="minium-warning"></div>
			</div>
			<div id="maximum">
				<input type="number" name="maximumStay" class="maximum-date"
					value="1" /><span class="text-info">박(최대)</span>
				<button id="maximum-date-decrease-quantity">-</button>
				<button id="maximum-date-increase-quantity">+</button>
				<br>
				<p class="tip">
					<span class="tip">팁:</span> 숙박 기간이 짧으면 예약을 더 많이 받을 수 있지만, 그만큼 예약을
					자주 받아야 합니다.
				</p>
			</div>
			
			<div class="btn-group">
				<a class="previous-link click-to-save" href="../hostingStatus?hostId=${hostId }" id="prevBtn">이전</a> 
				<a onclick="check()" class="next-link click-to-save" id="nextBtn">다음</a>
			</div>
		</div>
		<div id="left">


			<div class="progress-container ">
				<div class="progress-bar round-xlarge teal" style="width: 40%">
					<img src="/p5/img/stayDateAvatar.png" class="avatar" alt="" />
				</div>

			</div>
			<span class="min">1박</span> <span class="max">1박</span>
		</div>
	</div>
	<script src="/p5/js/host.js?v=<%=System.currentTimeMillis()%>"></script>
	
	
</body>
<script>


function check() {
	var check = $('#minium-warning').text();
    
    var check1 = $('input[name=maximumStay]').val();
   var check2=$('input[name="minimumStay"]').val();
    console.log(check);
  
    if(check2>check1||check1==""||check2=="") {
      alert("잘못된 정보입니다");
    
     
        return false; //
    }
    else {
    	location.href="./calendar?hostId=${hostId }";
    }
}
$('input[name="minimumStay"]').keyup(function (e) {

	var stat = $('.minimum-date').val();
	var num = parseInt(stat, 10);

	var a = $(".maximum-date").val();
	var num2 = parseInt(a, 10);
/*최소숙박일이 더크면 경고창 띄운다  */
	  if (num>num2) {
		  
		  $('#minium-warning').html("<i class=\'fa fa-exclamation-circle fa-2x\' aria-hidden=\'true\'></i><br>최소 숙박일수는 최대 숙박일수를 넘을 수 없습니다.");
			$('#minium-warning').css("background-color","#FFD1C4");
			$('#minium-warning').show();
			$('#maximum').css("margin-top","150px");
			$('#minimum').css("border-color","#FFD1C4");
			$('#minimum').css("background-color","#FFF5F2");
			$('.minimum-date').css("background-color","#FFF5F2");
			$('#minimum-date-decrease-quantity').css("background-color","#FFF5F2");
			$('#minimum-date-increase-quantity').css("background-color","#FFF5F2");
			num=num2;
		return;
	  }
	  else{
		  

			$('#minium-warning').css("background-color","white");
			$('#minium-warning').hide();
			$('#minium-warning').text("");
			$('#maximum').css("margin-top","0px");
			$('#minimum').css("border-color","#dce0e0");
			$('#minimum').css("background-color","white");
			$('.minimum-date').css("background-color","white");
			$('#minimum-date-decrease-quantity').css("background-color","white");
			$('#minimum-date-increase-quantity').css("background-color","white");
	  }
	
	$('.minimum-date').val(num);
	$(".min").text(num+"박");

});
	
$('input[name="maximumStay"]').keyup(function (e) {

	e.preventDefault();
	var stat = $('.maximum-date').val();
	var num = parseInt(stat, 10);

	var b=$('.minimum-date').val();
	var num2= parseInt(b, 10);
	  if (num<num2) {
		  
		  $('#minium-warning').html("<i class=\'fa fa-exclamation-circle fa-2x\' aria-hidden=\'true\'></i><br>최소 숙박일수는 최대 숙박일수를 넘을 수 없습니다.");
			$('#minium-warning').css("background-color","#FFD1C4");
			$('#minium-warning').show();
			$('#maximum').css("margin-top","150px");
			$('#minimum').css("border-color","#FFD1C4");
			$('#minimum').css("background-color","#FFF5F2");
			$('.minimum-date').css("background-color","#FFF5F2");
			$('#minimum-date-decrease-quantity').css("background-color","#FFF5F2");
			$('#minimum-date-increase-quantity').css("background-color","#FFF5F2");
			
			
		return;
	  }
	  else{
		  

			$('#minium-warning').css("background-color","white");
			$('#minium-warning').hide();
			$('#maximum').css("margin-top","0px");
			$('#minimum').css("border-color","#dce0e0");
			$('#minimum').css("background-color","white");
			$('.minimum-date').css("background-color","white");
			$('#minimum-date-decrease-quantity').css("background-color","white");
			$('#minimum-date-increase-quantity').css("background-color","white");
			$('#minium-warning').text("");
	  }
	$('.maximum-date').val(num);
	$(".max").text(num+"박");
});


	

	/*최소숙박 */
	$(function() {
		$('#minimum-date-decrease-quantity').click(function(e) {
			e.preventDefault();
			var stat = $('.minimum-date').val();
			
			var num = parseInt(stat, 10);
			num--;
			var a = $(".maximum-date").val();
			var num2 = parseInt(a, 10);
		/*최소숙박일이 더크면 경고창 띄운다  */
			 	  if (num>num2) {
				  
				  $('#minium-warning').html("<i class=\'fa fa-exclamation-circle fa-2x\' aria-hidden=\'true\'></i><br>최소 숙박일수는 최대 숙박일수를 넘을 수 없습니다.");
					$('#minium-warning').css("background-color","#FFD1C4");
					$('#minium-warning').show();
					$('#maximum').css("margin-top","150px");
					$('#minimum').css("border-color","#FFD1C4");
					$('#minimum').css("background-color","#FFF5F2");
					$('.minimum-date').css("background-color","#FFF5F2");
					$('#minimum-date-decrease-quantity').css("background-color","#FFF5F2");
					$('#minimum-date-increase-quantity').css("background-color","#FFF5F2");
					
				return;
			  }
			  else{
				  

					$('#minium-warning').css("background-color","white");
					$('#minium-warning').hide();
					$('#maximum').css("margin-top","0px");
					$('#minimum').css("border-color","#dce0e0");
					$('#minimum').css("background-color","white");
					$('.minimum-date').css("background-color","white");
					$('#minimum-date-decrease-quantity').css("background-color","white");
					$('#minimum-date-increase-quantity').css("background-color","white");
			  }
			 		if (num <= 0) {
						/* 	alert("더이상 줄일수 없습니다") */
						num = 1;

					}
			$('.minimum-date').val(num);
			$(".min").text(num+"박");
		});
		$('#minimum-date-increase-quantity').click(function(e) {
			e.preventDefault();
			var stat = $('.minimum-date').val();
			
			var num = parseInt(stat, 10);
			num++;
			var a = $(".maximum-date").val();
			var num2 = parseInt(a, 10);
		
			  if (num>num2) {
				  
				  $('#minium-warning').html("<i class=\'fa fa-exclamation-circle fa-2x\' aria-hidden=\'true\'></i><br>최소 숙박일수는 최대 숙박일수를 넘을 수 없습니다.");
					$('#minium-warning').css("background-color","#FFD1C4");
					$('#minium-warning').show();
					$('#maximum').css("margin-top","150px");
					$('#minimum').css("border-color","#FFD1C4");
					$('#minimum').css("background-color","#FFF5F2");
					$('.minimum-date').css("background-color","#FFF5F2");
					$('#minimum-date-decrease-quantity').css("background-color","#FFF5F2");
					$('#minimum-date-increase-quantity').css("background-color","#FFF5F2");
					
				return;
			  }
			  else{
				  

					$('#minium-warning').css("background-color","white");
			
					$('#maximum').css("margin-top","0px");
					$('#minimum').css("border-color","#dce0e0");
					$('#minimum').css("background-color","white");
					$('.minimum-date').css("background-color","white");
					$('#minimum-date-decrease-quantity').css("background-color","white");
					$('#minimum-date-increase-quantity').css("background-color","white");
					$('#minium-warning').html("");
					$('#minium-warning').hide();

			  }
			
			$('.minimum-date').val(num);
			$(".min").text(num+"박");
		});
	});
	/*최대숙박 */
	$(function() {
		$('#maximum-date-decrease-quantity').click(function(e) {
			e.preventDefault();
			var stat = $('.maximum-date').val();
			var num = parseInt(stat, 10);
			num--;
			var b=$('.minimum-date').val();
			var num2= parseInt(b, 10);
			  if (num<num2) {
				  
				  $('#minium-warning').html("<i class=\'fa fa-exclamation-circle fa-2x\' aria-hidden=\'true\'></i><br>최소 숙박일수는 최대 숙박일수를 넘을 수 없습니다.");
					$('#minium-warning').css("background-color","#FFD1C4");
					$('#minium-warning').show();
					$('#maximum').css("margin-top","150px");
					$('#minimum').css("border-color","#FFD1C4");
					$('#minimum').css("background-color","#FFF5F2");
					$('.minimum-date').css("background-color","#FFF5F2");
					$('#minimum-date-decrease-quantity').css("background-color","#FFF5F2");
					$('#minimum-date-increase-quantity').css("background-color","#FFF5F2");
					
				return;
			  }
			  else{
				  

					$('#minium-warning').css("background-color","white");
					$('#minium-warning').hide();
					$('#maximum').css("margin-top","0px");
					$('#minimum').css("border-color","#dce0e0");
					$('#minimum').css("background-color","white");
					$('.minimum-date').css("background-color","white");
					$('#minimum-date-decrease-quantity').css("background-color","white");
					$('#minimum-date-increase-quantity').css("background-color","white");
					$('#minium-warning').text("");
			  }
			if (num <= 0) {
				/* 	alert("더이상 줄일수 없습니다") */
				num = 1;

			}
			$('.maximum-date').val(num);
			$(".max").text(num+"박");
			
		});
		$('#maximum-date-increase-quantity').click(function(e) {
			e.preventDefault();
			var stat = $('.maximum-date').val();
			var num = parseInt(stat, 10);
			num++;
			var b=$('.minimum-date').val();
			var num2= parseInt(b, 10);
			  if (num<num2) {
				  
				  $('#minium-warning').html("<i class=\'fa fa-exclamation-circle fa-2x\' aria-hidden=\'true\'></i><br>최소 숙박일수는 최대 숙박일수를 넘을 수 없습니다.");
					$('#minium-warning').css("background-color","#FFD1C4");
					$('#minium-warning').show();
					$('#maximum').css("margin-top","150px");
					$('#minimum').css("border-color","#FFD1C4");
					$('#minimum').css("background-color","#FFF5F2");
					$('.minimum-date').css("background-color","#FFF5F2");
					$('#minimum-date-decrease-quantity').css("background-color","#FFF5F2");
					$('#minimum-date-increase-quantity').css("background-color","#FFF5F2");
					
				return;
			  }
			  else{
				  

					$('#minium-warning').css("background-color","white");
					$('#maximum').css("margin-top","0px");
					$('#minimum').css("border-color","#dce0e0");
					$('#minimum').css("background-color","white");
					$('.minimum-date').css("background-color","white");
					$('#minimum-date-decrease-quantity').css("background-color","white");
					$('#minimum-date-increase-quantity').css("background-color","white");
					$('#minium-warning').html("");
					$('#minium-warning').hide();
			  }
			$('.maximum-date').val(num);
			$(".max").text(num+"박");
		});
	});


	function funcThisSize() {
	    $("#innerWidth").html( window.innerWidth );
	    $("#innerHeight").html( window.innerHeight );
	    $("#outerWidth").html( window.outerWidth );
	    $("#outerHeight").html( window.outerHeight );
	}

	$(function(){
	    $(window).resize( funcThisSize );
	    funcThisSize();
	});

</script>
</html>