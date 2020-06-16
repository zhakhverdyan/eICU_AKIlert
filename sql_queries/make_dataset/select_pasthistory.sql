/*COPY
(SELECT ph.patientunitstayid, ph.pasthistoryvalue, 
  CASE WHEN ph.pasthistoryvalue IS NULL THEN 0
            ELSE 1 END AS phist_count
  FROM pasthistory ph
 INNER JOIN qualifying_admissions qa
    ON ph.patientunitstayid=qa.patientunitstayid)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/past_history_pivoted.csv' (format csv);*/

-- Query used to extract average hourly intaketotal, outputtotal, dialysistotal, nettotal values for negative class in 1 day
COPY 
(SELECT it.patientunitstayid, 
       SUM(it.intaketotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_intake,
       SUM(it.outputtotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_output,
       SUM(it.dialysistotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_dialysis,
       SUM(it.nettotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_nettotal
FROM
(SELECT distinct i.patientunitstayid, 
       i.intakeoutputoffset, 
       i.intaketotal, 
       i.outputtotal,
       i.dialysistotal, 
       i.nettotal 
  from intakeoutput i
 INNER JOIN patient p
    ON i.patientunitstayid=p.patientunitstayid
 INNER JOIN qualifying_admissions qa
    ON i.patientunitstayid=qa.patientunitstayid
 WHERE i.intakeoutputoffset > 0
   AND i.intakeoutputoffset/60 < 24
   AND p.unitdischargeoffset/60 > 24
   AND qa.aki_label = 0) it
GROUP BY 1)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/intakeoutput_1day.csv' (format csv);

-- Query used to extract average hourly intaketotal, outputtotal, dialysistotal, nettotal values for negative class in 2 days
COPY 
(SELECT it.patientunitstayid, 
       SUM(it.intaketotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_intake,
       SUM(it.outputtotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_output,
       SUM(it.dialysistotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_dialysis,
       SUM(it.nettotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_nettotal
FROM
(SELECT distinct i.patientunitstayid, 
       i.intakeoutputoffset, 
       i.intaketotal, 
       i.outputtotal,
       i.dialysistotal, 
       i.nettotal 
  from intakeoutput i
 INNER JOIN patient p
    ON i.patientunitstayid=p.patientunitstayid
 INNER JOIN qualifying_admissions qa
    ON i.patientunitstayid=qa.patientunitstayid
 WHERE i.intakeoutputoffset > 0
   AND i.intakeoutputoffset/60 < 48
   AND p.unitdischargeoffset/60 > 48
   AND qa.aki_label = 0) it
GROUP BY 1)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/intakeoutput_2days.csv' (format csv);

-- Query used to extract average hourly intaketotal, outputtotal, dialysistotal, nettotal values for negative class in 3 days
COPY 
(SELECT it.patientunitstayid, 
       SUM(it.intaketotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_intake,
       SUM(it.outputtotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_output,
       SUM(it.dialysistotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_dialysis,
       SUM(it.nettotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_nettotal
FROM
(SELECT distinct i.patientunitstayid, 
       i.intakeoutputoffset, 
       i.intaketotal, 
       i.outputtotal,
       i.dialysistotal, 
       i.nettotal 
  from intakeoutput i
 INNER JOIN patient p
    ON i.patientunitstayid=p.patientunitstayid
 INNER JOIN qualifying_admissions qa
    ON i.patientunitstayid=qa.patientunitstayid
 WHERE i.intakeoutputoffset > 0
   AND i.intakeoutputoffset/60 < 72
   AND p.unitdischargeoffset/60 > 72
   AND qa.aki_label = 0) it
GROUP BY 1)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/intakeoutput_3days.csv' (format csv);

-- Query used to extract average hourly intaketotal, outputtotal, dialysistotal, nettotal values for negative class in 4 days
COPY 
(SELECT it.patientunitstayid, 
       SUM(it.intaketotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_intake,
       SUM(it.outputtotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_output,
       SUM(it.dialysistotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_dialysis,
       SUM(it.nettotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_nettotal
FROM
(SELECT distinct i.patientunitstayid, 
       i.intakeoutputoffset, 
       i.intaketotal, 
       i.outputtotal,
       i.dialysistotal, 
       i.nettotal 
  from intakeoutput i
 INNER JOIN patient p
    ON i.patientunitstayid=p.patientunitstayid
 INNER JOIN qualifying_admissions qa
    ON i.patientunitstayid=qa.patientunitstayid
 WHERE i.intakeoutputoffset > 0
   AND i.intakeoutputoffset/60 < 96
   AND p.unitdischargeoffset/60 > 96
   AND qa.aki_label = 0) it
GROUP BY 1)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/intakeoutput_4days.csv' (format csv);

-- Query used to extract intaketotal, outputtotal, dialysistotal, nettotal values for negative class in 5 days
COPY 
(SELECT it.patientunitstayid, 
       SUM(it.intaketotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_intake,
       SUM(it.outputtotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_output,
       SUM(it.dialysistotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_dialysis,
       SUM(it.nettotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_nettotal
FROM
(SELECT distinct i.patientunitstayid, 
       i.intakeoutputoffset, 
       i.intaketotal, 
       i.outputtotal,
       i.dialysistotal, 
       i.nettotal 
  from intakeoutput i
 INNER JOIN patient p
    ON i.patientunitstayid=p.patientunitstayid
 INNER JOIN qualifying_admissions qa
    ON i.patientunitstayid=qa.patientunitstayid
 WHERE i.intakeoutputoffset > 0
   AND i.intakeoutputoffset/60 < 120
   AND p.unitdischargeoffset/60 > 120
   AND qa.aki_label = 0) it
GROUP BY 1)
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/intakeoutput_5days.csv' (format csv);

-- Query used to extract average hourly intaketotal, outputtotal, dialysistotal, nettotal values for positive class for all days
COPY
(SELECT it.patientunitstayid, 
       SUM(it.intaketotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_intake,
       SUM(it.outputtotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_output,
       SUM(it.dialysistotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_dialysis,
       SUM(it.nettotal)/MAX(it.intakeoutputoffset/60) AS ave_hourly_nettotal
FROM
(SELECT distinct i.patientunitstayid, 
       i.intakeoutputoffset, 
       i.intaketotal, 
       i.outputtotal,
       i.dialysistotal, 
       i.nettotal 
  from intakeoutput i
 INNER JOIN patient p
    ON i.patientunitstayid=p.patientunitstayid
 INNER JOIN qualifying_admissions qa
    ON i.patientunitstayid=qa.patientunitstayid
 WHERE i.intakeoutputoffset > 0
   AND qa.aki_label = 1) it
GROUP BY 1)
  TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/pos_intakeoutput_alldays.csv' (format csv);
