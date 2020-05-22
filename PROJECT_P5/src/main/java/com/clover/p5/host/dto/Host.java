package com.clover.p5.host.dto;

public class Host {
	
		private int hostId; // 호스트번호
		private int memberId; // 회원번호
		
		private String hostTypeId; // 호스트 종류 번호
		private String roomTypeId; // 호스트 유형 번호
		
		private int capacity; // 수용 인원
		private int roomCount; // 방 수
		private int bedCount; // 침대 수
		private int bathroomCount; // 욕실 수
		
		private String address; // API주소 + 상세주소(직접 입력)
		private double latitude; // 위도(y)
		private double longitude; // 경도(x)
		
		private char isTv;
		private char isWifi;
		private char isAirConditioner;
		private char isAirPurifier;
		private char isHairDryer;
		private char isIron;
		
		private char isKitchen;
		private char isWashingMachine;
		private char isElevator;
		private char isParkingLot;
		
		private String description;
		private String descriptionEtc;
		
		private String name;
		
		private int minimumStay;
		private int maximumStay;
		
		private int price;
		
		private String creationDate;
		private String modificationDate;
		
		
		@Override
		public String toString() {
			return 	"hostId: " + hostId + "\n"
					+ "memberId: " + memberId + "\n"
					+ "hostTypeId: " + hostTypeId + "\n"
					+ "roomTypeId: " + roomTypeId + "\n"
					+ "capacity: " + capacity + "\n"
					+ "roomCount: " + roomCount + "\n"
					+ "bedCount: " + bedCount + "\n"
					+ "bathroomCount: " + bathroomCount + "\n"
					+ "address: " + address + "\n"
					+ "latitude: " + latitude + "\n"
					+ "longitude: " + longitude + "\n"
					+ "isTv: " + isTv + "\n"
					+ "isWifi: " + isWifi + "\n"
					+ "isAirConditioner: " + isAirConditioner + "\n"
					+ "isAirPurifier: " + isAirPurifier + "\n"
					+ "isHairDryer: " + isHairDryer + "\n"
					+ "isIron: " + isIron + "\n"
					+ "isKitchen: " + isKitchen + "\n"
					+ "isWashingMachine: " + isWashingMachine + "\n"
					+ "isElevator: " + isElevator + "\n"
					+ "isParkingLot: " + isParkingLot + "\n"
					+ "description: " + description + "\n"
					+ "descriptionEtc: " + descriptionEtc + "\n"
					+ "name: " + name + "\n"
					+ "minimumStay: " + minimumStay + "\n"
					+ "maximumStay: " + maximumStay + "\n"
					+ "price: " + price + "\n"
					+ "creationDate: " + creationDate + "\n"
					+ "modificationDate: " + modificationDate;
		}


		public int getHostId() {
			return hostId;
		}


		public void setHostId(int hostId) {
			this.hostId = hostId;
		}


		public int getMemberId() {
			return memberId;
		}


		public void setMemberId(int memberId) {
			this.memberId = memberId;
		}


		public String getHostTypeId() {
			return hostTypeId;
		}


		public void setHostTypeId(String hostTypeId) {
			this.hostTypeId = hostTypeId;
		}


		public String getRoomTypeId() {
			return roomTypeId;
		}


		public void setRoomTypeId(String roomTypeId) {
			this.roomTypeId = roomTypeId;
		}


		public int getCapacity() {
			return capacity;
		}


		public void setCapacity(int capacity) {
			this.capacity = capacity;
		}


		public int getRoomCount() {
			return roomCount;
		}


		public void setRoomCount(int roomCount) {
			this.roomCount = roomCount;
		}


		public int getBedCount() {
			return bedCount;
		}


		public void setBedCount(int bedCount) {
			this.bedCount = bedCount;
		}


		public int getBathroomCount() {
			return bathroomCount;
		}


		public void setBathroomCount(int bathroomCount) {
			this.bathroomCount = bathroomCount;
		}


		public String getAddress() {
			return address;
		}


		public void setAddress(String address) {
			this.address = address;
		}


		public double getLatitude() {
			return latitude;
		}


		public void setLatitude(double latitude) {
			this.latitude = latitude;
		}


		public double getLongitude() {
			return longitude;
		}


		public void setLongitude(double longitude) {
			this.longitude = longitude;
		}


		public char getIsTv() {
			return isTv;
		}


		public void setIsTv(char isTv) {
			this.isTv = isTv;
		}


		public char getIsWifi() {
			return isWifi;
		}


		public void setIsWifi(char isWifi) {
			this.isWifi = isWifi;
		}


		public char getIsAirConditioner() {
			return isAirConditioner;
		}


		public void setIsAirConditioner(char isAirConditioner) {
			this.isAirConditioner = isAirConditioner;
		}


		public char getIsAirPurifier() {
			return isAirPurifier;
		}


		public void setIsAirPurifier(char isAirPurifier) {
			this.isAirPurifier = isAirPurifier;
		}


		public char getIsHairDryer() {
			return isHairDryer;
		}


		public void setIsHairDryer(char isHairDryer) {
			this.isHairDryer = isHairDryer;
		}


		public char getIsIron() {
			return isIron;
		}


		public void setIsIron(char isIron) {
			this.isIron = isIron;
		}


		public char getIsKitchen() {
			return isKitchen;
		}


		public void setIsKitchen(char isKitchen) {
			this.isKitchen = isKitchen;
		}


		public char getIsWashingMachine() {
			return isWashingMachine;
		}


		public void setIsWashingMachine(char isWashingMachine) {
			this.isWashingMachine = isWashingMachine;
		}


		public char getIsElevator() {
			return isElevator;
		}


		public void setIsElevator(char isElevator) {
			this.isElevator = isElevator;
		}


		public char getIsParkingLot() {
			return isParkingLot;
		}


		public void setIsParkingLot(char isParkingLot) {
			this.isParkingLot = isParkingLot;
		}


		public String getDescription() {
			return description;
		}


		public void setDescription(String description) {
			this.description = description;
		}


		public String getDescriptionEtc() {
			return descriptionEtc;
		}


		public void setDescriptionEtc(String descriptionEtc) {
			this.descriptionEtc = descriptionEtc;
		}


		public String getName() {
			return name;
		}


		public void setName(String name) {
			this.name = name;
		}


		public int getMinimumStay() {
			return minimumStay;
		}


		public void setMinimumStay(int minimumStay) {
			this.minimumStay = minimumStay;
		}


		public int getMaximumStay() {
			return maximumStay;
		}


		public void setMaximumStay(int maximumStay) {
			this.maximumStay = maximumStay;
		}


		public int getPrice() {
			return price;
		}


		public void setPrice(int price) {
			this.price = price;
		}


		public String getCreationDate() {
			return creationDate;
		}


		public void setCreationDate(String creationDate) {
			this.creationDate = creationDate;
		}


		public String getModificationDate() {
			return modificationDate;
		}


		public void setModificationDate(String modificationDate) {
			this.modificationDate = modificationDate;
		}


		
		
		
		
	

}
