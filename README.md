# AKIlert
### Enabling timely intervention for Acute Kidney Injury
<img src="images/kidneys.png" width="100">

The purpose of this project is to create an alert system for healthcare provifders in ICU about an impending risk of acute kidney injury (AKI). A demponstration of the projet has been deployed to heroku https://akilert.herokuapp.com/
Github repo for the app https://github.com/zhakhverdyan/AKIlert-app

Link to slide deck (update when available)

AKI facts
<img src="images/twenty_percent.png" width="200">
<br>20% of ICU pateints develop AKI. This is associated with negative patient outcomes and economic burden.

Patient outcomes:
* Mortality rate 20-25% higher
* ICU length of stay 3 days longer
Economic burden:
* Adds additional $8000/ stay, or $40,000 if the pateint requires dialysis
* Estimated impact on nnual hospitalization costs $5.4-$24 billion

### Data processing
<br>For this analysis decided to focus on dynamic features. Aggregated the lab measurement data in 2 day windows. Plotted the correlations between the resulting numerical features. Since the data is not independent (e.g. multiple rows per patient) and there are multiple colinearities decided to proceed with a decision tree-based model.
<img src="images/num_correlations.png" width="500">

### Machine learning
Trained a random forest and XGBoost classifier and compared the average precision metric to a random classifier. Both models outperform the random classifier 2.5-fold. The model acheives 55% recall at 33% precision.
<img src="images/pr_curve.png" width="300">

### Feature interpretation
The strongest feature appears to be creatinine, with higher levels influencing kidney injury positively.
<img src="images/xgb_shap.png" width="300">









