
# Final Project
# Shiny App Data Requirements

# packages
library(tidyverse)
library(ggpubr)
library(kableExtra)
theme_set(theme_minimal())


### MSA HAI Estimates ###

# Read in Data 
df <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/Research%20Project/Data/compiled.csv")
# Change Data Types to Numeric
df[4:length(df)] <- sapply(df[4:length(df)], as.numeric)
df <- df %>% 
  dplyr::select(-X)
# Calculate HAI Estimates
df.fin <- df %>% 
  mutate(IR = 0.035, 
         PMT = MEDVAL * 0.8 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINC = PMT * 4 * 12,
         HAI = (MEDINC / QINC) * 100) %>% 
  mutate(ADJALL = (MEDINC - ((RPPALL / 100)* MEDINC)),
         AINCALL = MEDINC + ADJALL, 
         # Real Wage HAI:
         HAIRW = (AINCALL / QINC)*100) %>% 
  mutate(ADJRNT = (MEDINC - ((RPPRENT / 100)* MEDINC)), 
         AINCRNT = MEDINC + ADJRNT, 
         # Rent Adjusted HAI:
         HAIRNT = (AINCRNT / QINC)*100) %>% 
  mutate(ADJIPD = (AINCRNT + AINCALL / 2)*(IPD/100),
         # IPD Projected HAI:
         HAIIPD = (ADJIPD / QINC)*100) %>% 
  mutate(PMTRAW = MEDVAL * 0.99 * (IR / 12)/(1 - (1/(1 + IR/12)^360)), 
         QINCRAW = PMTRAW * 4 * 12,
         # Raw HAI at 20% Down Payment:
         HAIRAW = (MEDINC / QINCRAW) * 100) %>% 
  mutate(HHSIZE = 2.53, 
         DEBTMV = (20000/HHSIZE),
         DEBTED = 9664*HHSIZE, 
         DEBTIL = 9609*HHSIZE,
         DEBTCC = 3500*HHSIZE, 
         DEBTOC = 10000*HHSIZE, 
         DEBTS = DEBTMV + DEBTED + DEBTIL + DEBTCC + DEBTOC, 
         AQINC30 =  PMT * (100/30) * 12,
         AINCDBT = ((AINCRNT + AINCALL / 2) - DEBTS), 
         # HAI Adjusted for Average American Household Debts
         HAIDBT = AINCDBT / AQINC30) %>% 
  mutate(PMT3DP = MEDVAL * 0.97 * (IR / 12)/(1 - (1/(1 + IR/12)^360)),
         AQINC60 = PMT * (100/60)*12,
         # Lenient Lending Practices HAI 
         #(60% of monthly income on mortgage is acceptable with 3% DP)
         HAILEN = (AINCALL / AQINC60)*100) 

### County Income & Population Data ###
counties <- rjson::fromJSON(file="https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json")
df <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/Knowledge%20and%20Visual%20Analytics/Final/Data/CAINC1_AllCounties_1969_2019.csv")
df <- df %>%
  gather(year, value, -GeoFIPS, -GeoName, -Region, 
         -TableName, -LineCode, -IndustryClassification,
         -Description, -Unit)  %>% # Keep descriptors for each County
  slice(-c(1:3)) %>% # Remove US Totals/Averages
  # filter(LineCode == 3) %>% # Subset to per capita personal income by county
  mutate(Value = as.numeric(value)) %>% # Convert all values to numeric type
  dplyr::select(-value) %>% # Remove non-numeric value column
  mutate_all(~replace(., is.na(.), 0)) %>% # Replace missing with 0
  filter(Value > 0) %>% # Remove missing
  mutate(Year = as.numeric(str_remove(year, "^X"))) %>% 
  dplyr::select(-year) %>% 
  mutate(Statistic = case_when(
    endsWith(Description, "(thousands of dollars)") ~ "Personal Income",
    endsWith(Description, "2/") ~ "Income Per Capita", 
    endsWith(Description, "1/") ~ "Population"
  ), 
  Years = as.Date(paste(Year, 1, 1, sep = "-"))) %>% 
  # filter(Year %in% c(1969, 1979, 1989, 1999, 2009, 2019)) %>% 
  dplyr::select(-Description, -TableName, -IndustryClassification) 

