package com.clover.p5.guest.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.clover.p5.guest.service.GuestService;
import com.clover.p5.guest.dto.HostInfoDTO;
import com.clover.p5.guest.dto.HostSemiInfoDTO;
import com.clover.p5.guest.dto.BookingEntity;
import com.clover.p5.guest.dto.SearchInputDTO;

@Controller
public class GuestController {

	@Autowired
	private GuestService guestService;

	@ResponseBody
	@RequestMapping(value="/ajax/Hosts", method = RequestMethod.POST)
	public List<HostSemiInfoDTO> ajaxMap(@RequestBody SearchInputDTO searchInputDto) {	
		return guestService.selectHostList(searchInputDto);
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax/finish", method = RequestMethod.POST)
	public int ajaxReservation(@RequestBody BookingEntity bookingEntity) {	
		return guestService.selectBookingCheck(bookingEntity);
	}
	
	@RequestMapping(value = "/reservationFinish", method = RequestMethod.POST)
	public String reservationFinish(BookingEntity booking, HttpServletRequest request, Model model) {	
		return guestService.reservationFinish(booking, request, model);
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax/refund", method = RequestMethod.POST)
	public boolean ajaxRefund(
			@RequestParam(value="mobilePhone")String mobilePhone,
			@RequestParam(value="bookingId")String sBookingId,
			@RequestParam(value="hostId")String hostId,
			@RequestParam(value="checkInDate")String sCheckInDate,
			@RequestParam(value="checkOutDate")String sCheckOutDate,
			@RequestParam(value="payment")String sPayment
			) {	
		return guestService.refund(mobilePhone, sBookingId, hostId, sCheckInDate, sCheckOutDate, sPayment);
	}

	@RequestMapping("/reservationList")
	public String reservationList(HttpServletRequest request, Model model) {
		return guestService.reservationList(request, model);
	}
	
	@RequestMapping("/postPage")
	public String postPage(HttpServletRequest request, Model model) {	
		return guestService.selectHost(request, model);
	}
	
	@RequestMapping("/reservationPurchase")
	public String reservationPurchase(HttpServletRequest request, Model model) {	
		return guestService.reservationPurchase(request, model);
	}
	
	
	@RequestMapping(value = "/userInfoReservationList", method = RequestMethod.POST)
	public ModelAndView userInfoReservationList(HttpServletRequest request, ModelAndView mv) {	
		return guestService.userInfoReservationList(request, mv);
	}
	
	@RequestMapping(value = "/moveReview", method = RequestMethod.POST)
	public ModelAndView review(HttpServletRequest request, ModelAndView mv) {	
		return guestService.moveReview(request, mv);
	}
	
	@RequestMapping(value = "/registReview", method = RequestMethod.POST)
	public String registReview(HttpServletRequest request, ModelAndView mv) {	
		return guestService.registReview(request, mv);
	}
	
	
	
}
