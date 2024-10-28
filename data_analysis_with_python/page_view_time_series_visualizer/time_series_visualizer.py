import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import matplotlib as mpl


# Import data (Make sure to parse dates. Consider setting index column to 'date'.)
df = pd.read_csv("fcc-forum-pageviews.csv", index_col="date", parse_dates=True)

df.sort_index(inplace=True)


# Clean data
df = df[(df['value'] <= df['value'].quantile(0.975)) & (df['value'] >= df['value'].quantile(0.025))]
df.rename(columns={'value': 'Page Views'}, inplace=True)

def draw_line_plot():
    # Draw line plot
    fig, ax = plt.subplots(figsize=(12,10))

    sns.lineplot(data=df, ax=ax, legend=None, palette=['r'])

    ax.set_title("Daily freeCodeCamp Forum Page Views 5/2016-12/2019")
    ax.set_xlabel("Date")
    ax.set_ylabel("Page Views")

    # Save image and return fig (don't change this part)
    fig.savefig('line_plot.png')
    return fig


def draw_bar_plot():
    # Copy and modify data for monthly bar plot
    df_bar = df.copy()
    df_bar['year'] = df_bar.index.year
    df_bar['month'] = df_bar.index.month_name()


    df_bar = pd.DataFrame(df_bar.groupby(["year", "month"], sort=False)["Page Views"].mean().round().astype(int)).reset_index()

    # Draw bar plot
    fig, ax = plt.subplots(figsize=(19.2, 10.8), dpi=100)

    plot = sns.barplot(df_bar, x='year', ax=ax, y='Page Views', hue='month', hue_order=['January', 'February', 'March', 'April' , 'May' , 'June', 'July', 'August', 'September', 'October', 'November', 'December'], width=0.5, palette="tab10")

    plot.legend(title='Months')

    plot.set_xlabel("Years")
    plot.set_ylabel("Average Page Views")

    fig = plot.figure
    

    # Save image and return fig (don't change this part)
    fig.savefig('bar_plot.png')
    return fig


def draw_box_plot():
    # Prepare data for box plots (this part is done!)
    df_box = df.copy()
    df_box.reset_index(inplace=True)
    df_box['year'] = [d.year for d in df_box.date]
    df_box['month'] = [d.strftime('%b') for d in df_box.date]

    month_order = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    df_box['month'] = pd.Categorical(df_box['month'], categories=month_order, ordered=True)

    # Draw box plots (using Seaborn)
    fig, ax = plt.subplots(ncols=2, figsize=(12,10), dpi=100)

    sns.boxplot(df_box, x='year', ax=ax[0], y='Page Views', hue='year', flierprops={"marker": "D", "markersize": 1})
    sns.boxplot(df_box, x='month', ax=ax[1], y='Page Views', hue='month', flierprops={"marker": "D", "markersize": 1})

    # ax[0].set_ylim(0, 200000)
    # ax[1].set_ylim(0, 200000)
    ax[0].set_xlabel("Year")
    ax[1].set_xlabel("Month")

    ax[0].set_title("Year-wise Box Plot (Trend)")  # Title for the first subplot
    ax[1].set_title("Month-wise Box Plot (Seasonality)")


    # Save image and return fig (don't change this part)
    fig.savefig('box_plot.png')
    return fig