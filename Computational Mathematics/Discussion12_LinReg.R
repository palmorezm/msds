# 04/05/2021
# Discussion 12 Analysis

# Prompt
# Using R, build a  regression model for data that interests you. 
# Conduct residual analysis.  Was the linear model appropriate? Why or why not?


# Packages
library(ggplot2) 

# Baseball Data
hit_data <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/605/baseball_battingdata.csv")
hit_data <- data.frame(hit_data)
head(hit_data)



plot(hit_data$ï..ExitVelocity.MPH., hit_data$HR)

linear_model_EVtoHR <- lm(hit_data$ï..ExitVelocity.MPH. ~ hit_data$HR)

par(mfrow = c(2,2), col.axis = "white", col.lab = "white", tck = 0)
plot(linear_model_EVtoHR)

