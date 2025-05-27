# distribution_sample.R
# Histogram and summary stats for normal distribution

# --- Histogram and Summary Statistics for a Normal Distribution ---

# 1. Define parameters for the normal distribution
mean_val <- 50    # Mean (μ) of the distribution
sd_val <- 10      # Standard Deviation (σ) of the distribution
num_samples <- 1000 # Number of random samples to generate

# 2. Generate random data from a normal distribution
# rnorm(n, mean = ..., sd = ...) generates 'n' random numbers
# from a normal distribution with the specified mean and standard deviation.
set.seed(42) # Set a seed for reproducibility, so you get the same random numbers each time
normal_data <- rnorm(n = num_samples, mean = mean_val, sd = sd_val)

# --- 3. Calculate Summary Statistics ---
print("--- Summary Statistics for the Normal Distribution Data ---")

# Basic summary (min, 1st Quartile, Median, Mean, 3rd Quartile, Max)
summary_stats <- summary(normal_data)
print(summary_stats)

# Individual statistics
mean_of_data <- mean(normal_data)
median_of_data <- median(normal_data)
sd_of_data <- sd(normal_data)
min_of_data <- min(normal_data)
max_of_data <- max(normal_data)
quantile_25 <- quantile(normal_data, 0.25)
quantile_75 <- quantile(normal_data, 0.75)

print(paste("Mean:", round(mean_of_data, 2)))
print(paste("Median:", round(median_of_data, 2)))
print(paste("Standard Deviation:", round(sd_of_data, 2)))
print(paste("Minimum:", round(min_of_data, 2)))
print(paste("Maximum:", round(max_of_data, 2)))
print(paste("25th Percentile (Q1):", round(quantile_25, 2)))
print(paste("75th Percentile (Q3):", round(quantile_75, 2)))
print("--------------------------------------------------")


# --- 4. Create a Histogram ---
# A histogram visually represents the distribution of a dataset.
# The x-axis shows bins (intervals) of data values, and the y-axis shows the frequency
# (count) of data points falling into each bin.

hist(normal_data,
     main = "Histogram of Normally Distributed Data", # Title of the histogram
     xlab = "Value",                                 # Label for the x-axis
     ylab = "Frequency",                             # Label for the y-axis
     col = "skyblue",                                # Bar color
     border = "black",                               # Border color of bars
     breaks = 30,                                    # Number of bins (or a vector of breakpoints)
     prob = FALSE                                    # Display frequencies (counts) on y-axis (TRUE for density)
)

# Optionally, add a density curve of the theoretical normal distribution
# to compare with the histogram bars.
# For this, we need 'prob = TRUE' in hist() to get density on y-axis.
hist(normal_data,
     main = "Histogram with Normal Density Curve",
     xlab = "Value",
     ylab = "Density",
     col = "lightgreen",
     border = "black",
     breaks = 30,
     prob = TRUE # Important: set to TRUE for density
)

# Add the theoretical normal density curve
curve(dnorm(x, mean = mean_val, sd = sd_val), # dnorm() is the density function for normal distribution
      add = TRUE,                              # Add to the existing plot
      col = "darkred",                         # Color of the curve
      lwd = 2                                  # Line width
)

# Add a vertical line for the mean
tabline(v = mean_of_data, col = "blue", lty = 2, lwd = 2)
text(mean_of_data + 1, max(hist(normal_data, plot = FALSE)$density) * 0.9, "Mean", col = "blue", pos = 4)

