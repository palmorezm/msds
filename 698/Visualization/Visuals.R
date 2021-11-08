

library(tidyverse)
library(ggpubr)

df.fin <- read.csv("https://raw.githubusercontent.com/palmorezm/msds/main/698/Data/fin.csv")
df.fin <- df.fin %>% 
  dplyr::select(-X)

ggplot2::theme_set(theme_minimal())
# Histogram of HAI values
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI", "HAIRW", "HAIRNT", "HAIIPD", 
                  "HAIRAW", "HAIDBT", "HAILEN")) %>% 
  ggplot(aes(value)) + 
  geom_histogram(aes(alpha = .05, fill = key), binwidth = 5)
# Jitter plot of HAI values by year
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI", "HAIRW", "HAIRNT", "HAIIPD", "HAIRAW", "HAIDBT", "HAILEN")) %>% 
  ggplot(aes(year, value)) + 
  geom_jitter(aes(col = key, alpha = .15)) 
# Increase in all NAR HAI over 10 years
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI")) %>% 
  ggplot(aes(year, value)) + 
  geom_point(aes(col = key, alpha = .15)) + 
  geom_smooth(col = "black")
# Change in personal income and HAI value per year
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI")) %>% 
  ggplot(aes(year, value)) + 
  geom_point(aes(x = PERINC, col = PERINC, alpha = .15)) 
# Change in personal income over the population 
perinc.plt1 <- df.fin %>% 
  filter(year == 2019) %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI")) %>% 
  filter(PERINC <= 500000000) %>%
  ggplot(aes((PERINC/100000000), (POP/100000), col = (PERINC/100000000))) + 
  geom_point(aes(x = (PERINC/100000000), size = MOE), alpha = .5) + 
  geom_smooth(aes(x = (PERINC/100000000)), 
              method="loess", col = "grey38", 
              se = T, fill = "light blue", alpha = 0.25) + 
  labs(x = "Personal Income (millions)", y = "Population (100,000)") + 
  theme_classic() +
  theme(legend.position = "none")
# Subplot of above Change in personal income over the population
perinc.plt2 <- df.fin %>% 
  filter(year == 2019) %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI")) %>% 
  filter(PERINC <= 100000000) %>%
  ggplot(aes((PERINC/100000000), (POP/100000), col = (PERINC/100000000))) + 
  geom_point(aes(x = (PERINC/100000000), size = MOE), alpha = .50) + 
  geom_smooth(aes(x = (PERINC/100000000)), 
              method="loess", col = "grey38", 
              se = T, fill = "light blue", alpha = 0.25) + 
  labs(x = "Personal Income (millions)", y = "Population (100,000)") + 
  theme_classic()
perinc.pltfull <- ggarrange(perinc.plt1, perinc.plt2)
annotate_figure(perinc.pltfull, top = text_grob("Examining the Relationship between MSA Wealth and Size", 
                                                color = "Black", size = 14))

# Change in personal income, HAI, and population across all HAI's
df.fin %>%  
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>%
  filter(key == c("HAI", "HAIRW", "HAIRNT", 
                  "HAIIPD", "HAIRAW", "HAIDBT", "HAILEN")) %>%
  ggplot(aes(value, PERINC, col = PERINC)) + 
  geom_point(aes(x = PERINC, alpha = .15)) + 
  geom_smooth(aes(x = value), 
              method="loess", col = "black") + 
  facet_wrap(~key, scales = "free")  
# Needs Review
df.fin %>%  
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>%
  filter(key == c("HAI", "HAIRW", "HAIRNT", 
                  "HAIIPD", "HAIRAW", "HAIDBT", "HAILEN")) %>%
  ggplot(aes(value, PERINC, col = PERINC)) + 
  geom_point(aes(x = value, alpha = .15)) + 
  geom_smooth(aes(x = value), 
              method="loess", col = "black") + 
  facet_wrap(~key, scales = "free")  
# Histogram without HAIDBT
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAI", "HAIRW", "HAIRNT", "HAIIPD", 
                  "HAIRAW", "HAILEN")) %>% 
  ggplot(aes(value)) + 
  geom_histogram(aes(alpha = .50, col = key, fill=I("white")), binwidth = 5)
