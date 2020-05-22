package com.clover.p5.host.service;

import java.io.File;
import java.io.IOException;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.clover.p5.host.dto.Blocking;
import com.clover.p5.host.dto.BlockingDTO;
import com.clover.p5.host.dto.Host;
import com.clover.p5.host.dto.HostDTO;
import com.clover.p5.host.dto.HostPhoto;
import com.clover.p5.host.dto.HostPhotoVO;
import com.clover.p5.host.dto.HostingDTO;
import com.clover.p5.host.dto.NewHostDTO;
import com.clover.p5.host.mapper.HostMapper;
import com.clover.p5.member.service.MemberServiceImpl;

@Service
public class HostServiceImpl implements HostService {

	
	@Autowired
	private HostMapper hostMapper;
	
	
	
	
	
//********************************** 호스트 사진 검색(출력용) ***********************************************
	@Override
	public List<HostPhoto> getHostPhotoList(int hostId) {
		List<HostPhoto> list = hostMapper.selectHostPhotoList(hostId);
		System.out.println(hostId + "번 호스트 사진 - " + list.size() + "개");
		
		return list;
	}
//********************************** 호스트 사진 검색(출력용)-END ***********************************************
	
	

//********************************** 호스트 사진 등록 ***********************************************
	@Override
	public boolean insertHostPhoto(List<MultipartFile> photos, HttpServletRequest request) {
	  int hostId = Integer.parseInt(request.getParameter("hostId"));
	  String defaultPath = request.getServletContext().getRealPath("/");
	  
      //파일 기본경로 _ 상세경로
      String folderPath = defaultPath + "resources" + File.separator + "upload" + File.separator + "host" + File.separator + hostId + File.separator;
      System.out.println("저장 경로 : " + folderPath);
      
	/**
	** 파일을 저장할 폴더가 존재하지 않을 경우 폴더를 생성해준다.
	**/
		File folder = new File(folderPath);
        if(!folder.exists()) { // 존재하지 않으면
            if(folder.mkdirs()) { // 폴더를 생성하고 결과를 출력
            	System.out.println("폴더 생성 완료 : " + folderPath);
            }
        }
        
    /**
    ** 서버에 파일을 저장하고 DB에 저장할 정보를 생성.
    **/
        List<HostPhotoVO> photoList = new ArrayList<>();
        
        int sortOrder = 0;
        if(hostMapper.selectHostPhotoCount(hostId) != 0) {
        	sortOrder = hostMapper.selectHostPhotoSortOrderMax(hostId);
        }
        
    	for(MultipartFile photo : photos) {
    		
    		// 원본 파일명
    		String originalName = photo.getOriginalFilename();
    		// 파일 크기
    		long fileSize = photo.getSize();
    		// 파일 확장자
    		String fileExtension =
				originalName.substring(originalName.lastIndexOf("."));
    		
    		// 저장 파일명을 생성
    		ZonedDateTime nowSeoul = ZonedDateTime.now(ZoneId.of("Asia/Seoul"));
    		String saveName = (
				nowSeoul.format(DateTimeFormatter.ofPattern("yyMMdd_HHmmssSSS_")) +
				UUID.randomUUID() + fileExtension		).replace("-", "");
    		
    		// 서버에 저장될 실제 '저장' 경로
    		String savePath = folderPath + saveName;
    		
    		// DB에 저장될 최종 path
    		String path = request.getContextPath() + "/upload/host/" + hostId + "/" + saveName;
    		System.out.println("이미지 경로 : " + path);
    		
    		sortOrder++;
    		
		/***
		 ** 서버에 파일 저장
		 ***/
    		File file = new File(savePath);
    		try {
				photo.transferTo(file);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
				System.out.println("업로드 파일을 서버에 저장 중에 오류 발생");
				return false;
			}
    		
    		photoList.add(new HostPhotoVO(hostId, originalName, fileSize, path, sortOrder));
    	} // for-END
    	
    	
    	/***
		** DB에 파일 정보 저장
		***/
    		int insertResult = hostMapper.insertHostPhoto(photoList);
    		if(insertResult != photoList.size()) {
    			System.out.println("업로드 파일을 DB에 저장 중에 오류 발생");
    			return false;
    		}
    		
    	System.out.println
    		(insertResult + "개의 업로드 파일을 성공적으로 서버와 DB에 저장했습니다.");
	    return true; // 문제 없이 모든 수행이 끝났으면 true를 반환.
	}
//********************************** 호스트 사진 등록-END ***********************************************	


//****************************** 호스트 사진 삭제(서버 파일) ***********************************************
	public boolean deleteServerFile(HttpServletRequest req, int hostId, int hostPhotoId) {
		
		String defaultPath = req.getServletContext().getRealPath("/");
		String folderPath = defaultPath + "resources" + File.separator + "upload" + File.separator + "host" + File.separator + hostId + File.separator;
		
		String path = hostMapper.selectHostPhotoPath(hostPhotoId);
		String saveName = path.substring(path.lastIndexOf("/") + 1);
		// 서버에 파일이 저장된 경로
		String deletePath = folderPath + saveName;
		
		File file = new File(deletePath);
		if(file.exists()){
			if(file.delete()){
				System.out.println("파일 삭제 성공");
				return true;
			}else{
				System.out.println("파일 삭제 실패");
				return false;
			} 
		}
		System.out.println("파일이 존재하지 않습니다.");
		return true;
		
	}
//**************************** 호스트 사진 삭제(서버 파일)-END ***********************************************	
//********************************** 호스트 사진 삭제 ***********************************************
	@Transactional
	@Override
	public boolean deleteHostPhoto(HttpServletRequest req) {
		int photoId = Integer.parseInt(req.getParameter("photoId"));
		int photoOrder = Integer.parseInt(req.getParameter("photoOrder"));
		int photoCount = Integer.parseInt(req.getParameter("photoCount"));
		int hostId = Integer.parseInt(req.getParameter("hostId"));
		
		if(!deleteServerFile(req, hostId, photoId)) {
			return false;
		}
		if(hostMapper.deleteHostPhoto(photoId) != 1) {
			System.out.println(photoId + "번 사진 삭제(DB) 실패");
			return false;
		}
		if(photoOrder == 1 && photoCount > 1) { // 삭제한 사진이 커버사진이고 다른 사진이 존재했을 때
			if(hostMapper.updateCoverPhotoOrder(hostId) != 1) {
				System.out.println("커버 사진 order 대체(DB) 실패");
				return false;
			}
		}
		System.out.println(photoId + "번 사진 삭제 성공");
		return true; // 삭제 성공
	}
//********************************** 호스트 사진 삭제-END ***********************************************
		
			
	
//********************************** 호스트 사진 정렬 결과 저장 ***********************************************
	@Override
	public int updateHostPhotoSort(int[] sortResult) {
		return hostMapper.updateHostPhotoSort(sortResult);
	}
//********************************** 호스트 사진 정렬 결과 저장-END ***********************************************
	
	
//**************************** 대표 사진 변경 *****************************************
	@Override
	public boolean changeCoverImage(HttpServletRequest req) {
		int choiceId = Integer.parseInt(req.getParameter("choiceId"));
		int coverId = Integer.parseInt(req.getParameter("coverId"));
		int choiceOrder = Integer.parseInt(req.getParameter("choiceOrder"));
		
		if(hostMapper.updateHostPhoto(coverId, choiceOrder) != 1) {
			System.out.println("대표 사진 변경 사전 작업 중에 오류 발생");
			return false;
		}
		if(hostMapper.updateHostPhoto(choiceId, 1) != 1) {
			System.out.println("대표 사진 변경 중에 오류 발생");
			return false;
		}
		System.out.println(coverId + " -> " + choiceId + "번 사진으로 대표사진 변경 완료.");
		return true;
	}
//**************************** 대표 사진 변경-END ***************************************	


	
	
	
	
	
	
	
	

