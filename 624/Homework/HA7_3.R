# HA 7.2

# Packages:
library(forecast)
library(fma)
library(fpp2)

####### Q&A #######

# Modify your function from the previous exercise to return the sum of 
# squared errors rather than the forecast of the next observation. Then 
# use the optim() function to find the optimal values of  ?? and ???0. 
# Do you get the same values as the ses() function?

# A: Reminder of our simple exponential smoothing (ses) function 
simples <- function(y, a, n){
  f <- n
  for(index in 1:length(y)){
    f <- a*y[index] + (1 - a)*f }
  print(paste("Our forecast is", as.character(round(f, 2) )))
}

# A: Reminder of R's ses function
mod.a <- ses(pigs, h = 4)

# A: Our function with SSE modifications
simpleSSE <- function(pars = c(alpha, l0), y){
  error <- 0
  SSE <- 0
  a <- pars[1]
  l0 <- pars[2]
  avg <- l0
    for(index in 1:length(y))
      {
        error <- y[index] - avg
        SSE <- SSE + error^2
        avg <- a*y[index] + (1 - a)*avg
  }
  return(round(SSE, 2))
}
 
# A: Compute optimums and compare results
optimums <- optim(par = c(0.5, pigs[1]), y = pigs, fn = simpleSSE)
SSE.tbl <- data.frame(matrix(c(round(optimums$par[1],2), round(optimums$par[2],2), 
         round(mod.a$model$par[1],2), round(mod.a$model$par[2], 2)), 
         nrow = 2, ncol = 2))
colnames(df) <- c("Test", "R")
SSE.tbl

