COPY
(SELECT p.patientunitstayid, p.age, p.gender, p.ethnicity, p.unitDischargeOffset, a.admitdxpath, ph.pasthistoryvalue,
CASE WHEN d.diagnosisstring ILIKE '%acute renal%' THEN 1 ELSE 0 END AS developed_aki,
CASE WHEN d.diagnosisstring ILIKE '%acute renal%' THEN d.diagnosisoffset ELSE NULL END AS aki_diagnosis
FROM patient p
INNER JOIN admissiondx a
ON p.patientunitstayid = a.patientunitstayid
INNER JOIN pasthistory ph
ON p.patientunitstayid = ph.patientunitstayid
INNER JOIN diagnosis d
ON p.patientunitstayid = d.patientunitstayid
WHERE a.admitdxpath!='admission diagnosis|All Diagnosis|Non-operative|Diagnosis|Genitourinary|Renal failure, acute'
AND a.admitdxpath!='admission diagnosis|All Diagnosis|Non-operative|Diagnosis|Genitourinary|Renal obstruction'
AND a.admitdxpath!='admission diagnosis|All Diagnosis|Non-operative|Diagnosis|Genitourinary|Renal neoplasm, cancer'
AND ph.pasthistoryvalue NOT ILIKE '%renal failure%'
AND CAST(p.age as char) NOT LIKE '1%'
AND CAST(p.age as char) NOT LIKE '0%'
AND LENGTH(p.age)>1
AND p.unitDischargeOffset/60 > 24)
AND (d.diagnosisstring ILIKE '%acute renal%' AND d.diagnosisoffset/60>48)
OR d.diagnosisstring NOT ILIKE '%acute renal%'
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate_files/qualifying_admissions.csv' (format csv);

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
 \copy qualifying_admissions FROM '~/Insight/eICU_dbmake/eicu-code/build-db/postgres/intermediate_files/qualifying_admissions.csv' DELIMITER ',' CSV HEADER NULL ''


SELECT count(distinct(d.patientunitstayid)) 
FROM diagnosis d
INNER JOIN qualifying_admissions qa 
ON d.patientunitstayid = qa.patientunitstayid
WHERE d.diagnosisstring ilike '%acute renal%'
AND d.diagnosisoffset/60>48


(SELECT p.patientunitstayid, p.age, p.gender, p.ethnicity, p.unitDischargeOffset, a.admitdxpath 
FROM patient p
JOIN admissiondx a
ON p.patientunitstayid = a.patientunitstayid
JOIN pasthistory ph
ON p.patientunitstayid = ph.patientunitstayid
WHERE a.admitdxpath!='admission diagnosis|All Diagnosis|Non-operative|Diagnosis|Genitourinary|Renal failure, acute'
AND a.admitdxpath!='admission diagnosis|All Diagnosis|Non-operative|Diagnosis|Genitourinary|Renal obstruction'
AND a.admitdxpath!='admission diagnosis|All Diagnosis|Non-operative|Diagnosis|Genitourinary|Renal neoplasm, cancer'
AND ph.pasthistoryvalue NOT ILIKE '%renal failure%'
AND ph.pasthistoryvalue NOT ILIKE '%renal failure%'
AND CAST(p.age as char) NOT LIKE '1%'
AND CAST(p.age as char) NOT LIKE '0%'
AND LENGTH(p.age)>1
AND p.unitDischargeOffset/60 > 48) qa
ON d.patientunitstayid = qa.patientunitstayid
WHERE d.diagnosisstring ilike '%acute renal%'