	@Override
	public int completeStep1(NewHostDTO newHost) {
		if(hostMapper.insertHost(newHost) == 1) {
			System.out.println("newHost를 DB에 저장했습니다.");
				// 작성자 ID로 방금 DB에 등록된 호스트의 ID를 검색
			return hostMapper.selectNewHostId(newHost.getMemberId());
		}
		System.out.println("newHost를 DB에 저장 실패했습니다.");
		return 0;
	}



	@Override
	public Host getHost(int hostId) {
		Host host = hostMapper.selectHost(hostId);
//		System.out.println("=============== " + hostId + "번 호스트 ==============");
//		System.out.println(host);
//		System.out.println("===================================");
		return host;
	}



	@Override
	public List<HostingDTO> getHostingList(int memberId) {
		List<HostingDTO> list = hostMapper.selectHostingList(memberId);
		System.out.println(memberId + "번 회원의 등록중인 호스트 : " + list.size() + "개");
		return list;
	}



	@Override
	public boolean isIdentified(HttpServletRequest req) {
		int hostId = Integer.parseInt(req.getParameter("hostId"));
		int memberId = MemberServiceImpl.getSessionUserId(req);
		if(hostMapper.selectIsIdentified(hostId, memberId) != 1) {
			return false;
		}
		return true;
	}
	
	



