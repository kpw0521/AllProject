


	var presentURL = window.document.URL;
	var start = presentURL.indexOf("/p5");
	var end = presentURL.length;
	var urlInfo = presentURL.substring(start, end);

	var hostId = $('#hostId').val();
	
		// 알아서 저장하겠다우~
	/*$(window).bind("pagehide", function (event) {
		var params = setParams(); // 저장할 정보를 담은 보따리를 받아서
			if(!params){return;} // 유효성에 어긋나면 저장 안함
		var url = setSaveURL(); // 정보를 처리할 적절한 곳으로 보낸다.
		$.ajax({
			type : "POST",
			url : url,
			data : params
		}); // AJAX-END
	});*/

	
		// 최신 정보만 보여주게써~
	$(window).bind("pageshow", function (event) {
	//	alert(urlInfo);
		var url = setRefreshURL();
		if(url == './getNewHost'){
			ajaxRefresh(url);
		} else{
			$.ajax({
				type : "POST",
				url : "/p5/ajax/isIdentified",
				data : "hostId=" + hostId,
				success : function(result){
					if(!result){ // 접근 권한이 없으면
						alert("접근 권한이 없는 페이지입니다.");
						location.replace("/p5"); // 홈으로 이동
					} else{ // 접근 권한 통과하면 화면 갱신 수행
						ajaxRefresh(url);
					}
				},	
				error : function(){
					alert("로그아웃 되신 듯..");
					location.replace("/p5"); // 홈으로 이동
				}
			}); // AJAX-END
		}
	});
	
$('.click-to-save').on('click', function(){
	saveParams();
});
function saveParams(){
	var params = setParams(); // 저장할 정보를 담은 보따리를 받아서
		if(!params){return;} // 유효성에 어긋나면 저장 안함
	var url = setSaveURL(); // 정보를 처리할 적절한 곳으로 보낸다.
	$.ajax({
		type : "POST",
		url : url,
		data : params
	}); // AJAX-END
}
	
