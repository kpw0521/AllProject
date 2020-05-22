package com.clover.p5.host.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.clover.p5.host.dto.Blocking;
import com.clover.p5.host.dto.BlockingDTO;
import com.clover.p5.host.dto.Host;
import com.clover.p5.host.dto.HostDTO;
import com.clover.p5.host.dto.HostPhoto;
import com.clover.p5.host.dto.HostingDTO;
import com.clover.p5.host.service.HostService;
import com.clover.p5.member.service.MemberServiceImpl;


@Controller
public class HostController {
	
	@Autowired
	private HostService hostService;

	
	
	
	
	
		// 헤더의 '호스트 등록'을 눌렀을 때 해당 페이지로 이동시킨다.
	@RequestMapping("/host/hostingList")
	public void hostingList() {}
	
	
	// 선택 호스팅(호스트 등록) 화면으로 이동
	@RequestMapping("/host/hostingStatus")
	public String hostingStatus(int hostId, Model model) {
		if(hostId == 0) { // '새로 등록'을 선택했으면
			return "redirect:registration/roomType";
		}
			// 등록중(미완료)를 선택했으면 해당 호스트ID를 가지고 이동
		model.addAttribute("hostId", hostId);
		return "host/hostingStatus";
	}
	
	// 호스트 등록중 목록 검색
	@RequestMapping("/host/getHostingList")
	@ResponseBody
	public List<HostingDTO> getHostingList(HttpServletRequest req) {
		return hostService.getHostingList(MemberServiceImpl.getSessionUserId(req));
	}
	
	// 등록완료 호스트 페이지로 이동
	@RequestMapping("/host/hostList")
	public void hostList() {return;}
	
	// 호스트 등록 완료 목록 검색
	@RequestMapping("/host/getHostList")
	@ResponseBody
	public List<HostDTO> getHostList(HttpServletRequest req) {
		return hostService.getHostList(MemberServiceImpl.getSessionUserId(req));
	}
	