df <- df %>% 
  slice( -(str_which(df$GeoFIPS, pattern = "\\d{2}(000)")) ) %>% # extract counties by GeoFIPS string code
  mutate(GeoFIPs = str_remove_all(GeoFIPS, '\\\"'), 
         GeoFips = str_remove(GeoFIPs, "\\s"), # Remove quotations and whitespace from county GeoFIPS codes
  ) %>% 
  dplyr::select(-GeoFIPS, -GeoFIPs) 

df_0919 <- df %>%
  filter(Year > 2008) %>% 
  filter(LineCode == 3)

df.tbl <- df %>% 
  group_by(Statistic, Year, Years) %>% 
  summarise(min = min(Value), 
            med = median(Value), 
            max = max(Value))


# Extract HAIs < 100
ltdf <- df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, 
         -year, -MEDINC, 
         -MEDVAL, -MOE, 
         -UMEDVAL, -LMEDVAL, 
         -POP, -PERINC, -AINCALL) %>%
  filter(key == c("HAI", "HAIRW", 
                  "HAIRNT", 
                  "HAIIPD", 
                  "HAIRAW", 
                  "HAILEN", 
                  "HAIDBT")) %>% 
  subset( value < 100) 
# Extract HAIs >= 100
gtdf <- df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, 
         -year, -MEDINC, 
         -MEDVAL, -MOE, 
         -UMEDVAL, -LMEDVAL, 
         -POP, -PERINC, -AINCALL) %>%
  filter(key == c("HAI", "HAIRW", 
                  "HAIRNT", 
                  "HAIIPD", 
                  "HAIRAW", 
                  "HAILEN", 
                  "HAIDBT")) %>% 
  subset( value >= 100) 
# Summarize by group the "less affordable" population and other statistics 
lttbl <- ltdf %>%
  group_by(key, year) %>% 
  na.exclude() %>%
  summarize(Set = 'LT100', 
            N = n(), 
            MMEDHAI = median(value), 
            AAVGHAI = mean(value),
            SMEDINC = sum(MEDINC),
            SMEDVAL = sum(MEDVAL),
            SUMEDVAL = sum(UMEDVAL), 
            SLMEDVAL = sum(LMEDVAL), 
            SPERINC = sum(PERINC), 
            SREALWAGE = sum(AINCALL), 
            TPOP = sum(POP), 
            TPOPN = (TPOP/N), 
            PMEDINC = (SMEDINC/N),
            PMEDHAI = (MMEDHAI/N),
            PAVGHAI = (AAVGHAI/N) )
# Summarize by group the "more affordable" population and other statistics 
gttbl <- gtdf %>%
  group_by(key, year) %>% 
  na.exclude() %>%
  summarize(Set = 'GT100', 
            N = n(), 
            MMEDHAI = median(value), 
            AAVGHAI = mean(value),
            SMEDINC = sum(MEDINC),
            SMEDVAL = sum(MEDVAL),
            SUMEDVAL = sum(UMEDVAL), 
            SLMEDVAL = sum(LMEDVAL), 
            SPERINC = sum(PERINC), 
            SREALWAGE = sum(AINCALL), 
            TPOP = sum(POP), 
            TPOPN = (TPOP/N), 
            PMEDINC = (SMEDINC/N),
            PMEDHAI = (MMEDHAI/N),
            PAVGHAI = (AAVGHAI/N) )
# Real Income and HAI's
# create a title list for HAI
HAINAMES <- list("Normal" = "HAI", "Debt Adjusted"="HAIDBT", "Real Wage"="HAIRW", "Rent Adjustment"="HAIRNT", 
                 "Inflation Adjusted"="HAIIPD", "Raw Values"="HAIRAW", "Lenient Lending"="HAILEN")
hainames <- c("HAI" = "Normal", 
              "HAIDBT" = "Debt Adjusted", 
              "HAIRW"="Real Wage", 
              "HAIRNT"="Rent Adjusted", 
              "HAIIPD"="Inflation Adjusted", 
              "HAIRAW"="Raw Values", 
              "HAILEN"="Lenient Lending")
