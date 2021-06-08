# HA 3.1

# Packages:
library(forecast)
library(dplyr)
library(fma)
library(fpp2)

####### Q&A #######

# Write your own function to implement simple exponential smoothing. 
# The function should take arguments y (the time series), alpha (the 
# smoothing parameter ??) and level (the initial level ???0). It should 
# return the forecast of the next observation in the series. 

# Does it give the same forecast as ses()?

# A: Reminder of ses model
mod.a <- ses(pigs, h = 4)
mod.a$model
autoplot(mod.a)

# A: Our simple exponential smoothing (ses) function 
simples <- function(y, a, n){
  f <- n
    for(index in 1:length(y)){
     f <- a*y[index] + (1 - a)*f }
  print(paste("Our forecast is", as.character(round(f, 2) )))
}


# A: Results of our ses function
a <- mod.a$model$par[[1]]
n <- mod.a$model$par[[2]]
simples(pigs, a, n)

# A: Results of R function
mod.a$mean[[1]]

# A: Both results are the same when rounded to the hundredths place. 