function ajaxRefresh(url){
	$.ajax({
		type : "POST",
		url : url,
		data : "hostId=" + hostId,
		success : function(host){
//			alert(JSON.stringify(host)); // 내용 확인
			refresh(host); // 화면 갱신
		},	
		error : function(){
			alert("화면 갱신에 실패..");
		}
	}); // AJAX-END
}

	
//////////////////////////////// setParams ///////////////////////////////////////////
function setParams(){
	
	var address = $('input[name="address"]').val();
	var name = $('input[name="name"]').val();
	var price = $('input[name="price"]').val();
	
//========================= facilities.jsp 값 세팅 ======================================
	var isTv = 'N';
	var isWifi = 'N';
	var isAirConditioner = 'N';
	var isAirPurifier = 'N';
	var	isHairDryer = 'N';
	var	isIron = 'N';
		
	var	isKitchen = 'N';
	var	isWashingMachine = 'N';
	var	isElevator = 'N';
	var	isParkingLot = 'N';
		
	if($('input:checkbox[name="isTv"]').is(":checked") == true) {isTv = 'Y';}
	if($('input:checkbox[name="isWifi"]').is(":checked") == true) {isWifi = 'Y';}
	if($('input:checkbox[name="isAirConditioner"]').is(":checked") == true) {isAirConditioner = 'Y';}
	if($('input:checkbox[name="isAirPurifier"]').is(":checked") == true) {isAirPurifier = 'Y';}
	if($('input:checkbox[name="isHairDryer"]').is(":checked") == true) {isHairDryer = 'Y';}
	if($('input:checkbox[name="isIron"]').is(":checked") == true) {isIron = 'Y';}
	
	if($('input:checkbox[name="isKitchen"]').is(":checked") == true) {isKitchen = 'Y';}
	if($('input:checkbox[name="isWashingMachine"]').is(":checked") == true) {isWashingMachine = 'Y';}
	if($('input:checkbox[name="isElevator"]').is(":checked") == true) {isElevator = 'Y';}
	if($('input:checkbox[name="isParkingLot"]').is(":checked") == true) {isParkingLot = 'Y';}
//====================================================================================================
	

//******************************* params 세팅 *****************************************

	var paramsRoomType = { // roomType.jsp
			hostId : hostId,
			hostTypeId : $('select[name="hostTypeId"]').val(),
			roomTypeId : $('select[name="roomTypeId"]').val()
	};
	var paramsRoomCount = { //roomCount.jsp
			hostId : hostId,
			capacity : $('input[name="capacity"]').val(),
			roomCount : $('input[name="roomCount"]').val(),
			bedCount : $('input[name="bedCount"]').val(),
			bathroomCount : $('input[name="bathroomCount"]').val()
	};
	var paramsAddress = { // address.jsp
			hostId : hostId,
			address : address,
			latitude : $('input[name="latitude"]').val(),
			longitude : $('input[name="longitude"]').val()
	};
	var paramsFacilities = { // facilities.jsp
			hostId : hostId,
			isTv : isTv,
			isWifi : isWifi,
			isAirConditioner : isAirConditioner,
			isAirPurifier : isAirPurifier,
			isHairDryer : isHairDryer,
			isIron : isIron,
			
			isKitchen : isKitchen,
			isWashingMachine : isWashingMachine,
			isElevator : isElevator,
			isParkingLot : isParkingLot
	};
	var paramsDescription = { // description.jsp
			hostId : hostId,
			description : $('textarea[name="description"]').val(),
			descriptionEtc : $('textarea[name="descriptionEtc"]').val()
	};
	var paramsName = { // name.jsp
			hostId : hostId,
			name : name
	};
	var paramsStayDate = { // stayDate.jsp
			hostId : hostId,
			minimumStay : $('input[name="minimumStay"]').val(),
			maximumStay : $('input[name="maximumStay"]').val()
	};
	var paramsPrice = { // price.jsp
			hostId : hostId,
			price : price
	};
	
//****************************** params 세팅-END *****************************************
	
	
	if(urlInfo == '/p5/host/registration/roomType' || urlInfo.indexOf('/p5/host/modification/roomType') !== -1)
	{return paramsRoomType;}
	if(urlInfo == '/p5/host/registration/roomCount' || urlInfo.indexOf('/p5/host/modification/roomCount') !== -1)
	{return paramsRoomCount;}
	if(urlInfo == '/p5/host/registration/address' || urlInfo.indexOf('/p5/host/modification/address') !== -1)
	{if(!address){return false;} // 주소는 '완료'상태가 아니면 저장 안함
	return paramsAddress;}
	if(urlInfo == '/p5/host/registration/facilities' || urlInfo.indexOf('/p5/host/modification/facilities') !== -1)
	{return paramsFacilities;}
	
	if(urlInfo.indexOf('/p5/host/registration/description') !== -1 || urlInfo.indexOf('/p5/host/modification/description') !== -1)
	{return paramsDescription;}
	if(urlInfo.indexOf('/p5/host/registration/name') !== -1){return false;} // 2단계 등록 마지막 페이지에서는 자동 저장 사용 안함
	if(urlInfo.indexOf('/p5/host/modification/name') !== -1){if(!name.trim()){return false;} return paramsName;} // 수정 때도 내용 없으면 저장 안함
	
	if(urlInfo.indexOf('/p5/host/registration/stayDate') !== -1 || urlInfo.indexOf('/p5/host/modification/stayDate') !== -1)
	{return paramsStayDate;}
	if(urlInfo.indexOf('/p5/host/registration/price') !== -1 || urlInfo.indexOf('/p5/host/modification/price') !== -1)
	{return false;} // 3단계 마지막 페이지(가격)에서는 자동 저장 사용 안함
	

}//////////////////////////////////// setParams-END //////////////////////////////////////////











//////////////////////////////////////// setSaveURL /////////////////////////////////////////////
function setSaveURL(){

	// 등록 1단계에서 보낼 URL(newHost 세션 사용)
	if(urlInfo == '/p5/host/registration/roomType'
	|| urlInfo == '/p5/host/registration/roomCount'
	|| urlInfo == '/p5/host/registration/address'
	|| urlInfo == '/p5/host/registration/facilities')
	{return "./saveNewHost";}
	
	// 등록 1단계 이후의 과정 및 모든 수정(DB 사용)
	if(urlInfo.indexOf('/p5/host/modification/roomType') !== -1){return "saveRoomType";}
	if(urlInfo.indexOf('/p5/host/modification/roomCount') !== -1){return "saveRoomCount";}
	if(urlInfo.indexOf('/p5/host/modification/address') !== -1){return "saveAddress";}
	if(urlInfo.indexOf('/p5/host/modification/facilities') !== -1){return "saveFacilities";}
	
	if(urlInfo.indexOf('/p5/host/registration/description') !== -1 || urlInfo.indexOf('/p5/host/modification/description') !== -1)
	{return "./saveDescription";}
	if(urlInfo.indexOf('/p5/host/modification/name') !== -1){return "saveName";}
	
	if(urlInfo.indexOf('/p5/host/registration/stayDate') !== -1 || urlInfo.indexOf('/p5/host/modification/stayDate') !== -1)
	{return "./saveStayDate"};
	
}//////////////////////////////////// setSaveURL-END /////////////////////////////////////////////


