
# Prediction script
library(utils)
library(psych)
library(stats)
library(pls)
library(tidyverse)
library(corrplot)
library(elasticnet)
library(kernlab)
library(plotrix)
library(ggcorrplot)
library(ggpubr)
library(ROCR)
library(party)
library(MASS)
library(mice)
library(mboost)
library(VIM)
library(rpart)
library(caret)
library(zoo)
library(rpart)
library(rpart.plot)
library(naniar)
library(partykit)
library(flextable)
library(bestNormalize)
library(doParallel) # Used for computation
library(earth) # Package necessary for marsModel
registerDoParallel(cores=2)
theme_set(theme_minimal())
set.seed(004)
ph <- read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/624/Projects/Project2/StudentEvaluation-%20TO%20PREDICT.csv")
#################################
# Data Preparation
# Check for missing data patterns with mice
na.pattern.mice <- md.pattern(ph) # No clear pattern
# Double check with hist and plot 
aggr(ph, col=c('navyblue','red'), 
     numbers=TRUE, sortVars=TRUE, 
     labels=names(ph), cex.axis=.7, 
     gap=3, ylab=c("Histogram","Pattern")) 
ph.desc <- ph %>% 
  describe() %>%
  mutate("pm" = round(((2571 - n)/2571)*100, 2), 
         obs = n, 
         med = median) %>% 
  round(digits = 1) %>% 
  mutate(var = colnames(ph)) %>%
  dplyr::select(var, obs, pm, mean, med,
                sd, min, max, skew, se)
# Small amount missing - simple median will do
obs.missing.perc <- 
  (sum(ph.desc$obs) / (33*2571)*100)
obs.missing.perc
# select numeric variables
ph.numerics <- ph %>% 
  data.frame() 
  dplyr::select(where(is.numeric))
# replaces NA with median (given a removal of missing values in calculation)
for (i in colnames(ph.numerics)) {
  ph.numerics[[i]][is.na(ph.numerics[[i]])] <- 
    median(ph.numerics[[i]], 
                                    na.rm=TRUE)
}
# Confirm none are missing
sum(is.na(ph.numerics))
naniar::impute_median(ph.numerics)
# remove outliers based on IQR
for (i in colnames(ph.numerics)) {
  iqr <- IQR(ph.numerics[[i]])
  q <- quantile(ph.numerics[[i]], probs = c(0.25, 0.75), na.rm = FALSE)
  qupper <- q[2]+1.5*iqr
  qlower <- q[1]+1.5*iqr
  outlier_free <- subset(ph.numerics, ph.numerics[[i]] > (q[1] - 1.5*iqr) & ph.numerics[[i]] < (q[2]+1.5*iqr) )
}
ph.numerics <- outlier_free
# join outlier free numerics with categorical 
Brand.Code <- ph$ï..Brand.Code
df <- cbind(Brand.Code, ph.numerics)
df.summary <- summary(df)
# Produce recommended transformations
df.nums <- df %>% 
  dplyr::select(where(is.numeric))
best.norms <- df.nums[1:11,1:10]
for (i in colnames(df.nums)) {
  best.norms[[i]] <- bestNormalize(df.nums[[i]],
                                   allow_orderNorm = FALSE,
                                   out_of_sample =FALSE)
}
best.norms$Carb.Volume$chosen_transform
#################################
# Model Building
# Random Forest Model
ctl <- trainControl(method='repeatedcv', 
                    number=10, 
                    repeats=3)
mtry <- sqrt(ncol(train))
tunegrid <- expand.grid(.mtry=mtry)
model.rf <- train(PH~., 
                  data=train, 
                  method='rf',
                  tuneGrid=tunegrid, 
                  preProcess = c("center", "scale"),
                  trControl=ctl)
rfPred <- predict(model.rf, newdata = test)
rf_test <- data.frame(
  postResample(pred = rfPred, obs = test$PH)) 
model.rf
caret::varImp(model.rf)
#################################
# Predictions
prj2_realworld_predictions <- predict(model.rf, 
                            newdata = df)
write.csv(prj2_predictions, 
          file = "C:/data/prj2_realworld_predictions.csv")



