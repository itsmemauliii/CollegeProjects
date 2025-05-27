# time_series_model.R
# Time series plot with trend and seasonality
# --- Time Series Plot with Trend and Seasonality (My Style) ---

# 1. Load necessary libraries (if not already loaded)
#    'forecast' package is excellent for time series analysis and plotting
#    You might need to install it first: install.packages("forecast")
# install.packages("forecast") # Uncomment and run this line if you haven't installed it
library(forecast)
library(ggplot2) # For more aesthetically pleasing plots (optional, but good practice)

# --- 2. Create Sample Time Series Data ---
# Let's simulate 5 years of monthly data (60 observations)
# with a clear increasing trend and a yearly seasonal pattern.
set.seed(123) # for reproducibility

# Generate dates for 5 years (monthly)
dates <- seq(as.Date("2019-01-01"), by = "month", length.out = 60)

# Create a trend component (increasing over time)
trend <- seq(10, 50, length.out = 60)

# Create a seasonal component (yearly cycle)
# Peak in summer, trough in winter
month_effect <- rep(c(0, 5, 10, 15, 10, 5, 0, -5, -10, -15, -10, -5), 5)

# Add some random noise
noise <- rnorm(60, mean = 0, sd = 3)

# Combine components to create the observed time series
value <- trend + month_effect + noise

# Create a data frame
my_ts_data <- data.frame(Month = dates, Value = value)

# --- 3. Convert to a Time Series Object (`ts`) ---
# The `ts()` function is crucial for time series analysis in R.
# start = c(Year, Month), frequency = Number of observations per year (12 for monthly)
my_ts_object <- ts(my_ts_data$Value, start = c(2019, 1), frequency = 12)

# --- 4. Plot the Original Time Series ---
# Using base R plot for simplicity, or ggplot for more customization
plot(my_ts_object,
     main = "Original Time Series Data (with Trend and Seasonality)",
     xlab = "Year",
     ylab = "Value",
     col = "darkblue",
     lwd = 1.5) # Line width

# --- 5. Decompose the Time Series using STL (Seasonal-Trend decomposition using Loess) ---
# s.window = "periodic" is good for fixed seasonal patterns.
# The result will have 'seasonal', 'trend', and 'remainder' components.
ts_decomposition <- stl(my_ts_object, s.window = "periodic")

# --- 6. Plot the Decomposed Components ---
# This plot automatically shows the original, seasonal, trend, and remainder components.
plot(ts_decomposition,
     main = "STL Decomposition of Time Series") # Main title for the entire plot area

# --- 7. (Optional) Visualize Trend and Seasonality on Separate Plots with ggplot2 ---
# This provides more control over aesthetics if you prefer ggplot2.
# You need to extract the components first.
trend_component <- as.numeric(ts_decomposition$time.series[, "trend"])
seasonal_component <- as.numeric(ts_decomposition$time.series[, "seasonal"])

# Add decomposed components back to the original data frame
my_ts_data$Trend <- trend_component
my_ts_data$Seasonal <- seasonal_component

# Plot original series with trend overlay
p1 <- ggplot(my_ts_data, aes(x = Month)) +
  geom_line(aes(y = Value, color = "Original Series"), size = 0.8) +
  geom_line(aes(y = Trend, color = "Trend Component"), size = 1, linetype = "dashed") +
  labs(title = "Time Series with Trend Overlay",
       y = "Value",
       x = "Date",
       color = "Component") +
  scale_color_manual(values = c("Original Series" = "darkblue", "Trend Component" = "red")) +
  theme_minimal()

print(p1)

# Plot seasonal component
p2 <- ggplot(my_ts_data, aes(x = Month, y = Seasonal)) +
  geom_line(color = "forestgreen", size = 0.8) +
  labs(title = "Seasonal Component",
       y = "Seasonal Effect",
       x = "Date") +
  theme_minimal()

print(p2)

# --- 8. (Optional) Forecast based on decomposition (requires 'forecast' package) ---
# You can use the decomposed components for forecasting
# forecast_result <- forecast(ts_decomposition, method = "naive") # Example forecasting
# plot(forecast_result)