/////////////////////////////////////setRefreshURL /////////////////////////////////////////////
function setRefreshURL(){
	
	// 등록 1단계에서 보낼 URL(newHost 세션 사용)
	if(urlInfo == '/p5/host/registration/roomType'
	|| urlInfo == '/p5/host/registration/roomCount'
	|| urlInfo == '/p5/host/registration/address'
	|| urlInfo == '/p5/host/registration/facilities')
	{return "./getNewHost";}
	
	// 등록 1단계 이후의 과정 및 모든 수정(DB 사용)
	return "./getHost";
	
}////////////////////////////////// setRefreshURL-END /////////////////////////////////////////////








///////////////////////////////////// refresh /////////////////////////////////////////////////
function refresh(host){
/*if(urlInfo == '/p5/host/registration/roomCount' && (!host.hostTypeId || !host.roomTypeId)){
	alert("제대로 입력도 안하고 넘어오냐~?");
	location.replace("roomType");
	return;
}*/
if(urlInfo == '/p5/host/registration/facilities' && !host.address && !host.hostTypeId && !host.roomTypeId){
	alert("만료된 페이지입니다.");
	location.replace("../hostingList");
	return;
}
/*if(urlInfo == '/p5/host/registration/facilities' && !host.address){
	alert("주소 입력 완료하고 와라~");
	location.replace("address");
	return;
}*/
if(urlInfo.indexOf('/p5/host/registration/name') !== -1 && !!host.name){
	alert("만료된 페이지입니다.");
	location.replace("../hostingStatus?hostId=" + $('#hostId').val());
	return;
}
if(urlInfo.indexOf('/p5/host/registration/price') !== -1 && host.price != 0){
	alert("만료된 페이지입니다.");
	location.replace("../hostingStatus?hostId=" + $('#hostId').val());
	return;
}


if(!!host.address && (urlInfo == ('/p5/host/registration/address') ||
				  urlInfo.indexOf('/p5/host/modification/address') !== -1)){ // 지도 표시
	
var hostLatLng = new daum.maps.LatLng(host.latitude, host.longitude);

	$('#map').show();
	map.setDraggable(false);
valueInMap(host.latitude, host.longitude);
	
$('#map-set-btn').show();
$('#map-save-btn').hide();

markerRed.setPosition(hostLatLng);
markerRed.setVisible(true);			
markerBlue.setVisible(false);
toggleButton = true;


$('#addressInfo').empty();
$('#addressInfo').append( ' 주소 : ' + host.address);

}




















if(urlInfo.indexOf('/p5/host/registration/') !== -1){$('.modification').remove(); $('.registration').show();}
if(urlInfo.indexOf('/p5/host/modification/') !== -1){$('.registration').remove(); $('.modification').show();} 



	
//************************************ 1 단계 **********************************************
	$('select[name="hostTypeId"]').val(host.hostTypeId);
	$('select[name="roomTypeId"]').val(host.roomTypeId);
	
	$('input[name="capacity"]').val(host.capacity);
	$('input[name="roomCount"]').val(host.roomCount);
	$('input[name="bedCount"]').val(host.bedCount);
	$('input[name="bathroomCount"]').val(host.bathroomCount);
	
	$('input[name="address"]').val(host.address);
	$('input[name="latitude"]').val(host.latitude);
	$('input[name="longitude"]').val(host.longitude);
	
	if(host.isTv == 'Y'){$('input:checkbox[name="isTv"]').prop("checked", true);}
	if(host.isWifi == 'Y'){$('input:checkbox[name="isWifi"]').prop("checked", true);}
	if(host.isAirConditioner == 'Y'){$('input:checkbox[name="isAirConditioner"]').prop("checked", true);}
	if(host.isAirPurifier == 'Y'){$('input:checkbox[name="isAirPurifier"]').prop("checked", true);}
	if(host.isHairDryer == 'Y'){$('input:checkbox[name="isHairDryer"]').prop("checked", true);}
	if(host.isIron == 'Y'){$('input:checkbox[name="isIron"]').prop("checked", true);}
	
	if(host.isKitchen == 'Y'){$('input:checkbox[name="isKitchen"]').prop("checked", true);}
	if(host.isWashingMachine == 'Y'){$('input:checkbox[name="isWashingMachine"]').prop("checked", true);}
	if(host.isElevator == 'Y'){$('input:checkbox[name="isElevator"]').prop("checked", true);}
	if(host.isParkingLot == 'Y'){$('input:checkbox[name="isParkingLot"]').prop("checked", true);}
//************************************ 1 단계-END **********************************************
	
	
			// 2단계
		$('textarea[name="description"]').val(host.description);
		$('textarea[name="descriptionEtc"]').val(host.descriptionEtc);
		$('input[name="name"]').val(host.name);
		
			// 3단계
		$('input[name="minimumStay"]').val(host.minimumStay);
		$('input[name="maximumStay"]').val(host.maximumStay);
		$('input[name="price"]').val(host.price);

	
	
}///////////////////////////////////// refresh-END //////////////////////////////////////////////








 


