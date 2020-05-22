package com.clover.p5.guest.mapper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.clover.p5.guest.dto.HostInfoDTO;
import com.clover.p5.guest.dto.HostPhotoDTO;
import com.clover.p5.guest.dto.HostSemiInfoDTO;
import com.clover.p5.guest.dto.ReviewInfoDTO;
import com.clover.p5.guest.dto.BookingEntity;
import com.clover.p5.guest.dto.SearchHostDTO;
import com.clover.p5.host.dto.BlockingDTO;
import com.clover.p5.member.dto.ProfilePhoto;

public interface GuestMapper {


	HostInfoDTO selectHost(String id);
	
	List<HostSemiInfoDTO> selectHostList(SearchHostDTO searchHostDto);	// 검색할 때 인원은 guestCount => 출력시에는 호스트의 수용인원값(capacity)

	List<HostPhotoDTO> selectHostPhotoList(String hostId);
	
	HostPhotoDTO selectRepresentativePhoto(String hostId);
	
	List<Date> selectBlocking(String hostId);
	
	int insertBooking(BookingEntity booking);	//성공시 1
	
	int updateBooking(
			@Param("bookingId") String id,
			@Param("cancellationDate") String cancellationDate,
			@Param("refund") String refund
			);
	
	int insertBlocking(
			@Param("hostId") int hostId, 
			@Param("arrBlockingDate") String[] arrBlockingDate
			);

	int deleteBlocking(
			@Param("hostId")String hostId,
			@Param("dates")ArrayList<String> dates
			);
	
	List<BookingEntity> selectBooking(String memberId);
	
	int insertReview(
			@Param("bookingId") String bookingId,
			@Param("rate")String rate,
			@Param("content")String content,
			@Param("creationDate")String creationDate
			);
	
	ProfilePhoto selectProfilePhoto(int memberId);
	
	List<ReviewInfoDTO> selectReviewList(@Param("hostId")String hostId);
	
	int selectCheckBooking(
			@Param("hostId")String hostId,
			@Param("memberId")String memberId,
			@Param("checkInDate")String checkInDate,
			@Param("checkOutDate")String checkOutDate
			
			);
	
	int selectCheckBlocking(	//checkOutDate 체크아웃 하루전날로(미포함)!!!!!!!!!!!!!!!!
			@Param("hostId")String hostId,
			@Param("checkInDate")String checkInDate,
			@Param("checkOutDate")String checkOutDate
			);
	
	List<String> selectReviewCheck(@Param("memberId")String memberId);
	
	
}
