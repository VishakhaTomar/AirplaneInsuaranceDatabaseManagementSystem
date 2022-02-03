CREATE TABLE IF NOT EXISTS userstable(username TEXT,password TEXT,usertype text, customerID serial primary key)
ALTER TABLE userstable
ADD COLUMN usertype text;

--select * from userstable
--update userstable set usertype='U' where username='viren'
INSERT INTO userstable (username, password,usertype) VALUES ('myAdmin','4356a21b1b6643f1514a7c50e80d6fbdc0486a97567d193ce483c2538493713a', 'A');
CREATE TABLE vcvt_cust (
p_id	INT NULL, c_id	INT NOT NULL Primary key,
fnamep VARCHAR(30) NOT NULL, lnamep VARCHAR(30) NOT NULL, dob TIMESTAMP(0) NOT NULL,
nationalityy VARCHAR(30) NOT NULL, gender	CHAR(1) NOT NULL, 
email VARCHAR(30) NOT NULL,
housenum		SMALLINT NOT NULL, street	SMALLINT NOT NULL,
city	VARCHAR(30) NOT NULL, state		VARCHAR(30) NOT NULL, zipcode				VARCHAR(10) NOT NULL, country			VARCHAR(30) NOT NULL,
country_code SMALLINT NOT NULL, contact_number BIGINT NOT NULL, nop	SMALLINT NOT NULL,
ec_fname VARCHAR(30) NOT NULL, ec_lname VARCHAR(30) NOT NULL, ec_cc SMALLINT NOT NULL,
ec_contact BIGINT NOT NULL, pspt_num VARCHAR(15) NOT NULL,
pspt_expd TIMESTAMP(0) NOT NULL, c_type CHAR(1) NOT NULL
);



CREATE TABLE vcvt_psngr (
c_id	INT NULL,p_id	serial NOT NULL Primary key,
fnamep VARCHAR(30) NOT NULL, lnamep VARCHAR(30) NOT NULL, dob TIMESTAMP(0) NOT NULL,
nationalityy VARCHAR(30) NOT NULL, gender	CHAR(1) NOT NULL, 
email VARCHAR(30) NOT NULL,
housenum		SMALLINT NOT NULL, street	SMALLINT NOT NULL,
city	VARCHAR(30) NOT NULL, state		VARCHAR(30) NOT NULL, zipcode				VARCHAR(10) NOT NULL, country			VARCHAR(30) NOT NULL,
country_code SMALLINT NOT NULL, contact_number BIGINT NOT NULL, nop	SMALLINT NOT NULL,
ec_fname VARCHAR(30) NOT NULL, ec_lname VARCHAR(30) NOT NULL, ec_cc SMALLINT NOT NULL,
ec_contact BIGINT NOT NULL, pspt_num VARCHAR(15) NOT NULL,
pspt_expd TIMESTAMP(0) NOT NULL, c_type CHAR(1) NOT NULL
);

--update vcvt_psngr set c_id=1 where p_id in (1,2)

--select sum(b.cpp) from vcvt_cust_ispln a,vcvt_ispln b,vcvt_psngr cwhere a.p_id =c.p_id and a.pln_id = b.pln_id and c.c_id=1

CREATE SEQUENCE c_id_increment
  start 1
  increment 1;


CREATE TABLE vcvt_ispln (
pln_id	VARCHAR(14) NOT NULL Primary key,
p_name	VARCHAR(30) NOT NULL,
description VARCHAR(500) NOT NULL, cpp	DECIMAL(10, 2) NOT NULL
);

CREATE TABLE vcvt_cust_ispln ( pln_id VARCHAR(14) NOT NULL, p_id INT NOT NULL
);



INSERT INTO VCVT_ISPLN (PLN_ID, P_NAME, DESCRIPTION, CPP)
VALUES (10, 'TRIP CANCELLATION', 'a trip cancel policy will reimburse you for your prepaid,non-refundable costs' , 20);

INSERT INTO VCVT_ISPLN (PLN_ID, P_NAME, DESCRIPTION, CPP)
VALUES (11, 'TRIP INTERRUPTION', 'This will reimburse the unused portion of your trip if has already begun and an unexpected incident forces you to return home' , 20);

