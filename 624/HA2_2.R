# HA 2.2

# Packages:
library(forecast)


####### Q&A #######


# Download the file tute1.csv from the book website, open it in Excel 
# (or some other spreadsheet application), and review its contents. 
# You should find four columns of information. Columns B through D each 
# contain a quarterly series, labelled Sales, AdBudget and GDP. Sales 
# contains the quarterly sales for a small company over the period 1981-2005. 
# AdBudget is the advertising budget and GDP is the gross domestic product.
# All series have been adjusted for inflation.


# a) You can read the data into R with the following script:

tute1 <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/624/tute1.csv")

# b) Convert the data to time series

mytimeseries <- ts(tute1[,-1], start=1981, frequency=4)

# c) Construct time series plots of each of the three series. 
# Check what happens when you don't include facets=TRUE.

# With facets=TRUE.
autoplot(mytimeseries, facets=TRUE)

# With facets=FALSE.
autoplot(mytimeseries, facets=FALSE)

# Each series is plotted on the same plot with the same axes when facets=FALSE. 
# Otherwise, facets=TRUE displays each series as its own plot with its own axis.



