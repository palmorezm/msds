# HA 6.2

# Packages:
library(forecast)
library(fma)
# library(seasonal)
# library(fpp2)

####### Q&A #######

# The plastics data set consists of the monthly sales (in thousands) of product A 
# for a plastics manufacturer for five years.

help(plastics, package = fma)

# a) Plot the time series of sales of product A. 
# Can you identify seasonal fluctuations and/or a trend-cycle?

autoplot(plastics)

# Yes there are clear seasonal variations with regular intervals. 

# b) Use a classical multiplicative decomposition to calculate the trend-cycle and 
# seasonal indices.
# c) Do the results support the graphical interpretation from part a?
# d) Compute and plot the seasonally adjusted data.
# e) Change one observation to be an outlier (e.g., add 500 to one observation), and 
# recompute the seasonally adjusted data. What is the effect of the outlier?
# f) Does it make any difference if the outlier is near the end rather than in the 
# middle of the time series?



