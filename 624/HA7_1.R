# HA 7.1

# Packages:
library(forecast)
library(fma)
library(fpp2)

####### Q&A #######

# Consider the pigs series - the number of pigs slaughtered in Victoria each month. 

# a) Use the ses() function in R to find the optimal values of  ?? and  ???0 , and generate 
# forecasts for the next four months.

a <- ses(pigs, h = 4)
a$model
plot(a)

# b) Compute a 95% prediction interval for the first forecast using  ^y±1.96s where s is 
# the standard deviation of the residuals. Compare your interval with the interval 
# produced by R.

# A: From formula
s <- sd(residuals(a))
ci <- c(L = a$mean[1] - 1.96*s, U = a$mean[1] + 1.96*s)
ci

# A: Using R
rci <- c(a$lower[1,2], a$upper[1,2])
rci

# A: As a table with difference computed
tbl <- data.frame(ci, rci)
tbl[3,] <- colSums(tbl)
tbl[3] <- tbl[1] - tbl[2]
rownames(tbl) <- c("Lower", "Upper", "Total")
colnames(tbl) <- c("Formula", "R", "Difference")
tbl

