# HA 6.2

# Packages:
library(forecast)
library(fma)
library(tidyverse)
library(seasonal)

####### Q&A #######

# The plastics data set consists of the monthly sales (in thousands) of product A 
# for a plastics manufacturer for five years.

help(plastics, package = fma)

# a) Plot the time series of sales of product A. 
# Can you identify seasonal fluctuations and/or a trend-cycle?

autoplot(plastics)

# A: Yes there are clear seasonal variations with regular intervals on an annual cycle. 
# There is also a clear upward trend from cycle start to cycle end. 

# b) Use a classical multiplicative decomposition to calculate the trend-cycle and 
# seasonal indices.

plastics %>%
  decompose(type='multiplicative') %>%
  autoplot()

# c) Do the results support the graphical interpretation from part a?

seasonplot(plastics, 
           ylab="Sales (Thousands)", 
           xlab="Month", 
           year.labels.left=TRUE, 
           main="Plastics Seasonal Plot", 
           col = 1:5)


# A: Yes, our statement is confirmed. There is a clear positive trend upward in sales 
# with clear seasonal variation over time. The only unknown is the remainder, or  which we did not 
# describe previously but also seems to follow seasonal variations, albeit loosely. 

# d) Compute and plot the seasonally adjusted data.

seasons <- plastics %>%
  decompose(type='multiplicative')
autoplot(plastics, series='Data') +
  autolayer(seasadj(seasons), series='Seasonally Adjusted')


# e) Change one observation to be an outlier (e.g., add 500 to one observation), and 
# recompute the seasonally adjusted data. What is the effect of the outlier?

# A: We could sample and add it at random 

df <- plastics
set.seed(42)
index <- sample(1:length(plastics), 1)
n <- df[index]
data.frame(index, n, outlier=n+500)

# A: Alternatively we could index it

plastics[42] <- plastics[42] + 500
dec2 <- plastics %>%
  decompose(type='multiplicative')
autoplot(dec2, series='Data') +
  autolayer(seasadj(dec2), series='Adj. Outlier')


# f) Does it make any difference if the outlier is near the end rather than in the 
# middle of the time series?


# A: Add an outlier to the beginning of the series

plastics[2] <- plastics[2] + 500
dec3 <- plastics %>%
  decompose(type='multiplicative')
autoplot(dec3, series='Data') +
  autolayer(seasadj(dec3), series='Adj. Outlier 2')

# A: Add an outlier near the end of the series

plastics[58] <- plastics[58] + 500
dec4 <- plastics %>%
  decompose(type='multiplicative')
autoplot(plastics, series='Data') +
  autolayer(seasadj(dec4), series='Adj. Outlier 2')

# A: Outliers near the beginning and end of the series appear to have a greater 
# influence on the overall trend and seasonality of the data. However, it is also clear 
# that this data is sensitive to extreme values. Any outlier appears to skew the trend far
# from its expectation and nearby data points. 

