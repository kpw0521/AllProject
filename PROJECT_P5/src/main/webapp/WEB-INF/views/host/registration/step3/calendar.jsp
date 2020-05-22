<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" type="image/png" href="mdp-icon.png">
<!--[if IE]><link rel="shortcut icon" href="favicon.ico" /><![endif]-->
<title>예약 차단 설정</title>
<script src="/p5/js/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/p5/css/reservationCalendar.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- <link rel="stylesheet" href="https://cdn.rawgit.com/dubrox/Multiple-Dates-Picker-for-jQuery-UI/master/jquery-ui.multidatespicker.css" /> -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<Style>
.abled {
	display: none;
}

.step-tab {
	height: auto !important;
}
</Style>
</head>
<body>
	<input type="hidden" id="hostId" value="${hostId }" />
	<%@include file="./hostHeaderStep3.jsp"%>
	<div id="photoAjaxLoading">
		<img src="/p5/img/photoLoading.gif" alt="사진 없음" /> <span>저장중...</span>
	</div>

	<script>
		//	$('.hosting-step').empty(); // 없어도 됨
		//	$('.hosting-step').text("3단계 : 예약 차단일을 설정하세요");
		$('nav').css('grid-template-columns', 'repeat(3, 1fr)');
		$('#progressBar').val('50');

		$('#tabCalender').css('background', '#bbb');
	</script>
	<div id="wrap">
		<div class="info-container">
			<i class="fa fa-lightbulb-o fa-3x" aria-hidden="true"></i><span
				onclick="toggle()" class="close">X</span><br />게스트는 달력을 보고 예약 가능한
			날짜에 예약 요청을 보냅니다.
			<hr />
			<br /> <img src="/p5/img/calendar-info.png" alt="" />호스팅을 원하는 날짜를
			클릭하여 차단하세요.
		</div>
		<button class="info">
			<i class="fa fa-lightbulb-o fa-3x" aria-hidden="true"></i>
		</button>

		<span class="tip">달력을 업데이트하세요.</span><br />
		<div class="description">예약을 차단하거나 차단 해제할 날짜를 선택하세요.</div>

		<button id="manageMonth" onclick="manageMonth();">전체 차단/해제</button>
		
		<div id="mdp-demo"></div>


		<div class="calendar-btn-group">
			<a href="./stayDate?hostId=${hostId }" id="prevBtn">이전</a>
			<a href="./price?hostId=${hostId }" id="nextBtn">다음</a>
		</div>
		<!-- <input type="submit" value="다음" /> -->

	</div>
	<script src="/p5/js/jquery-ui.min.js"></script>
	<script src="/p5/js/Calendar.js?v=<%=System.currentTimeMillis()%>"></script>
