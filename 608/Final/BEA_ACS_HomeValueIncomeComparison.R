
# MS Analytics Knowledge and Visual Analytics
# Estimating Proportions of Income and Housing
# Dataset: National Median Home Values and Median Income
# Sources: U.S.Census (ACS) and BEA
# data.census.gov, https://apps.bea.gov/iTable/

# The values
income2021 <- 79900
income1960 <- 5600
val2021 <- 269039
val1960 <- 17000

# Proportion of income spent on housing 
(val1960/income1960)*100 # 1960 
(val2021/income2021)*100 # 2021
abs(((val1960/income1960)*100) - ((val2021/income2021)*100)) # Change from 1960 to 2021

# Conclusion 
# We spend more of our money on housing today than we did in 1960. Specifcally, 33.148% more today than in 1960.

# Plain Dollar Change from 1960  
income2021 - income1960 # Gained $74,300 on average (median) in income
val2021 - val1960 # Increased $252,039 on average in home value/price

# Ratio of change 
(income2021/income1960) # Income increased 14.268 times that of 1960 
(val2021/val1960) # Value increased 15.826 times that of 1960

# Conclusion
# We would need to adjust the dollar amount to adjusted for inflation purposes