HAItitle <- function(variable,value){
  return(HAINAMES[value])
}

# Check Row Observations Match Data in Glb Env.
# sum(gttbl$N) 
# sum(lttbl$N)
d <- rbind(lttbl, gttbl) 
# Create shifting function to move index values of column in d upwards by n 
shift <- function(d, n){
  c(d[-(seq(n))], rep(NA, n))
}
# Summarize with filtering
data <- d %>% 
  dplyr::select(key, year, Set, N, TPOP, TPOPN, SMEDVAL, SUMEDVAL, PMEDINC, PMEDHAI, PAVGHAI) %>% 
  filter(Set == 'LT100' & year == 2010 | year == 2019) %>% 
  filter(Set != 'GT100') %>% 
  mutate(SKEW = PAVGHAI - PMEDHAI, 
         MOE = ((SUMEDVAL - SMEDVAL)/N), 
         C2019 = ifelse(year == 2019, TPOP, NA), 
         C2010 = ifelse(year == 2010, TPOP, NA))%>% 
  dplyr::select(-PAVGHAI, -Set, -TPOPN, -SMEDVAL, -SUMEDVAL)

df.fin %>% 
  dplyr::select(key, year, Set, N, TPOP, TPOPN, SMEDVAL, SUMEDVAL, PMEDINC, PMEDHAI, PAVGHAI) %>%
  filter(Set == 'LT100' & year == 2010 | year == 2019) %>% 
  filter(Set != 'GT100') %>% 
  mutate(SKEW = PAVGHAI - PMEDHAI, 
         MOE = ((SUMEDVAL - SMEDVAL)/N), 
         C2019 = ifelse(year == 2019, TPOP, NA), 
         C2010 = ifelse(year == 2010, TPOP, NA))%>% 
  dplyr::select(-PAVGHAI, -Set, -TPOPN, -SMEDVAL, -SUMEDVAL) 

data$C2010 <- shift(data$C2010, 1)
data <- data %>% 
  mutate(CHANGE = C2019-C2010) %>% 
  dplyr::select(-C2010, -C2019) %>%
  mutate(CHANGE = replace_na(CHANGE, 0))
data <- as.data.frame(data) 
percent_pop_MSA <- 0.83
censuspop2019 <- 328300000

# display table of LT100 (unaffordable MSA)
data %>% 
  kbl(booktabs = T, caption = "Less Than Affordable Data Summary") %>%
  kable_styling(latex_options = c("striped", "HOLD_position", "scale_down"), full_width = F) %>%
  column_spec(1, width = "8em") %>%
  footnote(c("Includes calculations with all HAI values less than 100"))

# HAI Scatterplot Comparisson Plots
HAINAMES <- list("Normal" = "HAI", "Real Wage"="HAIRW", "Rent Adjustment"="HAIRNT", 
                 "Inflation Adjusted"="HAIIPD", "Raw Values"="HAIRAW", "Lenient Lending"="HAILEN")
hainames <- c("HAI" = "Normal", 
              "HAIRW"="Real Wage", 
              "HAIRNT"="Rent Adjusted", 
              "HAIIPD"="Inflation Adjusted", 
              "HAIRAW"="Raw Values", 
              "HAILEN"="Lenient Lending")
HAItitle <- function(variable,value){
  return(HAINAMES[value])
}
# Main 6 HAIs labeled Scatterplot Trends
main6 <- df.fin %>%
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC, -AINCALL) %>%
  filter(key == c("HAI", "HAIRW", "HAIRNT", 
                  "HAIIPD", "HAIRAW", "HAILEN")) %>% 
  filter(AINCALL <100000) %>% 
  ggplot(aes(value, (AINCALL/1000))) + 
  geom_point(aes(x = value, alpha = .01, col = key)) + 
  geom_vline(xintercept = 100, lty = "dotdash", col = "black") + 
  geom_smooth(aes(x = value), 
              method="lm", col = "grey30", fill = "light grey",
              se = T, na.rm = T) + 
  labs(x = "Home Affordability Value", y = "Income ($1000)", 
       subtitle = "Method Comparison to National Benchmark") +
  facet_wrap(key ~ ., scales = "free_x", shrink = F, labeller = labeller(key = hainames)) + 
  theme(legend.position = "none", 
        plot.subtitle = element_text(hjust = 0.5), 
        panel.grid = element_blank())
