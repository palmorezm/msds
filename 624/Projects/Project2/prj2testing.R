library(utils)
library(psych)
library(kableExtra)
library(tidyverse)

ph <- read.csv(
  "https://raw.githubusercontent.com/palmorezm/msds/main/624/Projects/Project2/StudentData%20-%20TO%20MODEL.csv")
describe(ph)
