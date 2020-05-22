package com.clover.p5;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping("/")
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	
	
	// 임시 페이지 이동
	@RequestMapping("/userInfoUpdate")
	public void userInfoUpdate() {}
	@RequestMapping("/userInfoReservationList")
	public void userInfoReservationList() {}
	@RequestMapping("/hostReservationUpdate")
	public void hostReservationUpdate() {}
	@RequestMapping("/phoneCertification")
	public void phoneCertification() {}
	@RequestMapping("/hostReservationList")
	public void hostReservationList() {}
	
	// 사진 등록 테스트 페이지(임시)
	@RequestMapping("/test2")
	public void test2() {}
	
	
	@RequestMapping("/ajax/pagehide")
	@ResponseBody
	public void testPageHide(String presentURL) {
		System.out.println(presentURL);
		return;
	}

	
	
	
}
