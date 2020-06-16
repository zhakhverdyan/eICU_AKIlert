-- create admission diagnosis table
DROP TABLE IF EXISTS admissiondx CASCADE;
CREATE TABLE admissiondx
(
  admissiondxid BIGINT NOT NULL,
  patientunitstayid BIGINT NOT NULL,
  admitdxenteredoffset BIGINT NOT NULL,
  admitdxpath VARCHAR(500) NOT NULL,
  admitdxname VARCHAR(255),
  admitdxtext VARCHAR(255),
  CONSTRAINT admissiondxid PRIMARY KEY (admissiondxid)
) ;
-- load the data
 \copy ADMISSIONDX FROM '~/Insight/eICU_dbmake/eicu-code/build-db/postgres/csv_files/admissionDx.csv' DELIMITER ',' CSV HEADER NULL ''

-- create patient table
DROP TABLE IF EXISTS patient CASCADE;
CREATE TABLE patient
(
	patientunitstayid INT,
	patienthealthsystemstayid INT,
	gender VARCHAR(25),
	age VARCHAR(10),
	ethnicity VARCHAR(50),
	hospitalid INT,
	wardid INT,
	apacheadmissiondx VARCHAR(1000),
	admissionheight NUMERIC(10,2),
	hospitaladmittime24 VARCHAR(8),
	hospitaladmitoffset INT,
	hospitaladmitsource VARCHAR(30),
	hospitaldischargeyear SMALLINT,
	hospitaldischargetime24 VARCHAR(8),
	hospitaldischargeoffset INT,
	hospitaldischargelocation VARCHAR(100),
	hospitaldischargestatus VARCHAR(10),
	unittype VARCHAR(50),
	unitadmittime24 VARCHAR(8),
	unitadmitsource VARCHAR(100),
	unitvisitnumber INT,
	unitstaytype VARCHAR(15),
	admissionweight NUMERIC(10,2),
	dischargeweight NUMERIC(10,2),
	unitdischargetime24 VARCHAR(8),
	unitdischargeoffset INT,
	unitdischargelocation VARCHAR(100),
	unitdischargestatus VARCHAR(10),
	uniquepid VARCHAR(10),
	CONSTRAINT patientunitstayid PRIMARY KEY (patientunitstayid)
) ;
--load data
\copy patient FROM '~/Insight/eICU_dbmake/eicu-code/build-db/postgres/csv_files/patient.csv' DELIMITER ',' CSV HEADER NULL ''

-- create pasthistory table
DROP TABLE IF EXISTS pasthistory CASCADE;
CREATE TABLE pasthistory
(
	pasthistoryid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	pasthistoryoffset INT NOT NULL,
	pasthistoryenteredoffset INT NOT NULL,
	pasthistorynotetype VARCHAR(40),
	pasthistorypath VARCHAR(255) NOT NULL,
	pasthistoryvalue VARCHAR(100),
	pasthistoryvaluetext VARCHAR(255),
	CONSTRAINT pasthistoryid PRIMARY KEY (pasthistoryid)
) ;
--load data
\copy pasthistory FROM '~/Insight/eICU_dbmake/eicu-code/build-db/postgres/csv_files/pastHistory.csv' DELIMITER ',' CSV HEADER NULL ''

--create lab table
DROP TABLE IF EXISTS lab CASCADE;
CREATE TABLE lab
(
  labid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	labresultoffset INT NOT NULL,
	labtypeid NUMERIC(3,0) NOT NULL,
	labname VARCHAR(256),
	labresult NUMERIC(11,4),
	labresulttext VARCHAR(255),
	labmeasurenamesystem VARCHAR(255),
	labmeasurenameinterface VARCHAR(255),
	labresultrevisedoffset INT, 
	CONSTRAINT labid PRIMARY KEY (labid)
) ;

--load data
\copy lab FROM '~/Insight/eICU_dbmake/eicu-code/build-db/postgres/csv_files/lab.csv' DELIMITER ',' CSV HEADER NULL ''

--create intakeoutput table
DROP TABLE IF EXISTS intakeoutput CASCADE;
CREATE TABLE intakeoutput
(
	intakeoutputid INT NOT NULL,
    patientunitstayid INT NOT NULL,
	intakeoutputoffset FLOAT NOT NULL,
	intaketotal NUMERIC(12,4),
	outputtotal NUMERIC(12,4),
	dialysistotal NUMERIC(12,4),
	nettotal NUMERIC(12,4),
	intakeoutputentryoffset INT NOT NULL,
	cellpath VARCHAR(500),
	celllabel VARCHAR(255),
	cellvaluenumeric NUMERIC(12,4) NOT NULL,
	cellvaluetext VARCHAR(255) NOT NULL,
	CONSTRAINT intakeoutputid PRIMARY KEY (intakeoutputid)
) ;
--load data
\copy intakeoutput FROM '~/Insight/eICU_dbmake/eicu-code/build-db/postgres/csv_files/intakeOutput.csv' DELIMITER ',' CSV HEADER NULL ''

--create vitalperiodic table
DROP TABLE IF EXISTS vitalperiodic CASCADE;
CREATE TABLE vitalperiodic
(
  vitalperiodicid BIGINT,
	patientunitstayid INT,
	observationoffset INT,
	temperature NUMERIC(11,4),
	sao2 INT,
	heartrate INT,
	respiration INT,
	cvp INT,
	etco2 INT,
	systemicsystolic INT,
	systemicdiastolic INT,
	systemicmean INT,
	pasystolic INT,
	padiastolic INT,
	pamean INT,
	st1 DOUBLE PRECISION,
	st2 DOUBLE PRECISION,
	st3 DOUBLE PRECISION,
	icp INT, 
	CONSTRAINT vitalperiodicid PRIMARY KEY (vitalperiodicid)
) ;
--load data
\copy vitalperiodic FROM '~/Insight/eICU_dbmake/eicu-code/build-db/postgres/csv_files/vitalPeriodic.csv' DELIMITER ',' CSV HEADER NULL ''

--create diagnosis table
DROP TABLE IF EXISTS diagnosis CASCADE;
CREATE TABLE diagnosis
(
  diagnosisid INT NOT NULL,
	patientunitstayid INT NOT NULL,
	activeupondischarge VARCHAR(64),
	diagnosisoffset INT NOT NULL,
	diagnosisstring VARCHAR(200) NOT NULL,
	icd9code VARCHAR(100),
	diagnosispriority VARCHAR(10) NOT NULL,
	CONSTRAINT diagnosisid PRIMARY KEY (diagnosisid)
) ;

--load data
\copy diagnosis FROM '~/Insight/eICU_dbmake/eicu-code/build-db/postgres/csv_files/diagnosis.csv' DELIMITER ',' CSV HEADER NULL ''