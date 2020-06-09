COPY 
(SELECT l.patientunitstayid, 
       l.labname, 
       MIN(l.labresult) AS min_result, 
       MAX(l.labresult) AS max_result, 
       MAX(l.labresult)-MIN(labresult) AS delta_result
  FROM lab l
 INNER JOIN qualifying_admissions qa
 ON l.patientunitstayid=qa.patientunitstayid
 WHERE l.labresultoffset>0 
   AND l.labresultoffset/60<12
   AND l.labname in ('bedside glucose', 'potassium', 'sodium', 'glucose', 'Hgb', 'Hct', 'chloride', 'creatinine', 'BUN', 'calcium', 
                   'bicarbonate', 'platelets x 1000', 'WBC x 1000', 'RBC', 'MCV', 'MCHC', 'anion gap', 'RDW', 'MCH', 'FiO2', 'paO2', 
                   'paCO2', 'pH', 'MPV', 'HCO3', 'magnesium')
 GROUP BY l.patientunitstayid, l.labname) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/lab_summary.csv' (format csv);

COPY
(SELECT vp.patientunitstayid,
       MIN(vp.sao2) AS min_sao2, MAX(vp.sao2) AS max_sao2, AVG(vp.sao2) AS mean_sao2,
       MIN(vp.heartrate) AS min_heartrate, MAX(vp.heartrate) AS max_heartrate, AVG(vp.heartrate) AS mean_heartrate,
       MIN(vp.respiration) AS min_respiration, MAX(vp.respiration) AS max_respiration, AVG(vp.respiration) AS mean_respiration
  FROM vitalperiodic vp
 INNER JOIN qualifying_admissions qa
    ON vp.patientunitstayid=qa.patientunitstayid
 WHERE vp.observationoffset/60<24
 GROUP BY vp.patientunitstayid) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/vitalperiodic_summary.csv' (format csv);

 