	@Override
	public boolean modifyRoomType(Host host) {
		if(hostMapper.updateRoomType(host) == 1) {
			System.out.println("roomType.jsp 수정 완료했습니다.");
			return true;
		}
		System.out.println("roomType.jsp 수정 실패했습니다.");
		return false;
	}
	@Override
	public boolean modifyRoomCount(Host host) {
		if(hostMapper.updateRoomCount(host) == 1) {
			System.out.println("roomCount.jsp 수정 완료했습니다.");
			return true;
		}
		System.out.println("roomCount.jsp 수정 실패했습니다.");
		return false;
	}
	@Override
	public boolean modifyAddress(Host host) {
		if(hostMapper.updateAddress(host) == 1) {
			System.out.println("address.jsp 수정 완료했습니다.");
			return true;
		}
		System.out.println("address.jsp 수정 실패했습니다.");
		return false;
	}
	@Override
	public boolean modifyFacilities(Host host) {
		if(hostMapper.updateFacilities(host) == 1) {
			System.out.println("facilities.jsp 수정 완료했습니다.");
			return true;
		}
		System.out.println("facilities.jsp 수정 실패했습니다.");
		return false;
	}
	@Override
	public boolean updateDescription(Host host) {
		if(hostMapper.updateDescription(host) == 1) {
			System.out.println("description.jsp 수정 완료했습니다.");
			return true;
		}
		System.out.println("description.jsp 수정 실패했습니다.");
		return false;
	}
	@Override
	public boolean updateName(Host host) {
		if(hostMapper.updateName(host) == 1) {
			System.out.println("name.jsp 수정 완료했습니다.");
			return true;
		}
		System.out.println("name.jsp 수정 실패했습니다.");
		return false;
	}
	@Override
	public boolean updateStayDate(Host host) {
		if(hostMapper.updateStayDate(host) == 1) {
			System.out.println("stayDate.jsp 수정 완료했습니다.");
			return true;
		}
		System.out.println("stayDate.jsp 수정 실패했습니다.");
		return false;
	}
	@Override
	public boolean updatePrice(Host host) {
		if(hostMapper.updatePrice(host) == 1) {
			System.out.println("price.jsp 수정 완료했습니다.");
			return true;
		}
		System.out.println("price.jsp 수정 실패했습니다.");
		return false;
	}



	@Override
	public boolean completeRegistration(int price, int hostId) {
	/***
	** 서버시간에 서울의 타임존을 적용한 DateTime을 얻는다.
	***/
		ZonedDateTime nowSeoul = ZonedDateTime.now(ZoneId.of("Asia/Seoul"));
		String creationDate =
			nowSeoul.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
										
		if(hostMapper.updateCreationDate(price, creationDate, hostId) != 1) {
			System.out.println("호스트 등록(3단계)을 완료하지 못했습니다.");
			return false;
		}
		System.out.println("호스트 등록(3단계)을 완료했습니다.");
		return true;
	}
	
	
	
