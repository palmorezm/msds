
# MS Analytics Knowledge and Visual Analytics
# Estimating Proportions of Income and Housing
# Dataset: National Median Home Values and Median Income
# Sources: U.S.Census (ACS) and BEA
# data.census.gov, https://apps.bea.gov/iTable/

# The values
income2021 <- 79900
income1960 <- 5600
val2021 <- 269039
val1960 <- 11900

# Proportion of income spent on housing 
(val1960/income1960)*100 # 1960 
(val2021/income2021)*100 # 2021
abs(((val1960/income1960)*100) - ((val2021/income2021)*100)) # Change from 1960 to 2021

# Conclusion 
# We spend more of our money on housing today than we did in 1960. Specifically, 124.22% more today than in 1960.

# Dollar Change from 1960  
income2021 - income1960 # Gained $74,300 on average (median) in income
val2021 - val1960 # Increased $257,139 on average in home value/price

# Ratio of change 
(income2021/income1960) # Income increased 14.268 times that of 1960 
(val2021/val1960) # Value increased 22.608 times that of 1960

# Conclusion
# We would need to adjust the dollar amount to adjusted for inflation purposes

# New Values 
# According to https://www.usinflationcalculator.com/
# Exactly $1.00 in 1960 is worth $9.27 today (2021)
# 826.7% = Cumulative Rate of Inflation 1960 to 2021
irate <- 8.267
adjval1960 <- irate*val1960
adjincome1960 <- irate*income1960
# Importantly, 2021 does not need to be adjusted - it is the value we experience today

# Proportion of income spent on housing 
(adjval1960/adjincome1960)*100 # 1960 
(val2021/income2021)*100 # 2021
abs(((adjval1960/adjincome1960)*100) - ((val2021/income2021)*100)) # Change from 1960 to 2021

# Conclusion 
# Adjusting for inflation the proportion of income spent on housing has 
# increased by 124.2196% since 1960

# Real Dollar Change from 1960  
income2021 - adjincome1960 # Gained $33604.7 on average (median) in income
val2021 - adjval1960 # Increased $170,661 on average in home value/price

# Ratio of change 
(income2021/adjincome1960) # Income increased 1.723 times that of 1960 
(val2021/adjval1960) # Value increased 2.735 times that of 1960
((income2021/adjincome1960) / (val2021/adjval1960)*100) # Ratio of change 
((income2021 - adjincome1960) / (income2021)*100) # 42.059% increase in income 
((val2021 - adjval1960) / (val2021)*100) # 63.434% increase in price 



# Conclusion
# The gap in ratio of median home prices to median income widened 
# by about 63.109% from 1960 to 2021 after adjusting for inflation




