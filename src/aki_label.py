import math
import numpy as np
import pandas as pd
import time
 
def creat_label_timeoffset(df):
    start_time = time.time
    """Calculate the difference between consecutive creatinine measurements and identify if abnormal according to KDIGO standards"""
    # replicate labresult column and push 1 down to calculate the difference between current and previous measurement
    df['prev_labresult'] = df.groupby(['patientunitstayid'])['labresult'].shift(1)
    df['delta'] = df['labresult'] - df['prev_labresult']

    # calculate a rolling sum of creatinine differences over 48 h rolling window
    df['labresultoffset'] = pd.to_timedelta(df['labresultoffset'], unit='minute')
    df.set_index('labresultoffset', inplace=True)
    df['creat_2day_cum'] = df.groupby('patientunitstayid')['delta'].apply(lambda x: x.rolling('2d').sum()) 
    print("2 day cumulative change calculated")

    # calculate a cumulative fold increase from baseline over 7 day rolling window
    df['creat_fold_change'] = df['labresult']/df['prev_labresult']
    df['creat_7day_inc'] = df.groupby('patientunitstayid')['creat_fold_change'].apply(lambda x: x.rolling('7d').apply(np.prod))
    print("7 day fold increase calculated")

    # label abnormal measurement rows
    df.loc[df['creat_2day_cum'] >= 0.3, 'AKI_reached_2d'] = 1
    df.loc[df['creat_7day_inc'] >= 1.5, 'AKI_reached_7d'] = 1
    df.fillna(0, inplace=True)

    # create a new dataframe to collect only the first instances of the positive class
    df.reset_index(inplace=True)
    first_2d = df[df['AKI_reached_2d']==1].groupby('patientunitstayid')['labresultoffset'].first()
    first_2d = first_2d/pd.Timedelta('1 minute')
    first_7d = df[df['AKI_reached_7d']==1].groupby('patientunitstayid')['labresultoffset'].first()
    first_7d = first_7d/pd.Timedelta('1 minute')
    first_occur_comb = pd.concat([first_2d, first_7d], axis=1, ignore_index=False)
    first_occur_comb.fillna(0, inplace=True)
    first_occur_comb.columns = ['2d_first', '7d_first']

    # identify the lesser non-zero time offset
    earlier_time_list = []
    for index, row in first_occur_comb.iterrows():
        earlier_time = min(row)
        if earlier_time==0:
            row_list = row.values.tolist()
            row_list.remove(earlier_time)
            earlier_time_list.append(row_list[0])
        else:
            earlier_time_list.append(earlier_time)
    print(earliest onset found)

    earlier_time_df = pd.DataFrame({'patientunitstayid':first_occur_comb.index, 'earlier_time': earlier_time_list})
    earlier_time_df.set_index('patientunitstayid', inplace=True)
    first_occur_comb = pd.concat([first_occur_comb, earlier_time_df], axis=1, ignore_index=False)

    return df, first_occur_comb