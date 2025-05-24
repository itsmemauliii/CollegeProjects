# Load libraries
library(tidyverse)
library(forecast)
library(tseries)

# Load COVID time series data
covid_data <- read.csv("covid_timeseries.csv")
ts_data <- ts(covid_data$Cases, start = c(2020, 1), frequency = 12)

# Plot raw time series
plot(ts_data, main="Monthly COVID-19 Cases", ylab="Cases", col="darkred")

# Decomposition
decomposed <- decompose(ts_data)
plot(decomposed)

# Check stationarity
adf.test(ts_data)

# Autocorrelation
acf(ts_data)
pacf(ts_data)

# Smoothing using Moving Average
ma <- ma(ts_data, order = 3)
plot(ma, main="3-Month Moving Average")

