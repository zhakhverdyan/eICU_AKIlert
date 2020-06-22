-- define qualifying patients >20 years old
-- no past history of kidney insuficiency, failure, obstruction or neoplasm
COPY
(SELECT DISTINCT p.patientunitstayid
   FROM patient p
  INNER JOIN pasthistory ph
     ON p.patientunitstayid = ph.patientunitstayid
  WHERE ph.pasthistoryvalue NOT ILIKE '%renal failure%'
    AND ph.pasthistoryvalue NOT ILIKE '%renal insufficiency%'
    AND CAST(p.age as char) NOT LIKE '1%'
    AND CAST(p.age as char) NOT LIKE '0%'
    AND LENGTH(p.age)>1)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/qualifying_admissions_final.csv' (format csv);

DROP TABLE IF EXISTS qualifying_admissions CASCADE;
CREATE TABLE qualifying_admissions
(
  patientunitstayid BIGINT NOT NULL,
  akidetection INT
) ;
-- load the data
 \copy qualifying_admissions FROM '~/Insight/eICU_AKIlert/data/intermediate/id_offset.csv' DELIMITER ',' CSV HEADER NULL ''


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
  WHERE l.labname='creatinine')
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/creatinine_lev_all.csv' (format csv);

/*
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
*/

COPY
(SELECT l.patientunitstayid,
        l.labname,
        l.labresult,
        l.labresultoffset
   FROM lab l
  WHERE l.labname IN ('creatinine', 'BUN', 'WBC x 1000')
    AND l.patientunitstayid IN (141168, 141203, 141227, 141296, 141297)
  ORDER BY l.patientunitstayid, l.labresultoffset, l.labname) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/test_lab_data.csv' (format csv);

COPY
(SELECT l.patientunitstayid,
       l.labname,
       l.labresult,
       l.labresultoffset,
       qa.akidetection,
       p.age,
       p.gender,
       p.ethnicity,
       p.patienthealthsystemstayid,
       p.hospitaladmitoffset,
       p.unitdischargeoffset
  FROM lab l 
 INNER JOIN qualifying_admissions qa
    ON l.patientunitstayid = qa.patientunitstayid
 INNER JOIN patient p
    ON p.patientunitstayid=l.patientunitstayid   
 WHERE qa.akidetection IS NOT NULL
   AND p.hospitaladmitoffset >= -14*24*60
   AND p.unitdischargeoffset <= 14*24*60
   AND ABS(l.labresultoffset) <= 14*24*60
   AND l.labresultoffset < qa.akidetection
   AND l.labname IN ('bedside glucose', 'potassium', 'sodium', 'Hgb', 'Hct', 'glucose', 'chloride', 'creatinine', 'BUN', 'calcium', 
                     'bicarbonate', 'platelets x 1000', 'WBC x 1000', 'RBC')
 ORDER BY 1, 4 ASC)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/positive_lab_data.csv' (format csv);


COPY
(SELECT l.patientunitstayid,
       l.labname,
       l.labresult,
       l.labresultoffset,
       p.age,
       p.gender,
       p.ethnicity,
       p.patienthealthsystemstayid,
       p.hospitaladmitoffset,
       p.unitdischargeoffset
  FROM lab l 
 INNER JOIN qualifying_admissions qa
    ON l.patientunitstayid = qa.patientunitstayid
 INNER JOIN patient p
    ON p.patientunitstayid=l.patientunitstayid   
 WHERE qa.akidetection IS NULL
   AND p.hospitaladmitoffset >= -14*24*60
   AND p.unitdischargeoffset <= 14*24*60
   AND ABS(l.labresultoffset) <= 14*24*60
   AND l.labname IN ('potassium', 'sodium', 'glucose', 'chloride', 'creatinine', 'BUN', 'calcium', 'bicarbonate')
 ORDER BY 1, 4 ASC)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/negative_lab_data.csv' (format csv);








