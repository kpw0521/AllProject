package com.clover.p5.guest.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BookingEntity {
	
/*	
	ID	NUMBER
	HOST_ID	NUMBER
	MEMBER_ID	NUMBER
	CHECK_IN_DATE	DATE
	CHECK_OUT_DATE	DATE
	GUEST_COUNT	NUMBER
	PAYMENT	NUMBER
	BOOKING_DATE	DATE
	CANCELLATION_DATE	DATE
	REFUND	NUMBER
*/
	private int id;
	private int hostId;
	private int memberId;
	private String checkInDate;
	private String checkOutDate;
	private int guestCount;
	private int payment;
	private String bookingDate;
	private String cancellationDate;
	private int refund;
	
	public BookingEntity() {
		// TODO Auto-generated constructor stub
	}

	public BookingEntity(int id, int hostId, int memberId, String checkInDate, String checkOutDate, int guestCount,
			int payment, String bookingDate, String cancellationDate, int refund) {
		super();
		this.id = id;
		this.hostId = hostId;
		this.memberId = memberId;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.guestCount = guestCount;
		this.payment = payment;
		this.bookingDate = bookingDate;
		this.cancellationDate = cancellationDate;
		this.refund = refund;
	}

	@Override
	public String toString() {
		return "BookingEntity [id=" + id + ", hostId=" + hostId + ", memberId=" + memberId + ", checkInDate="
				+ checkInDate + ", checkOutDate=" + checkOutDate + ", guestCount=" + guestCount + ", payment=" + payment
				+ ", bookingDate=" + bookingDate + ", cancellationDate=" + cancellationDate + ", refund=" + refund
				+ "]";
	}
	
	/*
	public String toJSON() {
		
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss.sss");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		
		String checkInDateBF = checkInDate;
		String checkOutDateBF = checkOutDate;
		String bookingDateBF = bookingDate;
		
		try {
			Date inD = format0.parse(checkInDate);
			Date outD = format0.parse(checkOutDate);
			Date bookingD = format0.parse(bookingDate);
			
			
			checkInDate = format1.format(inD);
			checkOutDate = format1.format(outD);
			bookingDate = format2.format(bookingD);

			if(cancellationDate != null) {
				Date cancelD = format0.parse(cancellationDate);
				cancellationDate = format2.format(cancelD);
			}
			
		} catch (ParseException e) {
			//e.printStackTrace();
			checkInDate = checkInDateBF;
			checkOutDate = checkOutDateBF;
			bookingDate = bookingDateBF;
		}
		
		return "^&id^& : " + id + ", ^&hostId^& : " + hostId + ", ^&memberId^& : " + memberId + ", ^&checkInDate^& : "
				+ checkInDate + ", ^&checkOutDate^& : " + checkOutDate + ", ^&guestCount^& : " + guestCount + ", ^&payment^& : " + payment
				+ ", ^&bookingDate^& : " + bookingDate + ", ^&cancellationDate^& : " + cancellationDate + ", ^&refund^& : " + refund;
	}
	*/

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getCheckInDate() {
		return checkInDate;
	}

	public void setCheckInDate(String checkInDate) {
		this.checkInDate = checkInDate;
	}

	public String getCheckOutDate() {
		return checkOutDate;
	}

	public void setCheckOutDate(String checkOutDate) {
		this.checkOutDate = checkOutDate;
	}

	public int getGuestCount() {
		return guestCount;
	}

	public void setGuestCount(int guestCount) {
		this.guestCount = guestCount;
	}

	public int getPayment() {
		return payment;
	}

	public void setPayment(int payment) {
		this.payment = payment;
	}

	public String getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}

	public String getCancellationDate() {
		return cancellationDate;
	}

	public void setCancellationDate(String cancellationDate) {
		this.cancellationDate = cancellationDate;
	}

	public int getRefund() {
		return refund;
	}

	public void setRefund(int refund) {
		this.refund = refund;
	}
	
	
	

	/*public BookingEntity(int id, int hostId, int memberId, String checkInDate, String checkOutDate, int guestCount,
			int payment, String bookingDate, String cancellationDate, int refund) {
		super();
		
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss.sss");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		
		String checkInDateBF = checkInDate;
		String checkOutDateBF = checkOutDate;
		String bookingDateBF = bookingDate;
		System.out.println("checkInDate : " + checkInDate);
		System.out.println("checkOutDate : " + checkOutDate);
		System.out.println("bookingDate : " + bookingDate);
		
		try {
			Date inD = format0.parse(checkInDate);
			Date outD = format0.parse(checkOutDate);
			Date bookingD = format0.parse(bookingDate);
			
			checkInDate = format1.format(inD);
			checkOutDate = format1.format(outD);
			bookingDate = format2.format(bookingD);
			
			if(cancellationDate != null) {
				Date cancelD = format0.parse(cancellationDate);
				cancellationDate = format2.format(cancelD);
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
			checkInDate = checkInDateBF;
			checkOutDate = checkOutDateBF;
			bookingDate = bookingDateBF;
		}
		
		this.id = id;
		this.hostId = hostId;
		this.memberId = memberId;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.guestCount = guestCount;
		this.payment = payment;
		this.bookingDate = bookingDate;
		this.cancellationDate = cancellationDate;
		this.refund = refund;
	}

	
	@Override
	public String toString() {
		
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss.sss");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		
		String checkInDateBF = checkInDate;
		String checkOutDateBF = checkOutDate;
		String bookingDateBF = bookingDate;
		
		System.out.println("checkInDate : " + checkInDate);
		System.out.println("checkOutDate : " + checkOutDate);
		System.out.println("bookingDate : " + bookingDate);
		
		try {
			Date inD = format0.parse(checkInDateBF);
			Date outD = format0.parse(checkOutDateBF);
			Date bookingD = format0.parse(bookingDateBF);
			
			
			checkInDate = format1.format(inD);
			checkOutDate = format1.format(outD);
			bookingDate = format2.format(bookingD);

			if(cancellationDate != null) {
				Date cancelD = format0.parse(cancellationDate);
				cancellationDate = format2.format(cancelD);
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
			checkInDate = checkInDateBF;
			checkOutDate = checkOutDateBF;
			bookingDate = bookingDateBF;
			
		}
		
		return "BookingEntity [id=" + id + ", hostId=" + hostId + ", memberId=" + memberId + ", checkInDate="
				+ checkInDate + ", checkOutDate=" + checkOutDate + ", guestCount=" + guestCount + ", payment=" + payment
				+ ", bookingDate=" + bookingDate + ", cancellationDate=" + cancellationDate + ", refund=" + refund + "]";
	}
	
	public String toJSON() {
		
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss.sss");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		
		String checkInDateBF = checkInDate;
		String checkOutDateBF = checkOutDate;
		String bookingDateBF = bookingDate;
		
		try {
			Date inD = format0.parse(checkInDate);
			Date outD = format0.parse(checkOutDate);
			Date bookingD = format0.parse(bookingDate);
			
			
			checkInDate = format1.format(inD);
			checkOutDate = format1.format(outD);
			bookingDate = format2.format(bookingD);

			if(cancellationDate != null) {
				Date cancelD = format0.parse(cancellationDate);
				cancellationDate = format2.format(cancelD);
			}
			
		} catch (ParseException e) {
			//e.printStackTrace();
			checkInDate = checkInDateBF;
			checkOutDate = checkOutDateBF;
			bookingDate = bookingDateBF;
		}
		
		return "^&id^& : " + id + ", ^&hostId^& : " + hostId + ", ^&memberId^& : " + memberId + ", ^&checkInDate^& : "
				+ checkInDate + ", ^&checkOutDate^& : " + checkOutDate + ", ^&guestCount^& : " + guestCount + ", ^&payment^& : " + payment
				+ ", ^&bookingDate^& : " + bookingDate + ", ^&cancellationDate^& : " + cancellationDate + ", ^&refund^& : " + refund;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getCheckInDate() {
		return checkInDate;
	}

	public void setCheckInDate(String checkInDate) {
		
		System.out.println("checkInDate : " + checkInDate);
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss.sss");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		
		String checkInDateBF = checkInDate;
		try {
			Date inD = format0.parse(checkInDate);			
			checkInDate = format1.format(inD);
			
		} catch (ParseException e) {
			//e.printStackTrace();
			checkInDate = checkInDateBF;

		}
		this.checkInDate = checkInDate;
	}

	public String getCheckOutDate() {
		return checkOutDate;
	}

	public void setCheckOutDate(String checkOutDate) {
		
		System.out.println("checkOutDate : " + checkOutDate);
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss.sss");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		
		String checkOutDateBF = checkOutDate;
		try {
			Date inD = format0.parse(checkOutDate);			
			checkOutDate = format1.format(inD);
			
		} catch (ParseException e) {
			//e.printStackTrace();
			checkOutDate = checkOutDateBF;

		}
		this.checkOutDate = checkOutDate;
	}

	public int getGuestCount() {
		return guestCount;
	}

	public void setGuestCount(int guestCount) {
		this.guestCount = guestCount;
	}

	public int getPayment() {
		return payment;
	}

	public void setPayment(int payment) {
		this.payment = payment;
	}

	public String getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(String bookingDate) {
		System.out.println("bookingDate : " + bookingDate);
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss.sss");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		
		String bookingDateBF = bookingDate;
		try {
			Date inD = format0.parse(bookingDate);			
			bookingDate = format2.format(inD);
			
		} catch (ParseException e) {
			//e.printStackTrace();
			bookingDate = bookingDateBF;
		}
		this.bookingDate = bookingDate;
	}

	public String getCancellationDate() {
		return cancellationDate;
	}

	public void setCancellationDate(String cancellationDate) {
		System.out.println("cancellationDate : " + cancellationDate);
		SimpleDateFormat format0 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss.sss");
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		
		String cancellationDateBF = cancellationDate;
		try {
			if(cancellationDate != null) {
				Date inD = format0.parse(cancellationDate);			
				cancellationDate = format2.format(inD);
			}
		} catch (ParseException e) {
			//e.printStackTrace();
			cancellationDate = cancellationDateBF;

		}
		this.cancellationDate = cancellationDate;
	}

	public int getRefund() {
		return refund;
	}

	public void setRefund(int refund) {
		this.refund = refund;
	}

	

*/
}