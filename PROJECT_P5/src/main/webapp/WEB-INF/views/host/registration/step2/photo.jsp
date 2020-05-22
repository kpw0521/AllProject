<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 등록</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
	
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="/p5/css/reset.css" />
<link rel="stylesheet" href="/p5/css/photo.css" />
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<div id="photoPageWrap">
	<%@include file="./hostHeaderStep2.jsp"%>
	<div id="photoAjaxLoading">
		<img src="/p5/img/photoLoading.gif" alt="사진 없음" />
		<span>저장중...</span>
	</div>
	<script>
		//	$('.hosting-step').empty();
		//	$('.hosting-step').text("2단계:상세정보를 입력하세요");
		$('nav').css('grid-template-columns', 'repeat(3, 1fr)');
		$('#progressBar').val('10');

		$('#tabPhoto').css('background', '#bbb');
	</script>
	
	<div class="photoWrapTitle">
	<p class="title">숙소 사진 올리기</p>

	<button id="info">
		<i class="fa fa-lightbulb-o fa-3x" aria-hidden="true"></i>숙소 사진을 잘 찍는
		팁 
	</button>

	<div id="infoContent" class="info-modal">
		<div class="info-content">
			<span class="info-close">&times;</span>
			<p class="info-tip">멋진 숙소 사진을 위한 팁</p>
			<img src="/p5/img/info-first.png" alt="" class="info-img-first" />
			<p class="info-first">공간을 최대한 넓게 포착할 수 있도록 화면을 가로로 놓고 사진을 찍으세요.
				코너에서 찍으면 전체를 사진에 더 잘 담을 수 있습니다.</p>
			<br> <img src="/p5/img/info-second.png" alt="" class="second" />
			<p class="info-second">자연 채광으로 찍을 때 가장 멋진 사진이 나와요. 밤이면 조명을 켜주세요.
				플래시 사용은 피하는 게 좋습니다.</p>
			<br> <img src="/p5/img/info-third.png" alt="" class="third" />
			<p class="info-third">침실, 욕실, 거실 등 게스트가 사용할 공간을 모두 포함하세요.</p>
			<br />
			<p class="info-last">숙소를 등록한 후에 전문 사진 촬영 서비스를 요청할 수도 있습니다.</p>
			<button id="complete">완료</button>
		</div>
</div>
	
	<p class="tip-description">게스트가 사진을 보고 숙소의 느낌을 생생히 떠올려볼 수 있도록 해주세요.
		우선 사진 1장을 업로드하고 숙소를 등록한 후에 추가할 수 있습니다.</p>
