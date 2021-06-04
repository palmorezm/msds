# HA 2.3

# Packages:
library(forecast)
library(readxl)


####### Q&A #######

# Download some monthly Australian retail data from the book website. 
# These represent retail sales in various categories for different 
# Australian states, and are stored in a MS-Excel file. 

# a) You can read the data into R with the following script:

retail <- readxl::read_excel("Data/retail.xlsx", skip = 1)

# b) Select one of the time series as follows (but replace the column
# name with your own chosen column):


myts <- ts(retail[,"A3349349F"],
           frequency=12, start=c(1982,4))

# c) Explore your chosen retail time series using the following functions:
# autoplot(), ggseasonplot(), ggsubseriesplot(), gglagplot(), ggAcf()
# Can you spot any seasonality, cyclicity and trend? What do you learn about the series?



autoplot(myts)

# A: From the autplot() function we found that retail sales in this category have increased since 1982 
# along with the variability in the number of sales. After approximately 2004, the amount 
# of monthly variation in sales of this category increase to levels more than double the
# level of variation at 1982. 

ggseasonplot(myts)

# A: Using ggseasonplot() we find that sales in this category tend to increase in the final 
# month of the year (Dec) and sales generally have slightly upward trends, indicating a 
# slight increase in sales as time goes on. Otherwise, there appears to be little to no
# seasonality in this category of sales. 

ggsubseriesplot(myts)

# A: Through a ggsubseriesplot() we review seasonality in a bit more detail. It confirm our
# notions that sales of this category increase very slightly over time with a burst of sales
# in the last month of the year. 

gglagplot(myts)

# A: This function gglagplot() can help identify hidden trends. Although a bit crowded, 
# there is consistency in the lag plots. All show positive increases confirming the 
# general increase over the series. Lags 1 and 12 appear to show the most strongly 
# positive, indicating some potential seasonality. In this case it is likely the 
# recurrence of higher sale volumes at the end of the year and a steady increase in 
# sales per month which is in-line with our other observations of this category. 

ggAcf(myts)

# A: In reviewing the linear relationship between the lagged values of this time series, 
# the general upward trend in sales over time is again confirmed due to the decrease in
# ACF plot. Additionally, it is difficult to say there is seasonality with this category 
# because if there were, the data would appear to have some scalloped edges in it ACF to 
# indicate seasonal increases and decreases in sales. This is not observed and thus, 
# we confirm there is little to no seasonality. 

# A: This category was that of pharmaceutical, cosmetics, and toiletry goods. It makes
# sense that this type of good would have a boost in sales towards the end of the year 
# due to holidays, end of year sales, discounts, and other factors such as New Year's 
# resolutions and restocking of toiletries. We believe based on our experience, these 
# trends are reasonably justified. 



