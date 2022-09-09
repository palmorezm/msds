
# Homework Help


setwd("C:/Users/Zachary Palmore/GitHub/msds/Business Analytics and Data Mining/Misc")

library(dplyr)
library(lubridate)

CGM <- read.csv("CGMData.csv")
Insulin <- read.csv("InsulinData.csv")

Meals <- Insulin %>% # Find Meals
  dplyr::select(Date, Time, BWZ.Carb.Input..grams.) %>% # Select only useful columns  
  rename(BWZ = BWZ.Carb.Input..grams.) %>% # rename for ease of typing
  dplyr::filter(BWZ >0) # Meals = BWZ > 0 
# Create datetime object via lubridate
Meals$datetime <- lubridate::mdy_hms(paste(Meals$Date, Meals$Time))

Meals <- Meals %>% 
  mutate(MealStart = datetime - minutes(30), # Set start time to 30 prior to original time
         MealEnd = datetime + hours(2), # Set end time to 2 hours after original time
         MealDuration = MealEnd - MealStart) # Check duration matches 2.5 hours for every meal

int1 <- lubridate::interval(Meals$MealStart, Meals$MealEnd) # Set interval for meal times
int1 %>% View()

CGM <- CGM %>% 
  dplyr::select(Date, Time, Sensor.Glucose..mg.dL.) %>% 
  rename(Glucose = Sensor.Glucose..mg.dL.) %>% 
  mutate(datetime = mdy_hms(paste(Date, Time))) # Create datetime object in same process as above



int2 <- lubridate::interval(start = min(CGM$datetime), end = max(CGM$datetime))

# Find all places in CGM where no meals occur
as.duration(setdiff(int1, int2))
setdiff(int1, int2)

setdiff(int2, int1)

Meals$MealEnd

# Find the time between each Meal End and Meal Start in CGM 

min(Meals$MealStart) 
max(Meals$MealEnd)

min(CGM$datetime)
max(CGM$datetime)

Meals$MealEnd[[1]] - Meals$MealStart[[2]]

# Alternative
# 1. Find where meals occur (BWZ >0)
# 2. Subtract 30 minutes from those times to create Meal Start times
# 3. Add 2 hours to the original times where meals occur to create Meal End time
# 4. Label those times with Status = "Meal"  
# 5. 

Meals <- Meals %>% 
  mutate(MealStart = datetime - minutes(30), # Set start time to 30 prior to original time
         MealEnd = datetime + hours(2), # Set end time to 2 hours after original time
         MealDuration = MealEnd - MealStart, 
         Status = "Meal") # Check duration matches 2.5 hours for every meal

CGM %>% 
  left_join(Meals, by = "datetime") %>% View()


CGM_Labeled <- CGM %>% 
  dplyr::filter(datetime > Meals$MealEnd | datetime < Meals$MealStart) %>% 
  mutate(Status = "Not a Meal")

Meals %>% 
  mutate(Status = "Meal") %>% 
  left_join(CGM_Labeled, by = "datetime") %>% View()

Meals %>% 
  left_join(CGM, by = "datetime") 


CGM %>% 
  dplyr::filter(datetime > Meals$MealStart[[1]] & datetime < Meals$MealEnd[[1]]) %>% View()

