-- Query used to extract lab results for negative class in 1 day
COPY 
(SELECT l.patientunitstayid, 
       l.labname, 
       MIN(l.labresult) AS min_result, 
       MAX(l.labresult) AS max_result, 
       MAX(l.labresult)-MIN(labresult) AS delta_result
  FROM lab l
 INNER JOIN qualifying_admissions qa
 ON l.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON l.patientunitstayid=p.patientunitstayid
 WHERE l.labresultoffset>0 
   AND l.labresultoffset/60<24
   AND p.unitdischargeoffset/60>24
   AND l.labname in ('bedside glucose', 'potassium', 'sodium', 'glucose', 'Hgb', 'Hct', 'chloride', 'creatinine', 'BUN', 'calcium', 
                   'bicarbonate', 'platelets x 1000', 'WBC x 1000', 'RBC', 'MCV', 'MCHC', 'anion gap', 'RDW', 'MCH', 'FiO2', 'paO2', 
                   'paCO2', 'pH', 'MPV', 'HCO3', 'magnesium')
   AND qa.aki_label=0
 GROUP BY l.patientunitstayid, l.labname) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/negative_lab_summary_1day.csv' (format csv);

-- Query used to extract lab results for negative class in 2 days
COPY 
(SELECT l.patientunitstayid, 
       l.labname, 
       MIN(l.labresult) AS min_result, 
       MAX(l.labresult) AS max_result, 
       MAX(l.labresult)-MIN(labresult) AS delta_result
  FROM lab l
 INNER JOIN qualifying_admissions qa
 ON l.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON l.patientunitstayid=p.patientunitstayid
 WHERE l.labresultoffset>0 
   AND l.labresultoffset/60<48
   AND p.unitdischargeoffset/60>48
   AND l.labname in ('bedside glucose', 'potassium', 'sodium', 'glucose', 'Hgb', 'Hct', 'chloride', 'creatinine', 'BUN', 'calcium', 
                   'bicarbonate', 'platelets x 1000', 'WBC x 1000', 'RBC', 'MCV', 'MCHC', 'anion gap', 'RDW', 'MCH', 'FiO2', 'paO2', 
                   'paCO2', 'pH', 'MPV', 'HCO3', 'magnesium')
   AND qa.aki_label=0
 GROUP BY l.patientunitstayid, l.labname) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/negative_lab_summary_2days.csv' (format csv);

-- Query used to extract lab results for negative class in 3 days
COPY 
(SELECT l.patientunitstayid, 
       l.labname, 
       MIN(l.labresult) AS min_result, 
       MAX(l.labresult) AS max_result, 
       MAX(l.labresult)-MIN(labresult) AS delta_result
  FROM lab l
 INNER JOIN qualifying_admissions qa
 ON l.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON l.patientunitstayid=p.patientunitstayid
 WHERE l.labresultoffset>0 
   AND l.labresultoffset/60<72
   AND p.unitdischargeoffset/60>72
   AND l.labname in ('bedside glucose', 'potassium', 'sodium', 'glucose', 'Hgb', 'Hct', 'chloride', 'creatinine', 'BUN', 'calcium', 
                   'bicarbonate', 'platelets x 1000', 'WBC x 1000', 'RBC', 'MCV', 'MCHC', 'anion gap', 'RDW', 'MCH', 'FiO2', 'paO2', 
                   'paCO2', 'pH', 'MPV', 'HCO3', 'magnesium')
   AND qa.aki_label=0
 GROUP BY l.patientunitstayid, l.labname) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/negative_lab_summary_3days.csv' (format csv);

-- Query used to extract lab results for negative class in 4 days
COPY 
(SELECT l.patientunitstayid, 
       l.labname, 
       MIN(l.labresult) AS min_result, 
       MAX(l.labresult) AS max_result, 
       MAX(l.labresult)-MIN(labresult) AS delta_result
  FROM lab l
 INNER JOIN qualifying_admissions qa
 ON l.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON l.patientunitstayid=p.patientunitstayid
 WHERE l.labresultoffset>0 
   AND l.labresultoffset/60<96
   AND p.unitdischargeoffset/60>96
   AND l.labname in ('bedside glucose', 'potassium', 'sodium', 'glucose', 'Hgb', 'Hct', 'chloride', 'creatinine', 'BUN', 'calcium', 
                   'bicarbonate', 'platelets x 1000', 'WBC x 1000', 'RBC', 'MCV', 'MCHC', 'anion gap', 'RDW', 'MCH', 'FiO2', 'paO2', 
                   'paCO2', 'pH', 'MPV', 'HCO3', 'magnesium')
   AND qa.aki_label=0
 GROUP BY l.patientunitstayid, l.labname) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/negative_lab_summary_4days.csv' (format csv);

-- Query used to extract lab results for negative class in 5 days
COPY 
(SELECT l.patientunitstayid, 
       l.labname, 
       MIN(l.labresult) AS min_result, 
       MAX(l.labresult) AS max_result, 
       MAX(l.labresult)-MIN(labresult) AS delta_result
  FROM lab l
 INNER JOIN qualifying_admissions qa
 ON l.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON l.patientunitstayid=p.patientunitstayid
 WHERE l.labresultoffset>0 
   AND l.labresultoffset/60<120
   AND p.unitdischargeoffset/60>120
   AND l.labname in ('bedside glucose', 'potassium', 'sodium', 'glucose', 'Hgb', 'Hct', 'chloride', 'creatinine', 'BUN', 'calcium', 
                   'bicarbonate', 'platelets x 1000', 'WBC x 1000', 'RBC', 'MCV', 'MCHC', 'anion gap', 'RDW', 'MCH', 'FiO2', 'paO2', 
                   'paCO2', 'pH', 'MPV', 'HCO3', 'magnesium')
   AND qa.aki_label=0
 GROUP BY l.patientunitstayid, l.labname) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/negative_lab_summary_5days.csv' (format csv);


-- Query used to extract lab results for positive class up to 12h prior to dignosis
COPY 
(SELECT l.patientunitstayid, 
       l.labname, 
       MIN(l.labresult) AS min_result, 
       MAX(l.labresult) AS max_result, 
       MAX(l.labresult)-MIN(labresult) AS delta_result
  FROM lab l
 INNER JOIN qualifying_admissions qa
 ON l.patientunitstayid=qa.patientunitstayid
 INNER JOIN patient p
 ON l.patientunitstayid=p.patientunitstayid
 WHERE l.labresultoffset>0 
   AND l.labresultoffset/60 < (qa.aki_offset/60 - 12)
   AND l.labname in ('bedside glucose', 'potassium', 'sodium', 'glucose', 'Hgb', 'Hct', 'chloride', 'creatinine', 'BUN', 'calcium', 
                   'bicarbonate', 'platelets x 1000', 'WBC x 1000', 'RBC', 'MCV', 'MCHC', 'anion gap', 'RDW', 'MCH', 'FiO2', 'paO2', 
                   'paCO2', 'pH', 'MPV', 'HCO3', 'magnesium')
   AND qa.aki_label=1
 GROUP BY l.patientunitstayid, l.labname) 
TO '/Users/zhannahakhverdyan/Insight/eICU_AKIlert/data/intermediate/positive_lab_summary_alldays.csv' (format csv);