INSERT INTO VCVT_ISPLN (PLN_ID, P_NAME, DESCRIPTION, CPP)
VALUES (12, 'MEDICAL INSURANCE', 'This offers health insurance, as well as dental, vision and other plans, to meet the needs of individuals and families, employers, health care providers', 50);

INSERT INTO VCVT_ISPLN (PLN_ID, P_NAME, DESCRIPTION, CPP)
VALUES (13, 'BAGGAGE INSURANCE', 'This policy can track luggage, cover delayed or lost baggage or stolen belongings, and help to replace lost or stolen travel documents', 40); 
INSERT INTO VCVT_ISPLN (PLN_ID, P_NAME, DESCRIPTION, CPP)
VALUES (14, 'ACCIDENTAL DEATH INSURANCE', 'Accidental Death Insurance. Accidental death insurance provides financial support for your loved ones if you die in a covered accident' , 20);

INSERT INTO VCVT_ISPLN (PLN_ID, P_NAME, DESCRIPTION, CPP)
VALUES (15, 'ALL INCL INSURANCE', 'Our single-trip all-inclusive plan provides travel insurance for one trip anywhere in the world. This plan includes all the insurances mentioned above' , 150);


CREATE TABLE VCVT_FL_PR (FLIGHTID serial PRIMARY KEY,
						 P_ID INT NULL,
						 A_ID INT NULL,
						 F_ID INT NULL,
						 ARPT_CODE VARCHAR(4) NULL,
						 MEAL_ID VARCHAR(5) NULL,
						 CABIN_ID VARCHAR(3) NULL);

CREATE TABLE VCVT_FLT (F_ID INT NOT NULL PRIMARY KEY,
	D_TIME TIMESTAMP WITH TIME ZONE NOT NULL,
	D_TZ VARCHAR(3) NOT NULL,
	ARR_TIME TIMESTAMP WITH TIME ZONE NOT NULL,
	A_TZ VARCHAR(3) NOT NULL,
	AM_ID SMALLINT NOT NULL,
	ARPT_CODE_ARV VARCHAR(4) NOT NULL,
	ARPT_CODE_DEP VARCHAR(4) NOT NULL);

CREATE TABLE vcvt_al (a_id INT NOT NULL primary key,a_name VARCHAR(30) NOT NULL, main_hub VARCHAR(30) NOT NULL, hq_city VARCHAR(30) NOT NULL, country VARCHAR(30) NOT NULL
);


CREATE TABLE vcvt_airmdl (am_id	SMALLINT NOT NULL primary key,
model_name VARCHAR(30) NOT NULL, manufacturer VARCHAR(30) NOT NULL, noe	SMALLINT NOT NULL,
nof	SMALLINT NOT NULL
);

CREATE TABLE vcvt_apt ( arpt_code VARCHAR(4) NOT NULL primary key,
arpt_name VARCHAR(50) NOT NULL, city	VARCHAR(20) NOT NULL, country VARCHAR(30) NOT NULL, type		VARCHAR(20) NOT NULL
);

CREATE TABLE vdvt_cabin (cabin_id	VARCHAR(3) NOT NULL primary key,
cabin_class VARCHAR(30) NOT NULL );


 CREATE TABLE vcvt_spereq (
sr_id VARCHAR(5) NOT NULL primary key,
sr_name VARCHAR(30) NULL
);
CREATE TABLE vcvt_meal (
meal_id VARCHAR(5) NOT NULL,
meal_plan VARCHAR(30) NOT NULL
);

CREATE TABLE VCVT_SR_FL_PR (P_ID INT NOT NULL,
							SR_ID VARCHAR(5) NOT NULL,
							A_ID INT NULL,
							F_ID INT  NULL,
							ARPT_CODE VARCHAR(4) NULL);
CREATE TABLE VCVT_INVCE_NMBR (INVOICE_NUMBER BIGINT NOT NULL,
								INVOICE_DATE TIMESTAMP(0) NOT NULL,
								INVOICE_AMT DECIMAL(7,2) NOT NULL,
								C_ID INT NOT NULL);
CREATE SEQUENCE invoice_increment
  start 2683881
  increment 1;
 --select last_value from invoice_increment
INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME ,AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1000, TIMESTAMP '2021-11-12 12:00:12' , 'EST', TIMESTAMP '2021-11-14 06:00:00', 51, 'DEL','BOM','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1001, TIMESTAMP '2021-11-13 4:00:00', 'EST', TIMESTAMP '2021-11-14 2:00:00', 52, 'DEL','BOM','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1002, TIMESTAMP '2021-11-14 7:00:00', 'EST', TIMESTAMP '2021-11-15 11:00:00',  53, 'EWR','PVG','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1003, TIMESTAMP '2021-11-14 21:30:53', 'EST', TIMESTAMP '2021-11-15 7:30:00',  51, 'DEL','BOM','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1004, TIMESTAMP '2021-11-15 13:30:00', 'EST', TIMESTAMP '2021-11-16 9:30:00',  52, 'DEL','BOM','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1005, TIMESTAMP '2021-11-14 4:00:00', 'EST', TIMESTAMP '2021-11-15 7:00:00',  54, 'DEL','BOM','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1006, TIMESTAMP '2021-11-14 13:00:00', 'EST', TIMESTAMP '2021-11-15 2:00:00', 53, 'DEL','MAA','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1007, TIMESTAMP '2021-11-14 8:00:00', 'EST', TIMESTAMP '2021-11-15 16:30:00', 52, 'DEL','BOM','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1008, TIMESTAMP '2021-11-14 2:00:00', 'EST', TIMESTAMP '2021-11-15 21:00:00', 51, 'BLR','JFK','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1009, TIMESTAMP '2021-11-14 7:45:00', 'EST', TIMESTAMP '2021-11-15 5:45:34',  53, 'DEL','BOM','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1110, TIMESTAMP '2021-11-14 2:00:00', 'EST', TIMESTAMP '2021-11-15 6:30:00',  54, 'HAK','DEL','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1111, TIMESTAMP '2021-11-14 5:45:00', 'EST', TIMESTAMP '2021-11-15 2:00:56', 52, 'PVG','BKK','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1112, TIMESTAMP '2021-11-14 14:00:00', 'EST', TIMESTAMP '2021-11-15 22:00:00',  52, 'BKK','MAD','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1113, TIMESTAMP '2021-11-14 5:45:00', 'EST', TIMESTAMP '2021-11-16 16:00:00', 55, 'JOT','BLR','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1114, TIMESTAMP '2021-11-14 22:45:00', 'EST', TIMESTAMP '2021-11-15 11:30:00',  59, 'DEL','BOM','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1115, TIMESTAMP '2021-11-15 17:45:00', 'EST', TIMESTAMP '2021-11-16 9:15:00', 59, 'DEL','JOT','GMT');

INSERT INTO VCVT_FLT (F_ID, D_TIME, D_TZ, ARR_TIME,  AM_ID, ARPT_CODE_ARV, ARPT_CODE_DEP,A_TZ)
VALUES (1116, TIMESTAMP '2021-11-14 2:00:00', 'EST', TIMESTAMP '2021-11-15 21:00:00', 54, 'BLR','JOT','GMT');


INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (111, 'EMIRATES', 'DUBAI INT AIRPT', 'DUBAI', 'UAE');
INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (112, 'UNITED AIRLINES', 'LOS ANGELES INT AIRPT', 'CHICAGO', 'USA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (113, 'DELTA AIRLINES', 'ATLANTA INT AIRPT', 'ATLANTA', 'USA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (114, 'AMERICAN AIRLINES', 'DALLAS INT AIRPT', 'FORT WORTH', 'USA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY)
VALUES (115, 'US AIRLINES', 'JOHN FKENNEDY INT AIRPT', 'FORT WORTH', 'USA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY)
VALUES (116, 'JETBLUE AIRWAYS', 'JOHN F.KENNEDY', 'LONG ISLAND CITY', 'USA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY)
VALUES (117, 'AIR CHINA', 'BEIJING INT AIRPT', 'BEIJING', 'USA');
INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (118, 'CATHAY PACIFIC', 'HONGKONG INT AIRPT', 'HONGKONG', 'USA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY)
 
VALUES (119, 'CHINA AIRLINES', 'TAIWAN INT AIRPT', 'DAYUAN', 'USA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY)
VALUES (120, 'CHINA SOUTHERN AIRLINES', 'GUANZHOU INT AIRPT', 'GUANGZHOU', 'USA');
INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (121, 'BRITISH AIRWAYS', 'HEATHROW AIRPT', 'LONDON', 'USA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (122, 'AIR INDIA', 'INDRA GANDHI INT AIRPT', 'DELHI', 'USA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (123, 'LUFTHANSA', 'MUNICH INT AIRPT', 'COLOGNE', 'GERMANY'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (124, 'QATAR AIRWAYS', 'HAMAD INT AIRPT', 'DOHA', 'QATAR'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (125, 'SWISS', 'ZURICH AIRPT', 'BASEL', 'SWITZERLAND');
INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (126, 'KOREAN AIR', 'GIMPO INT AIRPT', 'SEOUL', 'SOUTH KOREA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (127, 'AIR CANADA', 'TORONTO PEARSON INT AIRPT', 'TORONTO', 'CANADA');
INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (128, 'JET AIRWAYS', 'INDIRA GANDHI INT AIRPT', 'MUMBAI', 'INDIA'); INSERT INTO VCVT_AL (A_ID, A_NAME, MAIN_HUB, HQ_CITY, COUNTRY) VALUES (129, 'SINGAPORE AIRLINES', 'SINGAPORE CHANGI AIRPT', 'AIRLINE HOUSE', 'SINGAPORE');

INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('AVML', 'Indian Vegetarian Meal');
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('HNML', 'Non-Vegetarian Hindu Meal'); 
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('VJML', 'Vegeterian Jain Meal'); 
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('KSML', 'Kosher Meal');
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('BLML', 'Bland Meal');
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('DBML', 'Diabetic Meal');
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('GFML', 'Gluten-Friendly Meal');
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('LFML', 'Low-Fat Meal');
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('LSML', 'Low-Salt Meal');
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('VGML', 'Vegan Meal');
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('CHML', 'Child Meal');
INSERT INTO VCVT_MEAL (MEAL_ID, MEAL_PLAN) VALUES ('BBML', 'Baby Meal');


INSERT INTO VDVT_CABIN (CABIN_ID, CABIN_CLASS) VALUES ('EC', 'ECONOMY CLASS');
INSERT INTO VDVT_CABIN (CABIN_ID, CABIN_CLASS) VALUES ('EP', 'ECONOMY PLUS CLASS');
INSERT INTO VDVT_CABIN (CABIN_ID, CABIN_CLASS) VALUES ('BC', 'BUSINESS CLASS');
INSERT INTO VDVT_CABIN (CABIN_ID, CABIN_CLASS) VALUES ('FC', 'FIRST CLASS');

INSERT INTO VCVT_SPEREQ (SR_ID, SR_NAME) VALUES ('30', 'DisabLE Assistance');
INSERT INTO VCVT_SPEREQ (SR_ID, SR_NAME) VALUES ('31', 'Travel with infants');
INSERT INTO VCVT_SPEREQ (SR_ID, SR_NAME) VALUES ('32', 'Travel with animals');
INSERT INTO VCVT_SPEREQ (SR_ID, SR_NAME) VALUES ('33', 'Elderly passenger');
INSERT INTO VCVT_SPEREQ (SR_ID, SR_NAME) VALUES ('34', 'Medical assistance');

INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('DEL', 'INDIRA GANDHI INT AIRPORT', 'DELHI', 'INDIA', 'INTERNATIONAL');
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('BOM', 'MUMBAI INT AIRPORT', 'SANTACRUZ', 'INDIA', 'INTERNATIONAL');
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('JFK', 'JOHN F KENNEDY INT AIRPORT', 'NYC', 'USA', 'INTERNATIONAL');
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('JOT', 'JOLIET REGIONAL', 'JOLIET', 'USA', 'DOMESTIC');
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('JRH', 'JORHAT', 'JORHAT', 'USA', 'DOMESTIC');
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('EWR', 'NEWARK LIBERTY INT AIRPORT', 'NEWARK', 'USA', 'BOTH');
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('PVG', 'SHANGHAI PUDONG INT AIRPORT', 'SHANGHAI', 'CHINA', 'BOTH');
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('PKG', 'PANGKOR AIRPORT', 'PERAK', 'MALAYSIA', 'DOMESTIC');
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('BLR', 'KEMPEGOWDA AIRPORT', 'BENGLURU', 'INDIA', 'BOTH'); 
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('BKK' ,'SUVARNABHAVAN AIRPORT', 'BANGPHLI', 'THAILAND', 'BOTH');
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('HAK' ,'HAIKOU MEILAN INT AIRPORT', 'LINGSHAN', 'CHINA','BOTH' );
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('MAD' ,'MADRID BAJARAS AIRPORT', 'MADRID', 'SPAIN', 'BOTH');
INSERT INTO VCVT_APT (ARPT_CODE, ARPT_NAME, CITY, COUNTRY, TYPE) VALUES ('HND', 'TOKYO HANEDA AIRPORT', 'OTA', 'JAPAN', 'INTERNATIONAL');


-- not used


CREATE TABLE VCVT_AGENT (B_ID INT NOT NULL primary key,
					NAME VARCHAR(30) NOT NULL,
					W_ADDRESS VARCHAR(30) NOT NULL,
					PH_NUM BIGINT NOT NULL);

CREATE TABLE vcvt_bkagt (p_id INT NOT NULL ,
							b_id INT NOT NULL );

CREATE TABLE vcvt_member (p_id	INT NOT NULL,
mem_srtdate TIMESTAMP(0) NOT NULL, mem_enddate TIMESTAMP(0),
m_id	INT NOT NULL );

CREATE TABLE VCVT_MEMBERSHIP (M_ID INT NOT NULL primary key ,
							MEM_NAME VARCHAR(50) NOT NULL,
							A_ID INT NOT NULL);

INSERT INTO VCVT_AGENT (B_ID, NAME, W_ADDRESS, PH_NUM) VALUES (21, 'KAYAK', 'www.kayak.com' , 8976547896);
INSERT INTO VCVT_AGENT (B_ID, NAME, W_ADDRESS, PH_NUM) VALUES (22, 'EXPEDIA', 'www.expedia.com' , 7654990976);
 
INSERT INTO VCVT_AGENT (B_ID, NAME, W_ADDRESS, PH_NUM) VALUES (23, 'PRICELINE', 'www.priceline.com' , 7356547999); INSERT INTO VCVT_AGENT (B_ID, NAME, W_ADDRESS, PH_NUM) VALUES (24, 'ORBITZ', 'www.orbitz.com' , 9999007654);
INSERT INTO VCVT_AGENT (B_ID, NAME, W_ADDRESS, PH_NUM) VALUES (25, 'HOTWIRE', 'www.hotwire.com' , 4576547896);
INSERT INTO VCVT_AGENT (B_ID, NAME, W_ADDRESS, PH_NUM) VALUES (26, 'CHEAPOAIR', 'www.cheapoair.com' , 7776668900); INSERT INTO VCVT_AGENT (B_ID, NAME, W_ADDRESS, PH_NUM) VALUES (27, 'TRAVELOCITY', 'www.travelocity.com' , 6785567432);

INSERT INTO VCVT_AIRMDL (AM_ID, MODEL_NAME, MANUFACTURER, NOE, NOF) VALUES (51, 'AIRBUS A330-300', 'AIRBUS', 4, 870);
INSERT INTO VCVT_AIRMDL (AM_ID, MODEL_NAME, MANUFACTURER, NOE, NOF) VALUES (52, 'AIRBUS A340-300', 'AIRBUS', 2, 570);
INSERT INTO VCVT_AIRMDL (AM_ID, MODEL_NAME, MANUFACTURER, NOE, NOF) VALUES (53, 'AIRBUS A340-500', 'AIRBUS', 3, 1340);
INSERT INTO VCVT_AIRMDL (AM_ID, MODEL_NAME, MANUFACTURER, NOE, NOF) VALUES (54, 'AIRBUS A350-900', 'AIRBUS', 4, 675);
INSERT INTO VCVT_AIRMDL (AM_ID, MODEL_NAME, MANUFACTURER, NOE, NOF) VALUES (55, 'BOEING 777-200', 'BOEING', 1, 1270);
INSERT INTO VCVT_AIRMDL (AM_ID, MODEL_NAME, MANUFACTURER, NOE, NOF) VALUES (56, 'AIRBUS A340-600', 'AIRBUS', 3, 550);
INSERT INTO VCVT_AIRMDL (AM_ID, MODEL_NAME, MANUFACTURER, NOE, NOF) VALUES (57, 'BOEING 747-400', 'BOEING', 2, 1100);
INSERT INTO VCVT_AIRMDL (AM_ID, MODEL_NAME, MANUFACTURER, NOE, NOF) VALUES (58, 'BOEING 747-8', 'BOEING', 3, 950);
INSERT INTO VCVT_AIRMDL (AM_ID, MODEL_NAME, MANUFACTURER, NOE, NOF) VALUES (59, 'AIRBUS A380-800', 'AIRBUS', 1, 780);

INSERT INTO VCVT_BKAGT (P_ID, B_ID) VALUES (1008,21);
INSERT INTO VCVT_BKAGT (P_ID, B_ID) VALUES (1006,22);
INSERT INTO VCVT_BKAGT (P_ID, B_ID) VALUES (1005,23);

INSERT INTO VCVT_MEMBER (P_ID, MEM_SRTDATE, MEM_ENDDATE, M_ID) VALUES (1001, TO_DATE('11-MAR-2018', 'DD-MON-YYYY'),  TO_DATE('11-MAR-2021', 'DD-MON-YYYY'), 4);
INSERT INTO VCVT_MEMBER (P_ID, MEM_SRTDATE, MEM_ENDDATE, M_ID) VALUES (1005, TO_DATE('11-MAR-2018','DD-MON-YYYY'), TO_DATE('11-MAR-2018','DD-MON-YYYY'),1);
INSERT INTO VCVT_MEMBER (P_ID, MEM_SRTDATE, MEM_ENDDATE, M_ID) VALUES (1006, TO_DATE('11-MAY-2018','DD-MON-YYYY'),TO_DATE('11-MAR-2018','DD-MON-YYYY'), 8);
INSERT INTO VCVT_MEMBER (P_ID, MEM_SRTDATE, MEM_ENDDATE, M_ID) VALUES (1008, TO_DATE('11-MAR-2018','DD-MON-YYYY'), TO_DATE('11-MAR-2018','DD-MON-YYYY'),1);

INSERT INTO VCVT_MEMBERSHIP (M_ID,MEM_NAME,A_ID) VALUES (1, 'TrueBlue',111);
INSERT INTO VCVT_MEMBERSHIP (M_ID, MEM_NAME,A_ID)VALUES (2, 'Rapid Rewards',111);
INSERT INTO VCVT_MEMBERSHIP (M_ID, MEM_NAME,A_ID)VALUES (3, 'Mileage Plan',112);
INSERT INTO VCVT_MEMBERSHIP (M_ID, MEM_NAME,A_ID) VALUES (4, 'SkyMiles',115);
INSERT INTO VCVT_MEMBERSHIP (M_ID, MEM_NAME,A_ID)VALUES (5, 'AAdvantage',117);
INSERT INTO VCVT_MEMBERSHIP (M_ID, MEM_NAME,A_ID)VALUES (6, 'MileagePlus',115);
INSERT INTO VCVT_MEMBERSHIP (M_ID, MEM_NAME,A_ID)VALUES (7, 'HawaiianMiles',113);
INSERT INTO VCVT_MEMBERSHIP (M_ID, MEM_NAME,A_ID)VALUES (8, 'British Airways Executive Club',121);
INSERT INTO VCVT_MEMBERSHIP (M_ID, MEM_NAME,A_ID)VALUES (9, 'AirFrance Flying Blue',118);
INSERT INTO VCVT_MEMBERSHIP (M_ID, MEM_NAME,A_ID)VALUES (10, 'Virgin Atlantic Flying Club',121);
INSERT INTO VCVT_MEMBERSHIP (M_ID, MEM_NAME,A_ID)VALUES (11, 'Emirates Skywards Blue/Silver/Gold/Platinum',119);


--PROCEDURE FOR CONCURRENT TRANSACTIONS
CREATE OR REPLACE FUNCTION vcvt_insertplan (pln_id, RETURNS VOID AS $$
p_name, description
$$ LANGUAGE plpgsql;, cpp)
is
begin
INSERT INTO vcvt_ispln (PLN_ID, p_name,description, cpp) VALUES (pln_id,p_name,description, cpp);

END vcvt_insertplan;
--PROCEDURE END

