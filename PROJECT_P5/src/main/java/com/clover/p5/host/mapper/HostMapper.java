package com.clover.p5.host.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.clover.p5.host.dto.Blocking;
import com.clover.p5.host.dto.BlockingDTO;
import com.clover.p5.host.dto.Host;
import com.clover.p5.host.dto.HostDTO;
import com.clover.p5.host.dto.HostPhoto;
import com.clover.p5.host.dto.HostPhotoVO;
import com.clover.p5.host.dto.HostingDTO;
import com.clover.p5.host.dto.NewHostDTO;

public interface HostMapper {

	// 등록 완료 호스트 목록 검색
	List<HostDTO> selectHostList(int memberId);
	
	// 호스팅 목록 검색
	List<HostingDTO> selectHostingList(int memberId);
	
	
	// 호스트 등록 1단계 완료
	int insertHost(NewHostDTO newHost); // session에 모은 정보로 호스트 등록(DB에 저장)
	int selectNewHostId(int memberId); // 작성자 ID로 새로 등록한 호스트 ID를 검색한다
	
	// 특정 호스트 정보 검색
	Host selectHost(int hostId);
	
	// 호스트 삭제
	int deleteHost(int hostId);
	
	// 호스트 수정 1단계
	int updateRoomType(Host host);
	int updateRoomCount(Host host);
	int updateAddress(Host host);
	int updateFacilities(Host host);
		
	// 호스트 등록, 수정 2단계
	int updateDescription(Host host);
	int updateName(Host host);
	
	// 호스트 등록, 수정 3단계
	int updateStayDate(Host host);
	int updatePrice(Host host);
	
	// 호스트 등록 3단계 완료
	int updateCreationDate(
			@Param("price") int price,
			@Param("creationDate") String creationDate,
			@Param("hostId") int hostId);
	
	// 등록 완료 호스트인지 확인
	String selectCreationDate(int hostId);
	// 호스트 주요 내용 수정
	int updateModificationDate(
			@Param("modificationDate") String modificationDate,
			@Param("hostId") int hostId);
	
	
	// 호스트 사진 목록 검색
	List<HostPhoto> selectHostPhotoList(int hostId);
	// 호스트 사진 등록 전 사전 작업?
	int selectHostPhotoCount(int hostId);
	int selectHostPhotoSortOrderMax(int hostId);
	// 호스트 사진 등록
	int insertHostPhoto(List<HostPhotoVO> photoList);
	// 호스트 사진 경로 검색
	String selectHostPhotoPath(int hostPhotoId);
	// 호스트 사진 삭제
	int deleteHostPhoto(int hostPhotoId);
	// 커버 사진 삭제시에 order 대체
	int updateCoverPhotoOrder(int hostId);
	// 호스트 사진 드래그 순서 변경 결과 저장
	int updateHostPhotoSort(int[] sortResult);
	// 호스트 대표 사진 바꾸기에 사용
	int updateHostPhoto(
			@Param("photoId") int photoId,
			@Param("sortOrder") int sortOrder);
			
			
	
	
	// 예약 차단일 목록 검색(예약 완료 포함)
	List<Blocking> selectBlockingList(int hostId);
	// 예약 차단일 설정
	int insertBlocking(BlockingDTO dto);
	// 예약 차단일 해제
	int deleteBlocking(BlockingDTO dto);
	// 전체(월) 차단일 설정
	int insertBlockingMonth(
			@Param("hostId") int hostId,
			@Param("year") String year,
			@Param("month") String month,
			@Param("arrDate") String[] arrDate);
	// 전체(월) 차단일 해제
	int deleteBlockingMonth(BlockingDTO dto);
	
	
	
	
	
	
	
	
	
	// 호스트 접근 권한 확인
	int selectIsIdentified(
			@Param("hostId") int hostId,
			@Param("memberId") int memberId);
	
}
