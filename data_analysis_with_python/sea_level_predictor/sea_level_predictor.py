import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import linregress
import numpy as np

def draw_plot():
    # Read data from file
    df = pd.read_csv("epa-sea-level.csv")

    # Create scatter plot
    plt.scatter(x=df['Year'], y=df['CSIRO Adjusted Sea Level'])
    years = np.arange(1850., 2076., 25.)
    plt.xticks(years)

    # Create first line of best fit
    lr = linregress(x=df['Year'], y=df['CSIRO Adjusted Sea Level'])

    x_values = pd.Series(range(int(df['Year'].min()), 2051))
    y_values = lr.slope * x_values + lr.intercept

    plt.plot(x_values, y_values, color='red')


    # Create second line of best fit
    df = df[df['Year'] >= 2000]
    lr = linregress(x=df['Year'], y=df['CSIRO Adjusted Sea Level'])
    
    x_values = pd.Series(range(2000, 2051))
    y_values = lr.slope * x_values + lr.intercept

    plt.plot(x_values, y_values, color='blue')
    


    # Add labels and title
    plt.xlabel('Year')
    plt.ylabel('Sea Level (inches)')
    plt.title('Rise in Sea Level')

    
    # Save plot and return data for testing (DO NOT MODIFY)
    plt.savefig('sea_level_plot.png')
    return plt.gca()