# Histogram with only HAIDBT
df.fin %>% 
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC) %>% 
  filter(key == c("HAIDBT")) %>% 
  ggplot(aes(value)) + 
  geom_histogram(aes(alpha = .50, col = key, fill=I("white")), binwidth = .1)

# Real Income and HAI's
# create a title list for HAI
HAINAMES <- list("Normal" = "HAI", "Real Wage"="HAIRW", "Rent Adjustment"="HAIRNT", 
                 "Inflation Adjusted"="HAIIPD", "Raw Values"="HAIRAW", "Lenient Lending"="HAILEN")
hainames <- c("HAI" = "Normal", 
              "HAIRW"="Real Wage", 
              "HAIRNT"="Rent Adjustment", 
              "HAIIPD"="Inflation Adjusted", 
              "HAIRAW"="Raw Values", 
              "HAILEN"="Lenient Lending")
HAItitle <- function(variable,value){
  return(HAINAMES[value])
}
df.fin %>%
  gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
         -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC, -AINCALL) %>%
  filter(key == c("HAI", "HAIRW", "HAIRNT", 
                  "HAIIPD", "HAIRAW", "HAILEN")) %>% 
  filter(AINCALL <100000) %>% 
  ggplot(aes(value, (AINCALL/1000))) + 
  geom_point(aes(x = value, alpha = .15, col = key)) + 
  geom_vline(xintercept = 100, lty = "dotdash", col = "black") + 
  geom_smooth(aes(x = value), 
              method="loess", col = "grey30", fill = "light grey",
              se = T, na.rm = T) + 
  labs(x = "Home Affordability Value", y = "Median Income ($1000)") +
  facet_wrap(key ~ ., scales = "free", shrink = F, labeller = labeller(key = hainames)) + 
  theme(legend.position = "none")



# Notes:
# 1 - Make the same scales on axes where possible
# 2 - Denote the different HAI keys by color 


# New Notes:
# Tabulate total number of Metro Areas above and below threshold under different HAI measures
# For example: Under HAILEN, how many metro's were given above 100 HAI? How many under 100? 


df.fin %>%
  filter(MEDINC >= 50000) %>% 
  group_by(GeoFips, GeoName) %>% 
  summarise(AVGHAIRNT = median(HAIRNT)) %>% 
  filter(AVGHAIRNT >= 140) %>% View()

# Number of Options (At 40k)
# 120 = 263
# 130 = 248
# 140 = 236
# 150 = 221
# 160 = 205
# 170 = 188
# 180 = 175
# 190 = 160
# 200 = 143

# Histogram of Options
df.fin %>%
  filter(MEDINC >= 40000) %>% 
  group_by(GeoFips, GeoName) %>% 
  summarise(AVGHAIRNT = median(HAIRNT)) %>% 
  filter(AVGHAIRNT >= 100) %>% 
  ggplot(aes(AVGHAIRNT)) + 
  geom_histogram(aes(fill = GeoName, col = AVGHAIRNT, alpha = 0.5), binwidth = 5) + 
  theme(legend.position = "none")

# Scatterplot of Options
df.fin %>%
  group_by(GeoFips, GeoName) %>% 
  summarise(AVGHAIRNT = median(HAIRNT)) %>% 
  filter(AVGHAIRNT >= 100) %>% 
  ggplot(aes(GeoFips, AVGHAIRNT)) + geom_point(aes(fill = GeoName, alpha = .25)) + 
  theme(legend.position = "none")

library(plotly)
df <- df.fin %>%
  group_by(GeoFips, GeoName) %>% 
  summarise(AVGHAIRNT = median(HAIRNT)) %>% 
  filter(AVGHAIRNT >= 100)  %>% 
  arrange(desc(AVGHAIRNT))

class(df$GeoName)
df$GeoName <- as.factor(df$GeoName)

plot_ly(df, x = "GeoFips", y = "AVGHAIRNT", color = "GeoFips")


df.fin %>% 
  filter(year == 2019) %>% 
  summarize(NatAvg = mean(MEDINC))

library(ggplot2)

df.fin %>% 
  filter(GeoFips == 31540 | GeoFips == 40060) %>% 
  ggplot(aes(year, MEDINC)) + 
  geom_point(aes(col = GeoName, size = HAIRNT), alpha = .99, shape = 21) + 
  geom_smooth(aes(col = GeoName, fill = GeoName), alpha = .05)