# Outstanding Debts HAI ScatterPlot Trends
dbts1 <- df.fin %>%
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC, -AINCALL) %>%
  filter(key == c("HAIDBT")) %>% 
  filter(AINCALL <100000) %>% 
  ggplot(aes(value, (AINCALL/1000))) + 
  geom_point(aes(x = value, alpha = .01, col = key)) + 
  geom_vline(xintercept = 100, lty = "dotdash", col = "black") + 
  geom_smooth(aes(x = value), 
              method="loess", col = "grey30", fill = "light grey",
              se = T, na.rm = T) + 
  labs(x = "Home Affordability Value", y = "Income ($1000)", 
       subtitle = "Debt Adjusted") +
  theme(legend.position = "none", 
        plot.title = element_text(hjust = .5)) 
dbts2 <- df.fin %>%
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC, -AINCALL) %>%
  filter(key == c("HAIDBT")) %>% 
  filter(AINCALL <100000) %>% 
  ggplot(aes(value, (AINCALL/1000))) + 
  geom_point(aes(x = value, alpha = .01, col = key)) +
  geom_smooth(aes(x = value), 
              method="loess", col = "grey30", fill = "light grey",
              se = T, na.rm = T) + 
  labs(x = "Home Affordability Value", y = element_blank(), 
       subtitle = "Debt Adjusted Centered") +
  theme(legend.position = "none", 
        plot.title = element_text(hjust = .5), 
        panel.grid.minor.y = element_blank())
# Arrange plots 
ggarrange(main6,
          ggarrange(dbts1, dbts2, 
                    ncol=2, labels = c(" ", " ")),
          nrow = 2, labels = " ")

# Histograms of HAI distributions
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC, -AINCALL) %>%
  filter(key == c("HAI", "HAIRW", "HAIRNT", 
                  "HAIIPD", "HAIRAW", "HAILEN")) %>% 
  mutate(value.med = median(value)) %>% 
  ggplot(aes(value, col = key)) + 
  geom_histogram(alpha = .05) + 
  geom_vline(xintercept = 100) + 
  labs(subtitle = "Method Distributions", x = "HAI", y = "Count") + 
  theme(plot.subtitle = element_text(hjust = 0.5)) + 
  facet_wrap(~key, scales = "free_x", labeller = labeller(key = hainames)) + 
  theme(legend.position = "none")

# Megaplot
MEGANAMES <- list("Affordable" = "GT100", "Unaffordable"="LT100")
meganames <- c("GT100" = "Affordable", 
               "LT100"="Unaffordable")
megatitles <- function(variable,value){
  return(MEGANAMES[value])
}
# Megaplots 
PMEDINC.median <- median(d$PMEDINC)
megaplot1 <- d %>% 
  sample_n(715, replace = T) %>% 
  filter(key != "HAIDBT") %>%
  group_by(key, Set) %>%
  arrange(desc(Set)) %>% 
  ggplot(aes(x = MMEDHAI, col = key)) + geom_point(aes(y = PMEDINC, col = key, size = 4)) + 
  geom_hline(yintercept = PMEDINC.median, lty = "dotted") + 
  geom_point(aes(y = PMEDINC)) +
  facet_wrap(~Set, scales = "free_x", labeller = labeller(Set = meganames)) +
  geom_smooth(aes(y = PMEDINC), 
              method="loess",
              col = "grey30", 
              fill = "light grey", 
              se = T, na.rm = T, 
              lty = "solid") + 
  geom_smooth(aes(y = PMEDINC), 
              method="lm", alpha = 0.25,
              col = "grey70", 
              fill = "light blue", 
              se = F, na.rm = T, 
              lty = "dashed") + 
  labs(x = "Median HAI Value", y = "Median Income") + 
  theme(legend.position = "none", plot.title = element_blank())