</div>
	<div id="wrap">

		<div class="photoUpload">

			<!-- <label for="photoFiles">
            <img src="img/imgUpload.png" alt="" class="addPhoto" width="900px" height="600px"/>
          </label> -->

			<!-- <div id="mainPhoto">대표 이미지</div>
         <div class="photoList">
            <img src="img/bedroom.jpg" alt="" class="inputPhoto" />
            <img src="img/berry.jpg" alt="" class="inputPhoto" />
            <img src="img/flower.jpg" alt="" class="inputPhoto" />
            <img src="img/coffee.jpg" alt="" class="inputPhoto" />
            <img src="img/bread.jpg" alt="" class="inputPhoto" />
            <img src="img/hair.png" alt="" class="inputPhoto" />
            <img src="img/away.jpg" alt="" class="inputPhoto" />
            
         <label for="photoFiles">
            <img src="img/imgUpload2.png" alt="" class="addPhoto" />
         </label>
         </div> -->

		</div>
		<!-- photoUpload end -->


		<form id="uploadPhoto">
			<input type="hidden" id="hostId" name="hostId" value="${hostId }" />
			<input type="file" id="photoFiles" name="photoFiles" multiple
				accept="image/*" style="display: none" />
		</form>

		<div class="modalImgSlide">
			<!-- 사진 데이터 입력 시 반목문으로  >  .modalImgSlide[0] 아래로 append
         <div class="modalImg">
            <div class="modalImgNumber">(i값)/(전체 사진 갯수값)</div>
            <img src="이미지 링크" onclick="modalOff()">
         </div> -->

			<div class="modalImg">
				<div class="modalImgNumber">1 / 8</div>
				<img src="/p5/img/bedroom.jpg" onclick="modalOff()">
			</div>
			<div class="modalImg">
				<div class="modalImgNumber">2 / 8</div>
				<img src="/p5/img/berry.jpg" onclick="modalOff()">
			</div>
			<div class="modalImg">
				<div class="modalImgNumber">3 / 8</div>
				<img src="/p5/img/flower.jpg" onclick="modalOff()">
			</div>
			<div class="modalImg">
				<div class="modalImgNumber">4 / 8</div>
				<img src="/p5/img/coffee.jpg" onclick="modalOff()">
			</div>
			<div class="modalImg">
				<div class="modalImgNumber">5 / 8</div>
				<img src="/p5/img/bread.jpg" onclick="modalOff()">
			</div>
			<div class="modalImg">
				<div class="modalImgNumber">6 / 8</div>
				<img src="/p5/img/hair.png" onclick="modalOff()">
			</div>
			<div class="modalImg">
				<div class="modalImgNumber">7 / 8</div>
				<img src="/p5/img/away.jpg" onclick="modalOff()">
			</div>

			<div class="modalImgSlideButton">
				<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a
					class="next" onclick="plusSlides(1)">&#10095;</a>
			</div>

			<div class="modalImgThumbnails">
				<div class="modalImgThumbnail"></div>
			</div>

		</div>
		<!-- modalImgSlide end -->

	</div>
	<!-- wrap end -->
	<div class="photo-btn-group">
		<a href="../hostingStatus?hostId=${hostId }" class="previous-link" id="prevBtn">이전</a>
		<a href="./description?hostId=${hostId }" class="next-link" id="nextBtn">다음</a>
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function(){
		$(document).ajaxStart(function() {
			$('#photoAjaxLoading').show();
		});
		$(document).ajaxStop(function() {
			$('#photoAjaxLoading').fadeOut();
		})
		
		 $(document).on("dragstart",function(e) {
            return false;
        });
		
	}); 



	function apply() {
		$(".photoList").sortable({
			items : "img:not(.addPhoto)",

			// 정렬 후(내용 변동이 있으 시에)에 시행
			update : function(event, ui) {
				var sortResult = $(".photoList").sortable("toArray", {
					attribute : "data-id"
				});
				updateHostPhotoSort(sortResult);
			}
		});

		var menu = '<span class="photoButton first">'
				+ '<button onclick="deleteHostPhoto($(this).parent().prev().attr(\'data-id\'), $(this).parent().prev().attr(\'data-order\'))">'
				+ '<i class="fas fa-trash-alt fa-2x"></i></button>'
				+ '<button onclick="modalOn($(this).parent().prev().index())"><i class="fas fa-external-link-alt fa-2x"></i></button></span>';
		var menu2 = '<span class="photoButton">'
				+ '<button onclick="changeCoverImage($(this).parent().prev().attr(\'data-order\'))">'
				+ '<i class="fas fa-check"></i></button>'
				+ '<button onclick="deleteHostPhoto($(this).parent().prev().attr(\'data-id\'), $(this).parent().prev().attr(\'data-order\'))">'
				+ '<i class="fas fa-trash-alt"></i></button>'
				+ '<button onclick="modalOn($(this).parent().prev().index())"><i class="fas fa-external-link-alt"></i></button></span>';

		$(".inputPhoto").on({
			'mouseover' : function() {
				if ($(this).index() == "0") {
					$(".photoButton").detach();
					$(this).after(menu);
				} else {
					$(".photoButton").detach();
					$(this).after(menu2);
				}
			},
			'click' : function() {
				if ($(this).index() == "0") {
					$(".photoButton").detach();
					$(this).after(menu);
				} else {
					$(".photoButton").detach();
					$(this).after(menu2);
				}
			}
		})
	}

	/* 이미지 슬라이드 */
	var slideIndex = 1;
	showSildes(slideIndex);

	function showSildes(n) {
		var i;

		var Mslides = document.getElementsByClassName("modalImg");
		var MslidesList = document.getElementsByClassName("modalImgSlide");
		var Mthumb = document.getElementsByClassName("modalImgThumbnail");
		var MthumbList = document.querySelector(".modalImgThumbnails");

		if (n > Mslides.length) {
			slideIndex = 1;
		}
		if (n < 1) {
			slideIndex = Mslides.length;
		}

		for (var i = 0; i < Mthumb.length; i++) {
			Mthumb[i].className = Mthumb[i].className.replace(" active", "");
			Mthumb[i].style.display = "none";
		}

		for (var i = 0; i < Mslides.length; i++) {
			Mslides[i].style.display = "none";
		}

		Mslides[slideIndex - 1].style.display = "block";

		MthumbList.innerHTML = "";

		for (var i = -3; i < 2; i++) {
			if (slideIndex + i < 0) {
				MthumbList.innerHTML += '<div class="modalImgThumbnail"><img src="'
						+ Mslides[slideIndex + i + Mslides.length]
								.getElementsByTagName("img")[0].src
						+ '" onclick="currentSlide('
						+ (slideIndex + i + Mslides.length + 1) + ')" /></div>';
			} else if (slideIndex + i >= Mslides.length) {
				MthumbList.innerHTML += '<div class="modalImgThumbnail"><img src="'
						+ Mslides[slideIndex + i - Mslides.length]
								.getElementsByTagName("img")[0].src
						+ '" onclick="currentSlide('
						+ (slideIndex + i - Mslides.length + 1) + ')" /></div>';
			} else {
				MthumbList.innerHTML += '<div class="modalImgThumbnail"><img src="'
						+ Mslides[slideIndex + i].getElementsByTagName("img")[0].src
						+ '" onclick="currentSlide('
						+ (slideIndex + i + 1)
						+ ')" /></div>';
			}
		}
		Mthumb[2].className += " active";
	}

	function plusSlides(n) {
		showSildes(slideIndex += n);
	}

	function currentSlide(n) {
		showSildes(slideIndex = n);
	}

	/* 모달 이미지 */
	function modalOn(n) {
		var a = parseInt(n) + 1;
		slideIndex = a;
		showSildes(slideIndex);
		var modalImgSlide = document.getElementsByClassName("modalImgSlide");
		modalImgSlide[0].style.display = "block";
	}

	function modalOff() {
		var modalImgSlide = document.getElementsByClassName("modalImgSlide");
		modalImgSlide[0].style.display = "none";
	}

	//**************************** 백엔드 기능.. ***********************************************************
	$(window).bind("pageshow", function(event) {
		$.ajax({
			type : "POST",
			url : "/p5/ajax/isIdentified",
			data : "hostId=" + $('#hostId').val(),
			success : function(result) {
				if (!result) {
					alert("접근 권한이 없는 페이지입니다.");
					location.replace("/p5"); // 홈으로 이동
				}
			},
			error : function() {
				alert("접근 권한 확인에 실패..");
			}
		}); // AJAX-END
	});
	$(function() {
		// 화면에 사진 출력
		showHostPhoto();

		// 파일 드롭 다운
		fileDropDown();
	});

	// 사진 출력
	function showHostPhoto() {
		var hostPhoto = $(".photoUpload");
		var hostPhotoModal = $(".modalImgSlide");

		$
				.ajax({
					type : "POST",
					url : '/p5/ajax/getHostPhotoList',
					data : 'hostId=' + $('#hostId').val(),
					async : true,
					success : function(photoList) {
						if (!photoList.length) { // 출력할 사진이 없다면
							hostPhoto.empty(); // 비우고

							// 큰 버튼 하나만
							var result = '   <label for="photoFiles">   '
									+ '      <img src="/p5/img/imgUpload.png" alt="" class="addPhoto" width="900px" height="600px"/>   '
									+ '    </label>   ';

							hostPhoto.append(result); // 영역에 생성

						} else { // 출력할 게 있으면
							hostPhoto.empty(); // 비우고
							hostPhotoModal.empty(); // modal 역시 비움

							//************************** 머리 ***************************************      
							// 사진
							var photoResult = '   <div id="mainPhoto">대표 이미지</div>   '
									+ '     <div class="photoList">   ';

							// modal
							var modalResult = '';
							//************************** 머리-END **********************************      

							//************************** 몸통 제조(반복문) ********************************
							// 사진 개수
							var total = photoList.length;
							$
									.each(
											photoList,
											function(i, photo) {
												// 화면에 출력되는 사진
												photoResult += '   <img src="' + photo.path + '" alt="' + photo.originalName + '"'
                 +'   data-id="' + photo.id + '" data-order="' + photo.sortOrder + '" class="inputPhoto" />   ';

												i++;
												// modal의 사진
												modalResult += '   <div class="modalImg">   '
														+ '      <div class="modalImgNumber">'
														+ i
														+ '/'
														+ total
														+ '</div>   '
														+ '      <img src="'
														+ photo.path
														+ '" onclick="modalOff()">   '
														+ '   </div>   ';
											});
							//************************** 몸통 제조(반복문)-END ********************************      

							//******************************** 꼬리 달기 ****************************************
							photoResult += '   <label for="photoFiles">   '
									+ '      <img src="/p5/img/imgUpload2.png" alt="" class="addPhoto last" id="upload" />   '
									+ '   </label>   ' + '   </div>   ';

							modalResult += '   <div class="modalImgSlideButton">   '
									+ '        <a class="prev" onclick="plusSlides(-1)">&#10094;</a>   '
									+ '        <a class="next" onclick="plusSlides(1)">&#10095;</a>   '
									+ '    </div>   '
									+ '  <div class="modalImgThumbnails">   '
									+ '         <div class="modalImgThumbnail"></div>   '
									+ '  </div>      ';
							//******************************** 꼬리 달기-END ****************************************               

							// 내용 갱신
							hostPhoto.append(photoResult);
							hostPhotoModal.append(modalResult);

						} // else-END

						apply(); // 기능 적용**
					},
					error : function(e) {
						alert("통신 실패..");
					}
				});
	} // showHostPhoto-END

	// 선택 파일 업로드
	$("#photoFiles").on("change", function() {
		if (!$('#photoFiles').val()) {
			return;
		}

		var formData = new FormData($('#uploadPhoto')[0]);
		addHostPhoto(formData);

		$('#photoFiles').val(""); // 초기화
	});

	// 파일 드롭 다운
	function fileDropDown() {
		var dropZone = $(".photoUpload");
		//Drag기능
		dropZone.on('dragenter', function(e) {
			e.stopPropagation();
			e.preventDefault();
			// 드롭다운 영역 css
			dropZone.css('background-color', '#eee');
		});
		dropZone.on('dragleave', function(e) {
			e.stopPropagation();
			e.preventDefault();
			// 드롭다운 영역 css
			dropZone.css('background-color', '#FFFFFF');
		});
		dropZone.on('dragover', function(e) {
			e.stopPropagation();
			e.preventDefault();
			// 드롭다운 영역 css
			dropZone.css('background-color', '#eee');
		});
		dropZone.on('drop', function(e) {
			e.preventDefault();
			// 드롭다운 영역 css
			dropZone.css('background-color', '#FFFFFF');

			var files = e.originalEvent.dataTransfer.files;

			if (files != null) {
				if (files.length < 1) {
					alert("파일이 없습니다.");
					return;
				}

				// 확장자 유효성 검사
				for (i = 0; i < files.length; i++) {
					if (!files[i].type.match("image/*")) {
						alert("이미지 파일만 가능합니다.");
						return;
					}
				}
			} else {
				alert("에러..");
			}

			var formData = new FormData();
			formData.append('hostId', $('#hostId').val());
			for (i = 0; i < files.length; i++) {
				formData.append('photoFiles', files[i]);
			}

			addHostPhoto(formData);
		});
	}

	// 사진 추가(서버와 DB에 저장)
	function addHostPhoto(formData) {
		$.ajax({

			type : "POST",
			url : '/p5/ajax/addHostPhoto',
			enctype : 'multipart/form-data', // 필수 
			data : formData, // 필수 
			processData : false, // 필수 
			contentType : false, // 필수
			cache : false,
			async : false,
			success : function(result) {
				if (result) { // 성공
					showHostPhoto(); // 사진 갱신
				} else {
					alert("사진 추가 실패..");
				}
			},
			error : function(e) {
				alert("통신 실패");
			}
		});
	}

	// 사진 삭제 
	function deleteHostPhoto(photoId, photoOrder) {
		var params = {
			photoId : photoId,
			photoOrder : photoOrder,
			photoCount : $(".inputPhoto").length,
			hostId : $('#hostId').val()
		}
		//   alert(JSON.stringify(params));
		$.ajax({
			type : "POST",
			url : '/p5/ajax/deleteHostPhoto',
			data : params,
			async : false,
			success : function(result) { // boolean 결과
				if (result) { // 성공
					showHostPhoto(); // 사진 갱신
				} else {
					alert("사진 삭제 실패..");
				}
			},
			error : function(e) {
				alert("통신 실패");
			}
		});
	}

	// 정렬 결과를 DB에 적용
	function updateHostPhotoSort(sortResult) {

		$.ajax({
			type : "POST",
			url : '/p5/ajax/updateHostPhotoSort',
			data : 'sortResult=' + sortResult,
			async : false,
			success : function(result) { // boolean 결과
				//         alert(result);
				showHostPhoto(); // 사진 갱신
			},
			error : function(e) {
				alert("통신 실패");
			}
		});
	}

	// 대표 이미지 바꾸기
	function changeCoverImage(choiceOrder) {
		var choiceId = $('img[data-order="' + choiceOrder + '"]').attr(
				"data-id");
		var coverId = $('img[data-order="1"]').attr("data-id");

		var params = { // 보따리
			choiceId : choiceId, // 선택 이미지의 ID
			coverId : coverId, // 대표 이미지의 ID
			choiceOrder : choiceOrder
		// 선택 이미지의 순번
		}

		$.ajax({
			type : "POST",
			url : '/p5/ajax/changeCoverImage',
			data : params,
			async : false,
			success : function(result) { // boolean 결과
				if (result) {
					showHostPhoto(); // 사진 갱신
				} else {
					alert("대표 이미지 바꾸기 실패..");
				} 

			},
			error : function(e) { 
				alert("통신 실패");
			}
		});
	}
</script>
<script>
	// Get the modal
	var modal = document.getElementById("infoContent");

	// Get the button that opens the modal
	var btn = document.getElementById("info");

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("info-close")[0];
	var btn2 = document.getElementById("complete")

	// When the user clicks the button, open the modal 
	btn.onclick = function() {
		modal.style.display = "block";
	}

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
		modal.style.display = "none";
	}
	btn2.onclick = function() {
		modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}
</script>
</html>
