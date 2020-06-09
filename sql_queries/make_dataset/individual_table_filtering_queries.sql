COPY 
(SELECT t1.patientunitstayid, t4.aki_in_diagnosis, t4.aki_offset
FROM
--this query selects patientunitstayids that do not have kidney problems at admission
(SELECT a.patientunitstayid
FROM
(SELECT patientunitstayid, string_agg(admitdxpath, ', ') AS concat_diag_path
  FROM admissiondx
  GROUP BY patientunitstayid) a
WHERE a.concat_diag_path NOT ILIKE '%renal failure, acute%'
AND a.concat_diag_path NOT ILIKE '%renal obstruction%'
AND a.concat_diag_path NOT ILIKE '%renal neoplasm, cancer%') t1
INNER JOIN
-- this query selects patientunitstayid for qualifying admissions, who develop aki after 24h or don't develop aki
(SELECT distinct(d.patientunitstayid)
FROM diagnosis d
LEFT JOIN
(SELECT distinct(patientunitstayid)
FROM diagnosis 
WHERE (diagnosisstring ILIKE '%acute renal failure%' 
OR diagnosisstring ILIKE '%chronic kidney disease%' 
OR diagnosisstring ILIKE '%kidney obstruction%') 
AND diagnosisoffset/60<24) e
ON d.patientunitstayid=e.patientunitstayid
WHERE e.patientunitstayid IS NULL) t2
ON t1.patientunitstayid=t2.patientunitstayid
INNER JOIN
-- this query selects patients > 20 years old that do not have past history of kidney failure/insufficiency
(SELECT p.patientunitstayid
FROM patient p
INNER JOIN
(SELECT patientunitstayid, string_agg(pasthistoryvalue, ', ') AS concat_pasthistoryvalue
  FROM pasthistory
  GROUP BY patientunitstayid) ph
ON p.patientunitstayid=ph.patientunitstayid
WHERE ph.concat_pasthistoryvalue NOT ILIKE '%renal failure%'
AND ph.concat_pasthistoryvalue NOT ILIKE '%renal insufficiency%'
AND CAST(p.age as char) NOT LIKE '1%'
AND CAST(p.age as char) NOT LIKE '0%'
AND LENGTH(p.age)>1
AND p.unitDischargeOffset/60 > 24) t3
ON t2.patientunitstayid=t3.patientunitstayid
INNER JOIN
-- this query labels patientunitstayid as 1/0 for aki development after 24h as well as pull diagnosis time
(SELECT d1.patientunitstayid, d2.aki_offset,
CASE WHEN d1.concat_diag ILIKE '%acute renal failure%' THEN 1 ELSE 0 END AS aki_in_diagnosis
FROM
(SELECT patientunitstayid, string_agg(diagnosisstring, ', ') AS concat_diag
FROM diagnosis
GROUP BY patientunitstayid) d1
FULL OUTER JOIN
(SELECT DISTINCT ON (patientunitstayid) patientunitstayid, diagnosisoffset AS aki_offset
FROM diagnosis
WHERE diagnosisstring ILIKE '%acute renal failure%'
ORDER BY 1, 2 ASC) d2
ON d1.patientunitstayid=d2.patientunitstayid) t4
ON t3.patientunitstayid=t4.patientunitstayid)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/patid_aki_label_offset.csv' (format csv);