	public boolean modifyHost(int hostId) {
		
		if(hostMapper.selectCreationDate(hostId) != null) { // 등록 완료된 글이면
		/***
		 ** 서버시간에 서울의 타임존을 적용한 DateTime을 얻는다.
		 ***/
			ZonedDateTime nowSeoul = ZonedDateTime.now(ZoneId.of("Asia/Seoul"));
			String modificationDate =
				nowSeoul.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			
			if(hostMapper.updateModificationDate(modificationDate, hostId) == 1) {
				System.out.println(hostId + "번 호스트 - 수정일 업데이트 완료.");
				return true;
			} else {
				System.out.println(hostId + "번 호스트 - 수정일 업데이트 실패.");
				return false;
			}
		}
		System.out.println(hostId + "번 호스트 - 수정일 업데이트 불필요.(등록 미완료)");
		return false;					
	}



	@Override
	public List<HostDTO> getHostList(int memberId) {
		List<HostDTO> list = hostMapper.selectHostList(memberId);
		System.out.println(memberId + "번 회원의 등록 완료 호스트 : " + list.size() + "개");
		return list;
	}



	
	@Override
	public boolean deleteHost(HttpServletRequest req) {
		int hostId = Integer.parseInt(req.getParameter("hostId"));
		
		String defaultPath = req.getServletContext().getRealPath("/");
		String folderPath = defaultPath + "resources" + File.separator + "upload" + File.separator + "host" + File.separator + hostId;
		File folder = new File(folderPath);
		try {
			while(folder.exists()) {
				File[] fileList = folder.listFiles(); //파일리스트 얻어오기
						
				for (int i = 0; i < fileList.length; i++) {
					fileList[i].delete(); //파일 삭제 
					System.out.println("파일이 삭제되었습니다.");
				}
						
				if(fileList.length == 0 && folder.isDirectory()){ 
					folder.delete(); //대상폴더 삭제
					System.out.println("폴더가 삭제되었습니다.");
				}
	        }
		} catch(Exception e) {
			System.out.println("관련 파일 삭제 중에 오류 발생");
			return false;
		}
		
		if(hostMapper.deleteHost(hostId) == 1) {
			System.out.println(hostId + "번 호스트 삭제 성공했습니다.");
			return true;
		}
		System.out.println(hostId + "번 호스트 삭제 실패했습니다..");
		return false;
	}



	
	
	@Override
	public List<Blocking> getBlokcingList(int hostId) {
		List<Blocking> list = hostMapper.selectBlockingList(hostId);
		System.out.println(hostId + "번 호스트 예약 차단일(예약 완료 포함) - " + list.size() + "건");
		return list;
	}

	@Override
	public boolean block(BlockingDTO dto) {
		if(hostMapper.insertBlocking(dto) == 1) {
			System.out.println("예약 차단일 설정 성공");
			return true;
		}
		System.out.println("예약 차단일 설정 실패");
		return false;
	}

	@Override
	public boolean unblock(BlockingDTO dto) {
		if(hostMapper.deleteBlocking(dto) == 1) {
			System.out.println("예약 차단일 설정 해제 성공");
			return true;
		}
		System.out.println("예약 차단일 설정 해제 실패");
		return false;
	}

	@Override
	public boolean blockMonth(BlockingDTO dto) {
		String[] arrDate = dto.getDate().split(",");
		int result = hostMapper.insertBlockingMonth(dto.getHostId(),
													dto.getYear(),
													dto.getMonth(),
													arrDate);
		if(result == arrDate.length) {
			System.out.println(dto.getHostId() + "번 호스트 "
								+ dto.getMonth() + "월 전체 차단 결과 - "
								+ result + "건의 예약 차단일 설정을 완료했습니다.");
			return true;
		}
		System.out.println(dto.getHostId() + "번 호스트 "
							+ dto.getMonth() + "월 전체 차단 결과 - 실패..");
		return false;
	}

	@Override
	public boolean unblockMonth(BlockingDTO dto) {
		String month = dto.getMonth();
		if(month.length() == 1) {
			dto.setMonth("0" + month);
		}
		int result = hostMapper.deleteBlockingMonth(dto);
		if(result > 0) {
			System.out.println(dto.getHostId() + "번 호스트 "
					+ dto.getMonth() + "월 전체 차단 해제 결과 - "
					+ result + "건의 예약 차단일 설정을 해제했습니다.");
			return true;
		}
		System.out.println(dto.getHostId() + "번 호스트 "
							+ dto.getMonth() + "월 전체 차단 해제 결과 - 실패..");
		return false;
	}
	





	
	

	
	
	
}
