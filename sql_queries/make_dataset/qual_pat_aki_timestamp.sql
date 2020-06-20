-- define qualifying patients >20 years old
-- no past history of kidney insuficiency, failure, obstruction or neoplasm
COPY
(SELECT p.patientunitstayid,
   FROM patient p
  INNER JOIN pasthistory ph
     ON p.patientunitstayid = ph.patientunitstayid
    AND ph.pasthistoryvalue NOT ILIKE '%renal failure%'
    AND ph.pasthistoryvalue NOT ILIKE '%renal insufficiency%'
    AND CAST(p.age as char) NOT LIKE '1%'
    AND CAST(p.age as char) NOT LIKE '0%'
    AND LENGTH(p.age)>1)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate_files/qualifying_admissions_final.csv' (format csv);

DROP TABLE IF EXISTS qualifying_admissions CASCADE;
CREATE TABLE qualifying_admissions
(
  patientunitstayid BIGINT NOT NULL,
  age VARCHAR(10),
  gender VARCHAR(25),
  ethnicity VARCHAR(50),
  unitDischargeOffset INT,
  admitdxpath VARCHAR(500) NOT NULL,
  pasthistoryvalue VARCHAR(100)
  developed_aki INT NOT NULL,
  aki_diagnosis INT
) ;
-- load the data
 \copy qualifying_admissions FROM '~/Insight/eICU_dbmake/eicu-code/build-db/postgres/intermediate_files/qualifying_admissions_final.csv' DELIMITER ',' CSV HEADER NULL ''


-- get all creatinine values for qualifying pateints to detect earliest aki onset
COPY
(SELECT l.patientunitstayid,
        l.labresult,
        l.labresultoffset
   FROM lab l
  INNER JOIN qualifying_admissions qa
     ON l.patientunitstayid=qa.patientunitstayid
  INNER JOIN patient p
     ON p.patientunitstayid=l.patientunitstayid
  WHERE l.labname='creatinine'
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/creatinine_lev_all.csv' (format csv);

-- get all urine output measurements for qualifying patients to detect earliest aki onset
COPY
(SELECT DISTINCT i.patientunitstayid,
        i.intakeoutputoffset,
        i.cellvaluenumeric,
        i.celllabel
   FROM intakeoutput i
  INNER JOIN qualifying_admissions qa
     ON i.patientunitstayid=qa.patientunitstayid
 WHERE i.celllabel='Urine' OR i.celllabel='Bodyweight (kg)'
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/urine_out_all_3d.csv' (format csv);