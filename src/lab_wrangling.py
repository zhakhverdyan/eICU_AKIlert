import pandas as pd

def calc_stats_windows(df, columns, funcs, timecolumn):
    df[timecolumn] = pd.to_timedelta(df[timecolumn], unit='minute')
    df.set_index(timecolumn, inplace=True)
    sum_df = df.groupby('patientunitstayid')[columns].apply(lambda x: x.rolling('2d', min_periods=2).agg(funcs)) 
    sum_df.columns = sum_df.columns.map('_'.join)
    columns = sum_df.columns.tolist()
    columns.append('patientunitstayid')
    sum_df = pd.concat([sum_df, df['patientunitstayid']], axis=1, ignore_index=True)
    sum_df.columns = columns
    sum_df.reset_index(inplace=True)
    sum_df.set_index(['patientunitstayid', timecolumn], inplace=True)
    df.reset_index(inplace=True)
    df.set_index(['patientunitstayid', timecolumn], inplace=True)
    df = pd.concat([df, sum_df], axis=1, ignore_index=False)
    return df
