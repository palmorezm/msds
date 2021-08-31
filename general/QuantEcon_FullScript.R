# Quantative Economics with R 
# A Data Science Approach

# Segment 1 
# Default R Setup
# -------------------------
# Script     | Environment
# (commands) | (objects)
# -------------------------
# Console    | Files, Help,
# (output)   | Plots & Packages

1 + 1 
# Best to write the script like this
x <- 1 
y <- 1 
x + y 
# Where x and y are objects that each hold the numeric value of 1
# These can be shown in the environment when run
# When the value needs to be changed, simply change the value of the object

# Segment 2 
# Vectors and Dataframes
Price <- c(10, 3, 15)

# R is case sensitive
price != Price 
# Be sure to reference the correct object

# square brackets are for subsetting
# assigning vectors with brackets produces this error 
Price <- c[10, 3, 15]
# Error in c[10, 3, 15] : object of type 'builtin' is not subsettable
# Be sure to concatenate with paratheses

# vector lengths
length(Price)

# extract an element
Price[1] # extracts the first element 
# Index starts at 1

# extract elements
Price[2:3] # extracts the 2 and third elements

# Quantity Vector
Quantity <- c(25, 3, 20)

# print vector
Quantity # run as is, will show the value(s) present in vector object

# compute expediture
Expenditure <- Price * Quantity
Expenditure

# calculate total expenditure
Total_expenditure <- sum(Expenditure)
Total_expenditure



## Data frames
# used to hold data in R
# contains observations in rows and variables in columns

# make a data frame 
Exp_data <- data.frame(Price, Quantity)

# Extract second variable
Exp_data[2] # Displays all row values (observations) and header in second column
Exp_data[,2] # Displays all row values (observations) in data frame of second column
Exp_data[2,] # Displays the second row of the data framewith headers
Exp_data[2,2] # Displays the second observation of the second column 

# extract quantity variable
Exp_data$Quantity # shows all observations of Quantity column (variable) in data frame

# display entire data frame 
Exp_data

# Segment 3 
# Wrangling data
# Working with data before it can be analyzed effectively 

# tidyverse package
# Install the package before trying to load with the library() function
# This can be done with 
# install.packages("tidyverse")
# then we load it for use in this R session with library() 
library(tidyverse)


