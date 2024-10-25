import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

# 1
df = pd.read_csv("medical_examination.csv")

# 2
df['overweight'] = (df['weight'] / (df['height']/100) ** 2) >= 25


# 3
df['cholesterol'] = np.where(df['cholesterol'] == 1, 0, 1)
df['gluc'] = np.where(df['gluc'] == 1, 0, 1)


# 4
def draw_cat_plot():
    # 5
    value_vars = ['cholesterol', 'gluc', 'smoke', 'alco', 'active', 'overweight']
    df_cat = pd.melt(df, id_vars=df.loc[:, ~df.columns.isin(value_vars + ['id'])], value_vars=value_vars, var_name="variable", value_name="value")

    df_cat.rename(columns={'sex': 'gender'}, inplace=True)

    # 6
    df_cat = df_cat.groupby(['cardio', 'variable', 'value']).size().reset_index(name='total')
    # print(df_cat)

    # 7
    # df_cat = pd.melt(df_cat, id_vars=['cardio', 'Count'], var_name="Feature", value_name="value")
    # print(df_cat)

    plot = sns.catplot(df_cat, x='variable', y='total', kind="bar", col="cardio", hue='value')


    # 8
    fig = plot.figure


    # 9
    fig.savefig('catplot.png')
    return fig


# 10
def draw_heat_map():
    # 11
    df_heat = df[(df['ap_lo'] <= df['ap_hi']) & (df['height'] <= df['height'].quantile(0.975)) & (df['height'] >= df['height'].quantile(0.025)) & (df['weight'] <= df['weight'].quantile(0.975)) & (df['weight'] >= df['weight'].quantile(0.025))]
    # print(df_heat.head())

    # 12
    corr = df_heat.corr().round(1)

    # 13
    mask = np.triu(np.ones_like(corr, dtype=bool))


    # 14
    fig, ax = plt.subplots(figsize=(12,10))

    # 15
    sns.heatmap(corr, mask=mask, ax=ax, annot=True, fmt=".1f", linewidths=0.5)


    # 16
    fig.savefig('heatmap.png')
    return fig


# draw_heat_map()