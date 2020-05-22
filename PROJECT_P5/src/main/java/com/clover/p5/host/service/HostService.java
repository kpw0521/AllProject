package com.clover.p5.host.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.clover.p5.host.dto.Blocking;
import com.clover.p5.host.dto.BlockingDTO;
import com.clover.p5.host.dto.Host;
import com.clover.p5.host.dto.HostDTO;
import com.clover.p5.host.dto.HostPhoto;
import com.clover.p5.host.dto.HostingDTO;
import com.clover.p5.host.dto.NewHostDTO;

public interface HostService {
	
	// 호스팅 목록 검색
	List<HostingDTO> getHostingList(int memberId);
	// 완료 호스트 목록 검색
	List<HostDTO> getHostList(int memberId);
	
	// 호스트 등록 1단계 완료
	int completeStep1(NewHostDTO newHost);
	
	// 특정 호스트 검색
	Host getHost(int hostId);
	
	// 호스트 삭제
	boolean deleteHost(HttpServletRequest req);
	
	
	// 호스트 수정 1단계 - roomType.jsp
	boolean modifyRoomType(Host host);
	// 호스트 수정 1단계 - roomCount.jsp
	boolean modifyRoomCount(Host host);
	// 호스트 수정 1단계 - address.jsp
	boolean modifyAddress(Host host);
	// 호스트 수정 1단계 - facilities.jsp
	boolean modifyFacilities(Host host);
	
	// 호스트 등록, 수정 2단계 - description.jsp
	boolean updateDescription(Host host);
	// 호스트 등록, 수정 2단계 - name.jsp
	boolean updateName(Host host);
	
	// 호스트 등록, 수정 3단계 - stayDate.jsp
	boolean updateStayDate(Host host);
	// 호스트 등록, 수정 3단계 - price.jsp
	boolean updatePrice(Host host);
	
	// 호스트 등록 3단계 완료
	boolean completeRegistration(int price, int hostId);
	
	
	
	
	
	
	
	
	
	
	// 호스트 사진 목록 가져오기
	List<HostPhoto> getHostPhotoList(int hostId);
	
	// 호스트 사진(서버) 및 경로(DB) 저장
	boolean insertHostPhoto(List<MultipartFile> photos, HttpServletRequest req);
	
	// 호스트 사진 삭제
	boolean deleteHostPhoto(HttpServletRequest req);
	
	// 호스트 사진 정렬 결과 저장
	int updateHostPhotoSort(int[] sortResult);
	
	// 호스트 사진 대표 이미지 변경
	boolean changeCoverImage(HttpServletRequest req);
	
	
	
	
	
	
	
	// 예약 차단일 목록 검색 
	List<Blocking> getBlokcingList(int hostId);
	
	// 예약 차단일 설정
	boolean block(BlockingDTO dto);
	
	// 예약 차단일 설정 해제
	boolean unblock(BlockingDTO dto);
	
	// 전체(월) 예약 차단 
	boolean blockMonth(BlockingDTO dto);
	
	// 전체(월) 예약 차단 해제
	boolean unblockMonth(BlockingDTO dto);
	
	
	
	
	
	// 호스트 내용 변경시 접근 권한 확인
	boolean isIdentified(HttpServletRequest req);
	
	
}