	// 호스트 삭제
	@RequestMapping("/host/deleteHost")
	@ResponseBody
	public boolean deleteHost(HttpServletRequest req) {
		return hostService.deleteHost(req);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 호스트 수정 페이지 본인 식별
	@RequestMapping("/ajax/isIdentified")
	@ResponseBody
	public boolean isIdentified(HttpServletRequest req) {
		return hostService.isIdentified(req);
	}
	
	
	@RequestMapping("/host/*/getHost")
	@ResponseBody
	public Host getHost(int hostId) {
		return hostService.getHost(hostId);
	}
	
	@RequestMapping("/host/modification/saveRoomType")
	@ResponseBody
	public boolean saveRoomType(Host host) {
		return hostService.modifyRoomType(host);
	}
	@RequestMapping("/host/modification/saveRoomCount")
	@ResponseBody
	public boolean saveRoomCount(Host host) {
		return hostService.modifyRoomCount(host);
	}
	@RequestMapping("/host/modification/saveAddress")
	@ResponseBody
	public boolean saveAddress(Host host) {
		return hostService.modifyAddress(host);
	}
	@RequestMapping("/host/modification/saveFacilities")
	@ResponseBody
	public boolean saveFacilities(Host host) {
		return hostService.modifyFacilities(host);
	}
	
	
	@RequestMapping("/host/*/saveDescription")
	@ResponseBody
	public boolean saveDescription(Host host) {
		return hostService.updateDescription(host);
	}
	@RequestMapping("/host/*/saveName")
	@ResponseBody
	public boolean saveName(Host host) {
		return hostService.updateName(host);
	}
	
	
	@RequestMapping("/host/*/saveStayDate")
	@ResponseBody
	public boolean saveStayDate(Host host) {
		return hostService.updateStayDate(host);
	}
	@RequestMapping("/host/modification/savePrice")
	@ResponseBody
	public boolean savePrice(Host host) {
		return hostService.updatePrice(host);
	}
	
	
	@RequestMapping("/ajax/completeStep3")
	@ResponseBody
	public boolean completeStep3(int price, int hostId) {
		return hostService.completeRegistration(price, hostId);
	}
	
	
	
	
	
	
	
	
	
	
//****************************** 호스트 사진 등록(수정) ******************************************	
	@RequestMapping("/ajax/getHostPhotoList") // 사진 목록 가져오기
	@ResponseBody
	public List<HostPhoto> getHostPhotoList(int hostId) {
		return hostService.getHostPhotoList(hostId);
	}
	
	@RequestMapping("/ajax/addHostPhoto") // 사진 추가
	@ResponseBody
	public boolean addHostPhoto(List<MultipartFile> photoFiles, HttpServletRequest req) {
		return hostService.insertHostPhoto(photoFiles, req);
	}
	
	@RequestMapping("/ajax/deleteHostPhoto") // 사진 삭제
	@ResponseBody
	public boolean deleteHostPhoto(HttpServletRequest req) {
		return hostService.deleteHostPhoto(req);
	}
	
	@RequestMapping("/ajax/updateHostPhotoSort") // 사진 정렬 내용 적용
	@ResponseBody
	public int updateHostPhotoSort(int[] sortResult) {
		return hostService.updateHostPhotoSort(sortResult);
	}
	
	@RequestMapping("/ajax/changeCoverImage") // 대표 사진 변경하기
	@ResponseBody
	public boolean changeCoverImage(HttpServletRequest req) {
		return hostService.changeCoverImage(req);
	}
//****************************** 호스트 사진 등록(수정)-END ******************************************		
	
	
	
	
//****************************** 호스트 예약 차단 ******************************************	
	@RequestMapping("/host/*/getBlockingList") // 예약 차단일 목록 검색
	@ResponseBody
	public List<Blocking> getBlockingList(int hostId) {
		return hostService.getBlokcingList(hostId);
	}
	@RequestMapping("/host/*/block") // 예약 차단
	@ResponseBody
	public boolean block(BlockingDTO dto) {
		System.out.println(dto);
		return hostService.block(dto);
	}
	@RequestMapping("/host/*/unblock") // 예약 차단 해제
	@ResponseBody
	public boolean unblock(BlockingDTO dto) {
		System.out.println(dto);
		return hostService.unblock(dto);
	}
	@RequestMapping("/host/*/blockMonth") // 예약 전체(월) 차단
	@ResponseBody
	public boolean blockMonth(BlockingDTO dto) {
		System.out.println(dto);
		return hostService.blockMonth(dto);
	}
	@RequestMapping("/host/*/unblockMonth") // 예약 전체(월) 해제
	@ResponseBody
	public boolean unblockMonth(BlockingDTO dto) {
		System.out.println(dto);
		return hostService.unblockMonth(dto);
	}
//****************************** 호스트 예약 차단-END ******************************************	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//****************************** 호스트 수정 1단계 ******************************************	
	// roomType.jsp로 이동
		@RequestMapping("/host/modification/roomType")
		public String roomType2(int hostId, Model model) {
			model.addAttribute("hostId", hostId);
			return "host/registration/step1/roomType";
		}	// roomCount.jsp로 이동
		@RequestMapping("/host/modification/roomCount")
		public String roomCount2(int hostId, Model model) {
			model.addAttribute("hostId", hostId);
			return "host/registration/step1/roomCount";
		}	// address.jsp로 이동
		@RequestMapping("/host/modification/address")
		public String address2(int hostId, Model model) {
			model.addAttribute("hostId", hostId);
			return "host/registration/step1/address";
		}	// facilities.jsp로 이동
		@RequestMapping("/host/modification/facilities")
		public String facilities2(int hostId, Model model) {
			model.addAttribute("hostId", hostId);
			return "host/registration/step1/facilities";
		}
//****************************** 호스트 수정 1단계-END ******************************************
		
		
//****************************** 호스트 등록,수정 2단계 ******************************************
		// photo.jsp로 이동
	@RequestMapping("/host/*/photo")
	public String photo(int hostId, Model model) {
		model.addAttribute("hostId", hostId);
		return "host/registration/step2/photo";
	}	// description.jsp로 이동
	@RequestMapping("/host/*/description")
	public String description(int hostId, Model model) {
		model.addAttribute("hostId", hostId);
		return "host/registration/step2/description";
	}	// name.jsp로 이동
	@RequestMapping("/host/*/name")
	public String name(int hostId, Model model) {
		model.addAttribute("hostId", hostId);
		return "host/registration/step2/name";
	}
//****************************** 호스트 등록,수정 2단계-END ******************************************
	
	
//****************************** 호스트 등록,수정 3단계 ******************************************
		// stayDate.jsp로 이동
	@RequestMapping("/host/*/stayDate")
	public String stayDate(int hostId, Model model) {
		model.addAttribute("hostId", hostId);
		return "host/registration/step3/stayDate";
	}	// calendar.jsp로 이동
	@RequestMapping("/host/*/calendar")
	public String calendar(int hostId, Model model) {
		model.addAttribute("hostId", hostId);
		return "host/registration/step3/calendar";
	}	// price.jsp로 이동
	@RequestMapping("/host/*/price")
	public String price(int hostId, Model model) {
		model.addAttribute("hostId", hostId);
		return "host/registration/step3/price";
	}
	@RequestMapping("/host/registration/finish")
	public void finish(int hostId, Model model) {
		model.addAttribute("hostId", hostId);
		return;
	}
//****************************** 호스트 등록,수정 3단계-END ******************************************
	
		
	
	
	
	
	
	
}
