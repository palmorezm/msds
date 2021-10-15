
# MS Analytics Capstone
# Extracting Information from Strings
# Dataset: Affordability Index of Existing Single-Family Homes for Metropolitan Areas
# Sources: Nationa Association of Realtors
#   2017 - 2020:
# https://cdn.nar.realtor/sites/default/files/documents/metro-affordability-2020-existing-single-family-2021-10-05.pdf
#   2011 - 2014:
# https://www.nar.realtor/sites/default/files/reports/2015/embargoes/2014-metro-affordability/metro-affordability-2014-existing-single-family-2015-02-11.pdf

# Packages
library(stringr)
library(dplyr)

fileName <- 'https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/NARHAI2011_2014.txt'


str <- read.delim(file = fileName)
str_extract_all(str, pattern = "\\d{2}")
str_extract(str, pattern = "\\d{")