</body>
<script>
	$(document).ready(function() {
		$(document).ajaxStart(function() {
			$('#photoAjaxLoading').show();
		});
		$(document).ajaxStop(function() {
			$('#photoAjaxLoading').fadeOut();
		})

	});

	$('#mdp-demo').multiDatesPicker({
		dateFormat : "yy.mm.dd",
		//	altField : '#altField',
		minDate : 0, // today
		maxDate : "+2m" // +2 months from today
	});

	$(window).bind("pageshow", function(event) {
		$.ajax({
			type : "POST",
			url : "/p5/ajax/isIdentified",
			data : "hostId=" + hostId,
			success : function(result) {
				if (!result) {
					alert("접근 권한이 없는 페이지입니다.");
					location.replace("/p5"); // 홈으로 이동
				} else {
					refresh(); // 화면 갱신
				}
			},
			error : function() {
				alert("접근 권한 확인에 실패..");
			}
		}); // AJAX-END
	});

	/* month = $('.ui-datepicker-title>span.ui-datepicker-month').text();
	year = $('.ui-datepicker-title>span.ui-datepicker-year').text();
	var m;
	switch (month) {
	case 'January':
		m = 1;
		break;
	case 'February':
		m = 2;
		break;
	case 'March':
		m = 3;
		break;
	case 'April':
		m = 4;
		break;
	case 'May':
		m = 5;
		break;
	case 'June':
		m = 6;
		break;
	case 'July':
		m = 7;
		break;
	case 'Agust':
		m = 8;
		break;
	case 'September':
		m = 9;
		break;
	case 'Ocotber':
		m = 10;
		break;
	case 'November':
		m = 11;
		break;
	case 'December':
		m = 12;
		break;
	}
	alert(year + '.' + m);
	alert($('#altField').val());
	$('#mdp-demo').multiDatesPicker('resetDates', 'picked');
	$('td').removeClass('ui-state-highlight');
	$('a').removeClass('ui-state-active');
	/* 	$('a').addClass('ui-state-default');  */
	//	$('td').addClass('');
	/* 	$('#mdpDisabled').show();
		$('#mdpAbled').hide(); */
	//	}); */
	/*전체차단  */

	/*	year = $('.ui-datepicker-year').text();
		m = $('.ui-datepicker-month').text();
		
		var minDate = new Date();

		var b = new Date();
		var a = new Date();
		var m;
		switch (month) {
		case 'January':
			m = 1;
			break;
		case 'February':
			m = 2;
			break;
		case 'March':
			m = 3;
			break;
		case 'April':
			m = 4;
			break;
		case 'May':
			m = 5;
			break;
		case 'June':
			m = 6;
			break;
		case 'July':
			m = 7;
			break;
		case 'Agust':
			m = 8;
			break;
		case 'September':
			m = 9;
			break;
		case 'Ocotber':
			m = 10;
			break;
		case 'November':
			m = 11;
			break;
		case 'December':
			m = 12;
			break;
		}
		alert(m);
		b.setMonth(m);
		a.setMonth(m);
		var arr = new Array();
		var maxDate = new Date();
		maxDate.setMonth(minDate.getMonth() + 2);
		var lastDate = (new Date(2020, m, 0)).getDate();

		
		alert(lastDate); */
	/* for (i = 0; i < 31 - a.getDate(); i++) {
		if(31 - a.getDate()<0){
			break;
		}
	
		if(i==0){
			
		arr.push(b.setDate(a.getDate()+1));
		alert(b.setDate(a.getDate()+1));
		}
		else{
			arr.push(b.setDate(b.getDate()+1));
			alert(b.setDate(a.getDate()+1));
		} 
		console.log(arr[i]);
	} */

	/*7월달  */
	/* 	if (7 == b.getMonth()) {
			for (i = 0; i < maxDate.getDate(); i++) {

				if (lastDate == 30 && i == 31)
					break;

				arr.push(b.setDate(i));

			}
		}

		else if (6 == b.getMonth()) {
			for (i = 1; i < 32; i++) {

				if (lastDate == 30 && i == 31)
					break;
				if (i < b.getDate() && m == 5) {
					b.setMonth(m - 1);
					continue;

				}

				if (m == 6) {
					b.setMonth(m - 1);

				}

				arr.push(b.setDate(i));
				console.log(new Date(b.setDate(i)));

			}
		}

		else {
			for (i = 0; i < 32; i++) {

				if (lastDate == 30 && i == 31)
					break;
				if (i < b.getDate() && m == 5) {
					b.setMonth(m - 1);
					continue;

				}

				arr.push(b.setDate(i));
				console.log(new Date(b.setDate(i)));

			}
		}

		/*0인덱스에 31부터 시작하는 것을 1로 시작해 넣지않기로함  */
	/* if (m == 7) {
		for (i = 1; i < arr.length; i++) {

			$('#mdp-demo').multiDatesPicker({
				addDates : [ new Date(arr[i]) ]

			});

			$('td').addClass('ui-state-highlight');
			$('a').addClass('ui-state-active');
		}

		alert($('#altField').val());
		$('#mdpDisabled').hide();
		$('#mdpAbled').show();

	} else {
		for (i = 0; i < arr.length; i++) {

			$('#mdp-demo').multiDatesPicker({
				addDates : [ new Date(arr[i]) ]

			});

			$('td').addClass('ui-state-highlight');
			$('a').addClass('ui-state-active');
		}

		alert($('#altField').val());

		$('#mdpDisabled').hide();
		$('#mdpAbled').show();
	}
	}); */

	$(function() {
		$('.fa.fa-lightbulb-o.fa-3x').click(function(e) {
			$(".info").hide();
			$(".info-container").show();

		});
	});
	function toggle() {
		$(".info").show();
		$(".info-container").hide();
	}
</script>

</html>

