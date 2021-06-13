# HA 2.1 

# Packages:
library(forecast)


####### Q&A #######


# Use the help function to explore what the series gold, woolyrnq and gas represent.

help(gold, package = forecast)
tsdisplay(gold)

# A: Daily morning gold prices in US dollars. 1 January 1985 - 31 March 1989.

help(woolyrnq, package = forecast)
tsdisplay(woolyrnq)

# A: Quarterly production of woollen yarn in Australia: tonnes. Mar 1965 - Sep 1994.

help(gas, package = forecast)
tsdisplay(gas)

# A: Australian monthly gas production: 1956-1995.

# a) Use autoplot() to plot each of these in separate plots.

autoplot(gold)
autoplot(woolyrnq)
autoplot(gas)

# b) What is the frequency of each series? Hint: apply the frequency() function.

?frequency

frequency(gold)
frequency(woolyrnq)
frequency(gas)

# A: gold = 1, woolyrnq = 4, gas = 12

# c) Use which.max() to spot the outlier in the gold series. Which observation was it?

which.max(gold)
gold[770]
# A: Index is at 770; the daily morning gold price was 593.7. 
