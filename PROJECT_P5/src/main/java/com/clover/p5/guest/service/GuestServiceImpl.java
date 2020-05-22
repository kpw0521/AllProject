package com.clover.p5.guest.service;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.clover.p5.guest.dto.BookingEntity;
import com.clover.p5.guest.dto.HostInfoDTO;
import com.clover.p5.guest.dto.HostPhotoDTO;
import com.clover.p5.guest.dto.HostSemiInfoDTO;
import com.clover.p5.guest.dto.ReviewInfoDTO;
import com.clover.p5.guest.dto.SearchHostDTO;
import com.clover.p5.guest.dto.SearchInputDTO;
import com.clover.p5.guest.mapper.GuestMapper;
import com.clover.p5.member.dto.ProfilePhoto;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class GuestServiceImpl implements GuestService {

	
	@Autowired
	private GuestMapper guestMapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public int selectBookingCheck(BookingEntity bookingEntity) {

		
		// 사전 DB 확인... 
		
		// host_id, member_id, check_in_date, check_out_date 등 확인해서  구분
		// 확인1 먼저  중복 아니면 블로킹혹인해서 구분 => 그냥 동시에 하자
		
		// 확인 1 (selectCheckBooking) : 요청들어온 booking 데이터와 같은 데이터가 DB에 존재하는지 여부 확인. 
		//			=> 페이지 새로고침시 중복제거됨
		
		// 확인 2 (selectCheckBlocking): 요청들어온 booking 데이터의 check in ~ out 에 blocking이 이미 존재하는지 여부 확인
		// 			존재하면 DB처리 안하고 postPage.jsp로 리턴, 존재하지않으면 DB처리 후 넘어감.
		//			=> 다른 사용자와 동시간 접속, 중복 예약방지
		// 구분 : 확인한 결과에 따라 구분하여 처리
		
		
		System.out.println("혼자야? " + bookingEntity);	//체크인,아웃 YYYY.MM.DD로 들어옴, id=-1, bookingDate= , cancellationDate= , refund=-1
		
		int checkBooking = guestMapper.selectCheckBooking(
				bookingEntity.getHostId()+"", bookingEntity.getMemberId()+"", 
				bookingEntity.getCheckInDate(), bookingEntity.getCheckOutDate()
				);
		
		// checkBlocking할때 checkOutDate 체크아웃 하루전날로(미포함)!!!!!!!!!!!!!!!!
		// 전날작업
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy.MM.dd");
		String SCOD = bookingEntity.getCheckOutDate();
		
		int checkBlocking = -1;
		try {
			Date DCOD = format.parse(SCOD);
			Date yDCOD = new Date(DCOD.getTime()+(1000*60*60*24* - 1));	// 체크아웃 하루 전날		
			String ySCOD = format.format(yDCOD);
			System.out.println("체크아웃전날 : " + ySCOD);
			checkBlocking = guestMapper.selectCheckBlocking(bookingEntity.getHostId()+"", bookingEntity.getCheckInDate(), ySCOD);
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		// 예약가능 : 0, 누군가 먼저 예약 : 1, 중복요청 : 2
		if(checkBooking == 0 && checkBlocking == 0) {
			
			if(checkBlocking == -1) {
				System.out.println("요청들어온 checkOutDate format 형식 오류!");
			}
			System.out.println("선 예약있니?몇 개? 선예약없으면 0 : " + checkBlocking + ", 중복요청아니면 0 : "+ checkBooking);
			return 0;	// 예약 가능	
			
		}else if(checkBooking == 0 && checkBlocking != 0){
			
			System.out.println("선 예약있니?몇 개? 선예약없으면 0 : " + checkBlocking + ", 중복요청아니면 0 : "+ checkBooking);
			return 1;	// 누군가 먼저 예약
			
		}else{
			
			System.out.println("선 예약있니?몇 개? 선예약없으면 0 : " + checkBlocking + ", 중복요청아니면 0 : "+ checkBooking);
			return 2;	// 중복요청
			
		}
		
}


	
	
	
	@Override
	public String sendMobileCode(String mobileNumber, String content) {
		
		// 6자리 숫자 난수 생성(100000 ~ 999999)
		String code = new Random().nextInt(900000) + 100000 + "";
		//String content = "P5입니다^^ 예약완료되었습니다. - " + code;
		String hashedCode = passwordEncoder.encode(code); // 인증번호 해싱
		
		String apiKey = "NCS9FLMUM2URIAA9";
	    String apiSecret = "GOOZEG4YKEZFLWDTBCUPWCRTIGTREH3S";
	    Message coolsms = new Message(apiKey, apiSecret);
	
	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", mobileNumber); // 수신번호
	    params.put("from", "01099641539"); // 발신번호
	    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
	    params.put("text", content); // 문자내용    
	    
	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      System.out.println(obj.toString());
	      
	      // 잔액 확인..
	      obj = (JSONObject) coolsms.balance();
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	      return "";
	    }
		return hashedCode;
	}
		
	@Override
	public String selectHost(HttpServletRequest request, Model model) {
		
		System.out.println("\n postPage 페이지 이동");
		
		String id = request.getParameter("id");
		System.out.println("호출된 id :" + id);
		
		String address = request.getParameter("address");
		System.out.println("호출된 address : " + address);
		
		String startDate = request.getParameter("startDate");
		System.out.println("호출된 startDate : " + startDate);
		
		String endDate = request.getParameter("endDate");
		System.out.println("호출된 endDate : " + endDate);
		
		String checkInDatecheckOutDate;
		if((startDate == null || startDate == "") && (endDate == null || endDate == "")) {
			checkInDatecheckOutDate = "";
		}else {
			checkInDatecheckOutDate = startDate + " - " + endDate;
		}
		String guestCount = request.getParameter("guestCount");
		System.out.println("호출된 guestCount : " + guestCount);
		
		// 호스트 정보
		HostInfoDTO hostInfoDto = guestMapper.selectHost(id);
		
		// 호스트 프로필 사진
		ProfilePhoto profilePhoto = guestMapper.selectProfilePhoto(hostInfoDto.getMemberId());
		
		// 호스트 사진 리스트
		List<HostPhotoDTO> hostPhotoDto = guestMapper.selectHostPhotoList(id);
		//System.out.println(hostPhotoDto.get(0).getPath());
		
		// 호스트 block 날짜 리스트
		List<Date> blocking = guestMapper.selectBlocking(id);
		
		StringBuffer sbBlocking = new StringBuffer();
		
		for(Date d : blocking) {
			SimpleDateFormat form1 = new SimpleDateFormat("yyyy.MM.dd");
			System.out.println("블로킹 날짜 : " + form1.format(d));
			sbBlocking.append("'" + form1.format(d) + "',");
		}
		System.out.println("sbBlocking : " + sbBlocking);
		
		
		String sBlocking;
		
		if(blocking.size() == 0) {
			sBlocking = "";
		}else {
			sBlocking = sbBlocking.substring(0, sbBlocking.length()-1);
		}
		
		System.out.println("sBlocking : " + sBlocking);
		
		// 호스트 리뷰 리스트(기본 review 정보 + 멤버 프로필 사진)
		List<ReviewInfoDTO> reviewList = guestMapper.selectReviewList(id);
		
		// 리뷰 전체정보
		double reviewSum = 0;
		double reviewAvg = 0;
		int reviewCount = reviewList.size();
		for(ReviewInfoDTO dto: reviewList) {
			double rate = Double.parseDouble(dto.getRating());
			reviewSum += rate;
		}
		reviewAvg = Math.round((reviewSum/(double)reviewCount) * 100)/100.0;
		System.out.println("평균 평점 : " + reviewAvg);
		
		
		
		// 헤더 검색 필터 정보
		model.addAttribute("address", address);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("checkInDatecheckOutDate", checkInDatecheckOutDate);
		model.addAttribute("guestCount", guestCount);
		
		// 호스트 정보
		model.addAttribute("host", hostInfoDto);
		// postPage에서  host.memberId가 아닌 member.dto에 있는 Member로 계속 참조함...
		model.addAttribute("hostMID", hostInfoDto.getMemberId());

		
		// 호스트 프로필 사진
		model.addAttribute("profilePhoto", profilePhoto);
		
		// 호스트 사진 리스트
		model.addAttribute("hostPhoto", hostPhotoDto);
		
		// 호스트 블로킹 리스트
		model.addAttribute("blocking", sBlocking);
		
		// 호스트 리뷰 리스트
		model.addAttribute("reviewList", reviewList);
		
		// 호스트 리뷰 전체정보(개수, 평균 평점)
		model.addAttribute("reviewCount", reviewCount);
		model.addAttribute("reviewAvg", reviewAvg);
		
		
		return "postPage";	
	}

	@Override
	public List<HostSemiInfoDTO> selectHostList(SearchInputDTO dto) {
		
		System.out.println("\n ajaxHosts 요청!");	
		
		// 받아온 HostParamVO를 SearchHostDTO에 맞게 데이터셋
		String swLatlng = dto.getSwLatlng();
		String neLatlng = dto.getNeLatlng();
		
		int guestCount;
		if(dto.getGuestCount() != "") {
			guestCount = Integer.parseInt(dto.getGuestCount());
		}else {
			guestCount = -1;	// 조건 비활성 값
		}
		
		String sStartDate = dto.getStartDate();
		String sEndDate = dto.getEndDate();
		
		System.out.println("sw좌표" + swLatlng);
		swLatlng = swLatlng.substring(1, (swLatlng.length()-1));
		
		System.out.println("ne좌표" + neLatlng);
		neLatlng = neLatlng.substring(1, (neLatlng.length()-1));

		String[] swLatlngStr =  swLatlng.split(", ");
		String[] neLatlngStr =  neLatlng.split(", ");
		
		System.out.println(swLatlngStr[0]);	//남서 위도
		double swLatitude = Double.parseDouble(swLatlngStr[0]);
		System.out.println(swLatlngStr[1]);	//남서 경도
		double swLongitude = Double.parseDouble(swLatlngStr[1]);

		System.out.println(neLatlngStr[0]);	//북동 위도
		double neLatitude = Double.parseDouble(neLatlngStr[0]);
		System.out.println(neLatlngStr[1]);	//북동 경도
		double neLongitude = Double.parseDouble(neLatlngStr[1]);
		
		System.out.println("guestCount : " + guestCount);
		System.out.println("sStartDate : " + sStartDate);
		System.out.println("sEndDate : " + sEndDate);
		
		SearchHostDTO searchHostDto = new SearchHostDTO(sStartDate, sEndDate, swLatitude, neLatitude, swLongitude, neLongitude, guestCount);
		
		return guestMapper.selectHostList(searchHostDto);
	}

	@Override
	public String reservationList(HttpServletRequest request, Model model) {

		System.out.println("\n reservationList 페이지 이동");
		
		String address = request.getParameter("address");
		String checkInDatecheckOutDate = request.getParameter("checkInDatecheckOutDate");
		String guestCount = request.getParameter("guestCount");
		
		String startDate;
		String endDate;
		
		if(checkInDatecheckOutDate != "" && checkInDatecheckOutDate != null) {
			String[] date = checkInDatecheckOutDate.split(" - ");
			startDate = date[0];
			endDate = date[1];
		}else {
			startDate = null;
			endDate = null;
		}
		System.out.println("키워드:" + address);
		System.out.println("날짜:" + checkInDatecheckOutDate);
		System.out.println("인원:" + guestCount);
		System.out.println("시작날:" + startDate);
		System.out.println("끝날:" + endDate);
				
		model.addAttribute("address", address);
		model.addAttribute("checkInDatecheckOutDate", checkInDatecheckOutDate);
		model.addAttribute("guestCount", guestCount);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
				
		
		return "reservationList";
	}

	@Override
	public String reservationPurchase(HttpServletRequest request, Model model) {

		System.out.println("\n reservationPurchase 페이지 이동");

		String reservationDate = request.getParameter("reservationDate");
		int guestCount = Integer.parseInt(request.getParameter("guestCount"));
		int hostId = Integer.parseInt(request.getParameter("hostId"));
		int memberId = Integer.parseInt(request.getParameter("userId"));
		String hostName = request.getParameter("hostName");
		int hostPrice = Integer.parseInt(request.getParameter("hostPrice"));
		int dateCount = Integer.parseInt(request.getParameter("dateCnt"));
		
		
		String[] date = reservationDate.split(" - ");
		
//		Date checkInDate = null;
//		Date checkOutDate = null;
//		
//		try {
//			//String checkInDate = date[0];
//			checkInDate = new SimpleDateFormat("MM/dd/yyyy").parse(date[0]);
//			//String checkOutDate = date[1];
//			checkOutDate = new SimpleDateFormat("MM/dd/yyyy").parse(date[1]);
//
//		} catch (ParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		String checkInDate = date[0];
		String checkOutDate = date[1];

		System.out.println("checkInDate : " + checkInDate);
		System.out.println("checkOutDate : " + checkOutDate);

		
		int payment = dateCount * hostPrice;
		
		System.out.println("날짜 : " + reservationDate);	//체크 인-아웃
		System.out.println("인원 : " + guestCount);
		System.out.println("호스트 id : " + hostId);
		System.out.println("유저 id : " + memberId);
		System.out.println("체크인 : " + checkInDate);
		System.out.println("체크아웃 : " + checkOutDate);
		System.out.println("호스트 1박 금액 : " + hostPrice);
		System.out.println("호스트 이름 : " + hostName);
		System.out.println("결제 금액 : " + payment);
		
		//model.addAttribute("personnel", guestCount);
		//model.addAttribute("memberId", memberId);
		model.addAttribute("reservationDate", reservationDate);
		//model.addAttribute("checkInDate", checkInDate);
		//model.addAttribute("checkOutDate", checkOutDate);
		model.addAttribute("hostPrice", hostPrice);
		model.addAttribute("dateCount", dateCount);
		model.addAttribute("hostName", hostName);
		//model.addAttribute("payment", payment);		
		
		BookingEntity booking = new BookingEntity(-1, hostId, memberId, checkInDate, checkOutDate, guestCount, payment, null, null, 0);
		model.addAttribute("booking", booking);
		
		return "reservationPurchase";
	}

	@Transactional
	@Override
	public String reservationFinish(BookingEntity booking, HttpServletRequest request, Model model) {
		
		boolean flag = true;	// 문자전송 flag
		
		String mobilePhone = request.getParameter("mobilePhone");
		String hostName = request.getParameter("hostName");
		
		
		
//		SimpleDateFormat format0 = new SimpleDateFormat ( "MM/dd/yyyy");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy.MM.dd");
		
		Date today = new Date();	// 예약일 날짜
		
		String bookingDate = format1.format(today);	// Date => String
		//today = format1.parse(bookingDate);		// String => Date
		
		String checkInDate = booking.getCheckInDate();
		String checkOutDate = booking.getCheckOutDate();
		
		List<String> listBlockingDate = new ArrayList<>();

		booking.setBookingDate(bookingDate);
		
		System.out.println("booking : " + booking.toString());
		
		// DB check
		// 예약가능 : 0, 누군가 먼저 예약 : 1, 중복요청 : 2
		int result = selectBookingCheck(booking);
		
		System.out.println("\n reservationFinish 페이지 요청");
		
		String reservationFlag = result + "";
		
		if(result == 0) {
			System.out.println("예약할게");
			// DB로 예약
			if(guestMapper.insertBooking(booking) == 1) {
				
				System.out.println("DB booking insert 성공");
				
				try {
					Date dCID = format2.parse(checkInDate);
					Date dCOD = format2.parse(checkOutDate);
					long diff = dCOD.getTime() - dCID.getTime();
					//System.out.println(diff);
					long diffDays = diff / (24 * 60 * 60 * 1000);	
					//System.out.println("차이" + diffDays);
					for(int i = 0;i<diffDays;i++ ) {
						long day = dCID.getTime() + i * (24 * 60 * 60 * 1000);
						String sDay = format2.format(day);	// yyyy.MM.dd
						//String sDay = format0.format(day);	// MM/dd/yyyy
						
						System.out.println(sDay);
						listBlockingDate.add(sDay);
					}//end - for
					
					checkInDate = format2.format(dCID);
					checkOutDate = format2.format(dCOD);
					
				} catch (ParseException e) {
					e.printStackTrace();
				}
				
			}else {
				System.out.println("DB booking insert 실패");
				flag = false;
			}
			
			
			
			String[] arrBlockingDate = listBlockingDate.toArray(new String[listBlockingDate.size()]);
			

			if(guestMapper.insertBlocking(booking.getHostId(), arrBlockingDate) == arrBlockingDate.length) {
				System.out.println("DB blocking insert 성공");
			}else {
				System.out.println("DB blocking insert 실패");
				flag = false;
			}
			

		
			
			//========	예약 문자전송	=========
			if(flag) {
				DecimalFormat dFormat = new DecimalFormat("###,###");

				hostName = hostName.substring(0, 8) + "..";
				
				String content = 
								"[P5]예약안내 \r\n"
							+	hostName + "\r\n"
							+	checkInDate + " ~ " + checkOutDate + "\r\n"
							+	dFormat.format(booking.getPayment()) + "원\r\n"
							+	booking.getGuestCount() + "명"
							;
				
				sendMobileCode(mobilePhone, content);	//문자 낭비를 막기위해 주석중.
				
				System.out.println("문자 수신자 : " + mobilePhone + ", 문자내용 확인 : " + content);
			}
			
			//===========================

									
		}else if(result == 1){	// 누군가 먼저 예약 : 1
			
			System.out.println("늦었어ㅠ 누가 예약 했다구!");
			
		}else {	// 중복요청 : 2
			
			System.out.println("중복요청이넹");
			
		}
		
		HostInfoDTO host = guestMapper.selectHost(booking.getHostId()+"");
		
		model.addAttribute("booking", booking);
		model.addAttribute("host", host);
		
		model.addAttribute("reservationFlag", reservationFlag);
		
		return "reservationFinish";
		
	}

	@Override
	public ModelAndView userInfoReservationList(HttpServletRequest request, ModelAndView mv) {
		
		String memberId = request.getParameter("memberId");
		
		List<BookingEntity> bookingList = guestMapper.selectBooking(memberId);
		
		List<HostPhotoDTO> RepresentativePhotoList = new ArrayList<>();
		
		List<HostInfoDTO> hostList = new ArrayList<>();
		
		List<String> reviewCheckList = guestMapper.selectReviewCheck(memberId);
		
		for(BookingEntity booking : bookingList) {
			
			HostPhotoDTO RepresentativePhoto = guestMapper.selectRepresentativePhoto(booking.getHostId()+"");
			
			RepresentativePhotoList.add(RepresentativePhoto);
			
			HostInfoDTO host = guestMapper.selectHost(booking.getHostId()+"");
			hostList.add(host);
		}
		
		//System.out.println("날짜 확인 : " + bookingList.get(0).getCheckInDate());
		//System.out.println("잘왔니?");
		
		mv.addObject("bookingList", bookingList);
		mv.addObject("RepresentativePhotoList", RepresentativePhotoList);
		mv.addObject("hostList", hostList);
		mv.addObject("reviewCheckList", reviewCheckList);
		
				
		mv.setViewName("userInfoReservationList"); // 뷰의 이름
		
		return mv;
	}
	
	@Transactional
	@Override
	public boolean refund(String mobilePhone, String sBookingId, String hostId, String sCheckInDate, String sCheckOutDate, String sPayment) {
	//public boolean refund(BookingEntity bookingEntity) {
				

		//System.out.println("값 받았니? id: " + sBookingId);
		//System.out.println("값 받았니? checkInDate: " + sCheckInDate);
		//System.out.println("값 받았니? checkOutDate: " + sCheckOutDate);
		//System.out.println("값 받았니? payment: " + sPayment);
		
		
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss.sss");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		
		int id = Integer.parseInt(sBookingId);
		
		//System.out.println(bookingEntity.getHostId());
		Date checkInDate = new Date();
		Date checkOutDate = new Date();
		
		try {
			checkInDate = format0.parse(sCheckInDate);
			checkOutDate = format0.parse(sCheckOutDate);
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("체크인 날짜 : " + sCheckInDate);
		
		
		
		
		Date cancelDate = new Date();	// 시간 배제하고 일로 계산해야됨
		
		String sCancelDate = format1.format(cancelDate);
		String cancellationDate = format2.format(cancelDate);	
		try {
			cancelDate = format1.parse(sCancelDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("취소 날짜 : " + sCancelDate);
		
		// 시간 차이 계산후 refund 금액 계산
		long diff = checkInDate.getTime() - cancelDate.getTime();
		long diffDate = diff/(24 * 60 * 60 * 1000);
		System.out.println("날짜 차이 : " + diffDate + "일");
		
		/*
			refund 환불 정책
			
			계산날짜에 따른 다른 환급율로 환불
			
			취소 날짜	: CancellationDate
			체크인 날짜	: CheckInDate
			계산 날짜	: 체크인 - 취소일
			
			계산 날짜
				7일 이상 ~			: 100%
				5일 이상 ~	7일 미만	:  75%
				3일 이상 ~ 5일 미만	:  50%
				1일 이상 ~ 3일 미만	:  25%
				당일 환급 없음		:   0%	
			
		*/
				
		// refund 금액 계산
		
		// 환급율
		double rate;
		
		if(diffDate < 1) {
			rate = 0.00;
		}else if(diffDate >= 1 && diffDate < 3) {
			rate = 0.25;
		}else if(diffDate >= 3 && diffDate < 5) {
			rate = 0.50;
		}else if(diffDate >= 5 && diffDate < 7) {
			rate = 0.75;
		}else {
			rate = 1.00;
		}
		
		System.out.println(rate);
		int refund = (int)(Integer.parseInt(sPayment) * rate);
		DecimalFormat dFormat = new DecimalFormat("###,###");
		
		System.out.println("환불금액 : " + dFormat.format(refund) + "원");
		
		
		
		int success1 = guestMapper.updateBooking(id+"", cancellationDate, refund+"");	// 실패면 0, 성공하면 row개수로 반환.	
		
		Date startDate = checkInDate;
		Date endDate = checkOutDate;
		ArrayList<String> dates = new ArrayList<String>();	//checkOutDate 까지 포함
		Date currentDate = startDate;
		while (currentDate.compareTo(endDate) <= 0) {
			dates.add(format1.format(currentDate));
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = c.getTime();
		}
		dates.remove(format1.format(checkOutDate));
//		for(String d : dates) {
//			System.out.println(d);
//		}
		
		int success2 = guestMapper.deleteBlocking(hostId, dates);

		
		System.out.println("success1 : " + success1); 
		System.out.println("success2 : " + success2);
		
		
		if(success1 == 0 || success2== 0) {
			return false;
		}else {

			//========	예약취소 문자전송	=========
			
			//hostName = hostName.substring(0, 8) + "..";
			
			String content = 
							"[P5]예약취소안내 \r\n"
						+	"예약번호:" + hostId + "\r\n"
						+	sCheckInDate + "~" + sCheckOutDate + "\r\n"
						+	"환불금액:" + dFormat.format(refund) + "원\r\n"
						;
			
			sendMobileCode(mobilePhone, content);	//문자 낭비를 막기위해 주석중.
			
			System.out.println("문자 수신자 : " + mobilePhone + ", 문자내용 확인 : " + content);
		
			
			//===========================
			
			return true;
		}
	}

	@Override
	public ModelAndView moveReview(HttpServletRequest request, ModelAndView mv) {

		String memberId = request.getParameter("memberId");
		String bookingId = request.getParameter("bookingId");
		String hostName = request.getParameter("hostName");
		String checkInDate = request.getParameter("checkInDate");
		String checkOutDate = request.getParameter("checkOutDate");
		String hostPhotoPath = request.getParameter("hostPhotoPath");
		String hostPhotoName = request.getParameter("hostPhotoName");
		
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss.sss");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		
		try {
			Date checkIn = format0.parse(checkInDate);
			Date checkOut = format0.parse(checkOutDate);
			checkInDate = format1.format(checkIn);
			checkOutDate = format1.format(checkOut);
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		mv.addObject("bookingId", bookingId);
		mv.addObject("hostName", hostName);
		mv.addObject("checkInDate", checkInDate);
		mv.addObject("checkOutDate", checkOutDate);
		mv.addObject("hostPhotoPath", hostPhotoPath);
		mv.addObject("hostPhotoName", hostPhotoName);
		
				
		mv.setViewName("review"); // 뷰의 이름
		
		return mv;
	}

	@Override
	public String registReview(HttpServletRequest request, ModelAndView mv) {

		String memberId = request.getParameter("memberId");
		String bookingId = request.getParameter("bookingId"); 
		String rate = request.getParameter("rate");
		String commentReview = request.getParameter("commentReview");
		
		System.out.println("확인 : " + memberId);
		System.out.println("확인 : " + bookingId);
		System.out.println("확인 : " + rate);
		System.out.println("확인 : " + commentReview);
		
		Date today = new Date();
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		String creationDate = format0.format(today);
		System.out.println("today : " + creationDate);
		
		int success = guestMapper.insertReview(bookingId, rate, commentReview, creationDate);
		
		System.out.println("리뷰등록 성공여부 : " + success);
		
		
		request.setAttribute("memberId", memberId);
		return "forward:userInfoReservationList";
	}

	
	
	

	
}





