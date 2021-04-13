---
title: "Mutliple Regression Model"
author: "Zachary Palmore"
date: "4/12/2021"
output: pdf_document
---



## Prompt
	
Using R, build a multiple regression model for data that interests you.  Include in this model at least one quadratic term, one dichotomous term, and one dichotomous vs. quantitative interaction term.  Interpret all coefficients. Conduct residual analysis.  Was the linear model appropriate? Why or why not?

## Data

Before I begin, it might be useful to define the kind of variables required. This way we can evaluate whether the data fits the definitions as I understand them and attempt to conduct an analysis based on the same understanding of the requirements. Those terms given in the prompt are defined as follows;


      * quadratic term - a varaible that appears in the form ax^2
      
      * dichotomous term - relating to a variable that contains only two parts 
      
      * dichotomous vs. quantitative interaction term - an interaction between a variable that splits into two parts and one that is discrete or continuous but numeric by nature 
      


```r
# Packages
library(tidyverse)
```

```
## -- Attaching packages ----------------------------------------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.2     v purrr   0.3.4
## v tibble  3.0.3     v dplyr   1.0.2
## v tidyr   1.1.1     v stringr 1.4.0
## v readr   1.3.1     v forcats 0.5.0
```

```
## -- Conflicts -------------------------------------------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(ggpubr)
library(kableExtra)
```

```
## 
## Attaching package: 'kableExtra'
```

```
## The following object is masked from 'package:dplyr':
## 
##     group_rows
```

```r
library(reshape2)
```

```
## 
## Attaching package: 'reshape2'
```

```
## The following object is masked from 'package:tidyr':
## 
##     smiths
```

```r
library(corrplot)
```

```
## corrplot 0.84 loaded
```

```r
library(ggstatsplot)
```

```
## Registered S3 methods overwritten by 'lme4':
##   method                          from
##   cooks.distance.influence.merMod car 
##   influence.merMod                car 
##   dfbeta.influence.merMod         car 
##   dfbetas.influence.merMod        car
```

```
## In case you would like cite this package, cite it as:
##      Patil, I. (2018). ggstatsplot: "ggplot2" Based Plots with Statistical Details. CRAN.
##      Retrieved from https://cran.r-project.org/web/packages/ggstatsplot/index.html
```

```r
library(MASS)
```

```
## 
## Attaching package: 'MASS'
```

```
## The following object is masked from 'package:dplyr':
## 
##     select
```

```r
library(bestNormalize)
```

```
## 
## Attaching package: 'bestNormalize'
```

```
## The following object is masked from 'package:MASS':
## 
##     boxcox
```

```r
library(Metrics)
library(VGAM)
```

```
## Loading required package: stats4
```

```
## Loading required package: splines
```

```
## 
## Attaching package: 'VGAM'
```

```
## The following object is masked from 'package:tidyr':
## 
##     fill
```

```r
theme_set(theme_minimal())
```



```r
tdata <- read.csv(
"https://raw.githubusercontent.com/palmorezm/msds/main/621/HW1/moneyball-training-data.csv")
# Basic statistics from the set 
total.obs <- count(tdata)
avg.wins <- mean(tdata$TARGET_WINS) 
max.wins <- max(tdata$TARGET_WINS)
sd.wins <- sd(tdata$TARGET_WINS)
colnames <- colnames(tdata)
missing.values <- (sum(is.na(tdata)))
```


## Analysis

One interest of mine is baseball. Thankfully, there is plenty of data on this topic which is why I have decided to use this sports data for analysis. Our end goal it to predict. 



