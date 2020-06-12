-- Query used to extract vital periodic measurement for negative class in 1 day
COPY
(SELECT vp.patientunitstayid,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.sao2) AS min_sao2, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.sao2) AS max_sao2, 
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY vp.sao2) AS mean_sao2,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS min_heartrate, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.heartrate) AS max_heartrate, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS mean_heartrate,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS min_respiration, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.respiration) AS max_respiration, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS mean_respiration
  FROM vitalperiodic vp
 INNER JOIN qualifying_admissions qa
    ON vp.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON vp.patientunitstayid=p.patientunitstayid
 WHERE vp.observationoffset>0
   AND vp.observationoffset/60<24
   AND p.unitdischargeoffset/60>24
   AND qa.aki_label=0
 GROUP BY vp.patientunitstayid) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/vitalperiodic_1day.csv' (format csv);

-- Query used to extract vital periodic measurement for negative class in 2 days
COPY
(SELECT vp.patientunitstayid,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.sao2) AS min_sao2, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.sao2) AS max_sao2, 
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY vp.sao2) AS mean_sao2,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS min_heartrate, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.heartrate) AS max_heartrate, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS mean_heartrate,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS min_respiration, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.respiration) AS max_respiration, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS mean_respiration
  FROM vitalperiodic vp
 INNER JOIN qualifying_admissions qa
    ON vp.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON vp.patientunitstayid=p.patientunitstayid
 WHERE vp.observationoffset>0
   AND vp.observationoffset/60<48
   AND p.unitdischargeoffset/60>48
   AND qa.aki_label=0
 GROUP BY vp.patientunitstayid) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/vitalperiodic_2days.csv' (format csv);

-- Query used to extract vital periodic measurement for negative class in 3 days
COPY
(SELECT vp.patientunitstayid,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.sao2) AS min_sao2, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.sao2) AS max_sao2, 
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY vp.sao2) AS mean_sao2,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS min_heartrate, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.heartrate) AS max_heartrate, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS mean_heartrate,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS min_respiration, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.respiration) AS max_respiration, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS mean_respiration
  FROM vitalperiodic vp
 INNER JOIN qualifying_admissions qa
    ON vp.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON vp.patientunitstayid=p.patientunitstayid
 WHERE vp.observationoffset>0
   AND vp.observationoffset/60<72
   AND p.unitdischargeoffset/60>72
   AND qa.aki_label=0
 GROUP BY vp.patientunitstayid) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/vitalperiodic_3days.csv' (format csv);

-- Query used to extract vital periodic measurement for negative class in 4 days
COPY
(SELECT vp.patientunitstayid,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.sao2) AS min_sao2, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.sao2) AS max_sao2, 
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY vp.sao2) AS mean_sao2,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS min_heartrate, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.heartrate) AS max_heartrate, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS mean_heartrate,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS min_respiration, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.respiration) AS max_respiration, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS mean_respiration
  FROM vitalperiodic vp
 INNER JOIN qualifying_admissions qa
    ON vp.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON vp.patientunitstayid=p.patientunitstayid
 WHERE vp.observationoffset>0
   AND vp.observationoffset/60<96
   AND p.unitdischargeoffset/60>96
   AND qa.aki_label=0
 GROUP BY vp.patientunitstayid) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/vitalperiodic_4days.csv' (format csv);

-- Query used to extract vital periodic measurement for negative class in 5 days
COPY
(SELECT vp.patientunitstayid,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.sao2) AS min_sao2, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.sao2) AS max_sao2, 
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY vp.sao2) AS mean_sao2,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS min_heartrate, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.heartrate) AS max_heartrate, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS mean_heartrate,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS min_respiration, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.respiration) AS max_respiration, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS mean_respiration
  FROM vitalperiodic vp
 INNER JOIN qualifying_admissions qa
    ON vp.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON vp.patientunitstayid=p.patientunitstayid
 WHERE vp.observationoffset>0
   AND vp.observationoffset/60<120
   AND p.unitdischargeoffset/60>120
   AND qa.aki_label=0
 GROUP BY vp.patientunitstayid) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/vitalperiodic_5days.csv' (format csv);

-- Query used to extract vital periodic measurement for positive class in all days
COPY
(SELECT vp.patientunitstayid,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.sao2) AS min_sao2, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.sao2) AS max_sao2, 
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY vp.sao2) AS mean_sao2,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS min_heartrate, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.heartrate) AS max_heartrate, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.heartrate) AS mean_heartrate,
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS min_respiration, 
       PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY vp.respiration) AS max_respiration, 
       PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY vp.respiration) AS mean_respiration
  FROM vitalperiodic vp
 INNER JOIN qualifying_admissions qa
    ON vp.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON vp.patientunitstayid=p.patientunitstayid
 WHERE vp.observationoffset>0
   AND vp.observationoffset/60 < (qa.aki_offset/60 - 12)
   AND qa.aki_label=1
 GROUP BY vp.patientunitstayid) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/positive_vitalperiodic_alldays.csv' (format csv);