megaplot2 <- d %>% 
  sample_n(715, replace = T) %>% 
  filter(key != "HAIDBT") %>%
  group_by(key, Set) %>% 
  ggplot(aes(x = MMEDHAI, col = key)) + geom_point(aes(y = PMEDINC, col = key, size = 4)) + 
  geom_hline(yintercept = PMEDINC.median, lty = "dotted")  +
  facet_wrap(~key, scales = "free_x", labeller = labeller(key = hainames)) +
  geom_smooth(aes(y = PMEDINC), 
              method="loess",
              col = "grey30", 
              fill = "light grey", 
              se = F, na.rm = T, 
              lty = "solid") + 
  geom_smooth(aes(y = PMEDINC), 
              method="lm", alpha = 0.25,
              col = "grey30", 
              fill = "light blue", 
              se = T, na.rm = T, 
              lty = "dashed") + 
  labs(x = element_blank(), y = "Median Income", subtitle = "Patterns in MSA by HAI Method") + 
  theme(legend.position = "none", 
        plot.subtitle = element_text(hjust=0.5))
ggarrange(megaplot2, megaplot1, nrow=2)

df_finkey <- df.fin %>% 
    gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
           -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC, -AINCALL) 

df_types <- df_finkey %>% 
  spread(key, value) %>% 
  gather(key, value, -GeoFips, -GeoName, -year) %>% 
  mutate(Type = case_when(
    endsWith(key, "MEDINC") ~ "Basics",
    endsWith(key, "MEDVAL") ~ "Basics",
    endsWith(key, "MOE") ~ "Basics",
    endsWith(key, "UMEDVAL") ~ "Basics",
    endsWith(key, "LMEDVAL") ~ "Basics",
    endsWith(key, "PERINC") ~ "Basics",
    endsWith(key, "POP") ~ "Basics",
    endsWith(key, "ADJALL") ~ "Cost Adjustments",
    endsWith(key, "ADJIPD") ~ "Cost Adjustments",
    endsWith(key, "ADJRNT") ~ "Cost Adjustments",
    endsWith(key, "AINCALL") ~ "Income Adjustments",
    endsWith(key, "AINCDBT") ~ "Income Adjustments",
    endsWith(key, "AINCRNT") ~ "Income Adjustments",
    endsWith(key, "AQINC30") ~ "Income Adjustments",
    endsWith(key, "AQINC60") ~ "Income Adjustments", 
    endsWith(key, "DEBTCC") ~ "Debts and Obligations",
    endsWith(key, "DEBTED") ~ "Debts and Obligations",
    endsWith(key, "DEBTIL") ~ "Debts and Obligations",
    endsWith(key, "DEBTMV") ~ "Debts and Obligations",
    endsWith(key, "DEBTOC") ~ "Debts and Obligations",
    endsWith(key, "DEBTS") ~ "Debts and Obligations",
    endsWith(key, "HHSIZE") ~ "Debts and Obligations",
    endsWith(key, "IR") ~ "Debts and Obligations",
    endsWith(key, "HAI") ~ "Home Affordability Indices",
    endsWith(key, "HAIIPD") ~ "Home Affordability Indices",
    endsWith(key, "HAILEN") ~ "Home Affordability Indices",
    endsWith(key, "HAIRAW") ~ "Home Affordability Indices",
    endsWith(key, "HAIRNT") ~ "Home Affordability Indices",
    endsWith(key, "HAIRW") ~ "Home Affordability Indices",
    endsWith(key, "HAIDBT") ~ "Home Affordability Indices",
    endsWith(key, "RPPALL") ~ "Regional Price Parities",
    endsWith(key, "RPPGOODS") ~ "Regional Price Parities",
    endsWith(key, "RPPRENT") ~ "Regional Price Parities",
    endsWith(key, "RPPSOTH") ~ "Regional Price Parities",
    endsWith(key, "IPD") ~ "Implicit Price Deflator",
    endsWith(key, "PMT") ~ "Monthly Payments",
    endsWith(key, "PMT3DP") ~ "Monthly Payments",
    endsWith(key, "PMTRAW") ~ "Monthly Payments",
    endsWith(key, "QINC") ~ "Qualifying Income",
    endsWith(key, "QINCRAW") ~ "Qualifying Income",
    )) 

g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white'))



  

