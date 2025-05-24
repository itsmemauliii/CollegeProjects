# Load libraries
library(ggplot2)
library(dplyr)
# Load data
retail_data <- read.csv(file.choose())
retail_data
# Initial summary
summary(retail_data)
str(retail_data)

# Handle missing values
retail_data <- na.omit(retail_data)

# Central tendency & dispersion
mean(retail_data$Sales)
median(retail_data$Sales)
sd(retail_data$Sales)

# Histogram
ggplot(retail_data, aes(Sales)) +
  geom_histogram(binwidth = 500, fill = "blue", color = "white") +
  ggtitle("Sales Distribution")

# Boxplot by Region
ggplot(retail_data, aes(x = Region, y = Sales)) +
  geom_boxplot(fill = "skyblue") +
  ggtitle("Sales by Region")

# Skewness & Kurtosis
library(e1071)
skewness(retail_data$Sales)
kurtosis(retail_data$Sales)
