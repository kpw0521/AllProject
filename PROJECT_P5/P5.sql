
/* Drop Triggers */

DROP TRIGGER TRI_blocking_id;
DROP TRIGGER TRI_booking_id;
DROP TRIGGER TRI_email_authentication_id;
DROP TRIGGER TRI_host_id;
DROP TRIGGER TRI_host_photo_id;
DROP TRIGGER TRI_member_id;
DROP TRIGGER TRI_place_id;
DROP TRIGGER TRI_place_photo_id;
DROP TRIGGER TRI_profile_photo_id;



/* Drop Tables */

DROP TABLE blocking CASCADE CONSTRAINTS;
DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE booking CASCADE CONSTRAINTS;
DROP TABLE host_photo CASCADE CONSTRAINTS;
DROP TABLE host CASCADE CONSTRAINTS;
DROP TABLE host_type CASCADE CONSTRAINTS;
DROP TABLE profile_photo CASCADE CONSTRAINTS;
DROP TABLE remember_me CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE room_type CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_blocking_id;
DROP SEQUENCE SEQ_booking_id;
DROP SEQUENCE SEQ_email_authentication_id;
DROP SEQUENCE SEQ_host_id;
DROP SEQUENCE SEQ_host_photo_id;
DROP SEQUENCE SEQ_member_id;
DROP SEQUENCE SEQ_place_id;
DROP SEQUENCE SEQ_place_photo_id;
DROP SEQUENCE SEQ_profile_photo_id;




/* Create Sequences */

CREATE SEQUENCE SEQ_blocking_id INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE SEQ_booking_id INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE SEQ_host_id INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE SEQ_host_photo_id INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE SEQ_member_id INCREMENT BY 1 START WITH 1 NOCACHE;
CREATE SEQUENCE SEQ_profile_photo_id INCREMENT BY 1 START WITH 1 NOCACHE;



/* Create Tables */

CREATE TABLE blocking
(
	id number NOT NULL,
	host_id number,
	check_in_date date,
	who char(1),
	PRIMARY KEY (id)
);


CREATE TABLE booking
(
	id number NOT NULL,
	host_id number,
	member_id number,
	check_in_date date,
	check_out_date date,
	guest_count number,
	payment number,
	booking_date date,
	cancellation_date date,
	refund number,
	PRIMARY KEY (id)
);


CREATE TABLE host
(
	id number NOT NULL,
	member_id number,
	host_type_id char(2) NOT NULL,
	room_type_id char(2) NOT NULL,
	capacity number,
	room_count number,
	bed_count number,
	bathroom_count number,
	address varchar2(200),
	latitude number,
	longitude number,
	is_tv char(1),
	is_wifi char(1),
	is_air_conditioner char(1),
	is_air_purifier char(1),
	is_hair_dryer char(1),
	is_iron char(1),
	is_kitchen char(1),
	is_washing_machine char(1),
	is_elevator char(1),
	is_parking_lot char(1),
	description varchar2(4000),
	description_etc varchar2(4000),
	name varchar2(150),
	minimum_stay number,
	maximum_stay number,
	price number,
	creation_date date,
	modification_date date,
	PRIMARY KEY (id)
);


CREATE TABLE host_photo
(
	id number NOT NULL,
	host_id number,
	original_name varchar2(260),
	file_size number,
	path varchar2(100),
	sort_order number,
	PRIMARY KEY (id)
);


CREATE TABLE host_type
(
	id char(2) NOT NULL,
	name varchar2(30),
	PRIMARY KEY (id)
);


CREATE TABLE member
(
	id number NOT NULL,
	email varchar2(70) UNIQUE,
	password varchar2(100),
	first_name varchar2(60),
	last_name varchar2(30),
	birth_date date,
	mobile_phone varchar2(11),
	mobile_authentication char(1),
	registration_date date,
	PRIMARY KEY (id)
);


CREATE TABLE profile_photo
(
	id number NOT NULL,
	member_id number,
	original_name varchar2(260),
	file_size number,
	path varchar2(100),
	is_profile char(1),
	PRIMARY KEY (id)
);


CREATE TABLE remember_me
(
	cookie_value varchar2(100) NOT NULL,
	member_id number,
	cookie_limit date,
	PRIMARY KEY (cookie_value)
);


CREATE TABLE review
(
	booking_id number NOT NULL,
	rating number(2,1),
	content varchar2(1500),
	creation_date date,
	PRIMARY KEY (booking_id)
);


CREATE TABLE room_type
(
	id char(2) NOT NULL,
	name varchar2(30),
	PRIMARY KEY (id)
);



/* Create Foreign Keys */

ALTER TABLE review
	ADD FOREIGN KEY (booking_id)
	REFERENCES booking (id)
;


ALTER TABLE blocking
	ADD FOREIGN KEY (host_id)
	REFERENCES host (id)
	ON DELETE CASCADE
;


ALTER TABLE booking
	ADD FOREIGN KEY (host_id)
	REFERENCES host (id)
	ON DELETE SET NULL
;


ALTER TABLE host_photo
	ADD FOREIGN KEY (host_id)
	REFERENCES host (id)
	ON DELETE CASCADE
;


ALTER TABLE host
	ADD FOREIGN KEY (host_type_id)
	REFERENCES host_type (id)
;


ALTER TABLE booking
	ADD FOREIGN KEY (member_id)
	REFERENCES member (id)
	ON DELETE SET NULL
;


ALTER TABLE host
	ADD FOREIGN KEY (member_id)
	REFERENCES member (id)
	ON DELETE CASCADE
;


ALTER TABLE profile_photo
	ADD FOREIGN KEY (member_id)
	REFERENCES member (id)
	ON DELETE CASCADE
;


ALTER TABLE remember_me
	ADD FOREIGN KEY (member_id)
	REFERENCES member (id)
	ON DELETE CASCADE
;


ALTER TABLE host
	ADD FOREIGN KEY (room_type_id)
	REFERENCES room_type (id)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_blocking_id BEFORE INSERT ON blocking
FOR EACH ROW
BEGIN
	SELECT SEQ_blocking_id.nextval
	INTO :new.id
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_host_photo_id BEFORE INSERT ON host_photo
FOR EACH ROW
BEGIN
	SELECT SEQ_host_photo_id.nextval
	INTO :new.id
	FROM dual;
END;

/


INSERT INTO host_type VALUES('A1', '아파트');
INSERT INTO host_type VALUES('B2', '주택');
INSERT INTO host_type VALUES('C3', '팬션');

INSERT INTO room_type VALUES('A1', '집 전체');
INSERT INTO room_type VALUES('B2', '개인실');
INSERT INTO room_type VALUES('C3', '다인실');





