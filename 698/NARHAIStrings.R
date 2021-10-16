
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

# Import the files
txtfile <- 'https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/NARHAI2011_2014.txt'
str <- read.delim(file = txtfile)
every.character <- data.frame(str_extract_all(str, pattern = ".")) # Visualize raw string for patterns

# Get stringy
str <- str_remove_all(str, pattern = "##### (.*?) #####") # Remove junk inbetweens
GeoFips <- str_extract_all(str, pattern = "\\d{5}") # GeoFips location (*unique*) ID
str_extract_all(str, pattern = "\\d{5} \\w*, \\w* ")



str_extract_all(str, pattern = "\\d{5}.*?\\d")
str_match_all(str, pattern = "\\d{5}(.*?)\\d")



str_extract_all(str, pattern = "\\d{5}(.*?)\\.")
str_match_all(str, pattern = "\\d{5}(.*?)\\d")
str_extract_all(str, pattern = "\\d{5} (.*?) \\w* ")
str_extract_all(str, pattern = "")

str_match_all(str, pattern = "(.*?) \\w{2} ")

str_match_all(str, pattern = "(.*?), \\w{2}")


metro_name <- str_extract_all(str, pattern = "\\d{5} (.*?), \\w{2}") # work the metro
metro_name <- str_remove_all(metro_name, pattern = "\\d{5} ") # GeoFips got to go bye

str_extract(str, " \\d{1,3}\\.\\d ")

nums <- str_match_all(str, "\\d{1,4}\\.\\d{1}")


str_extract(nums, "\\d{1,4}\\.\\d")

str_extract_all(nums, "^\\d{1,4}\\.\\d")

num <- str_extract_all(str, "\\d{1,3}\\.\\d{1}")

str_match_all(num, "\\d{1,3}\\.\\d{1}")

quan


data.frame(metro_name)
View(metro_name)




str_extract_all(str, pattern = "^#(.*?)#\t")
str_extract_all(str, pattern = "#(.*?)#")


str <- str_remove_all(str, pattern = "##### (.*?) #####")
GeoFips <- str_extract_all(str, pattern = "\\d{5}")





