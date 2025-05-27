# stochastic_process.R
# Visualizing Poisson process events over time

# --- Visualizing Poisson Process Events Over Time ---

# 1. Define the rate parameter (lambda)
# Lambda (λ) is the average number of events per unit of time.
# Let's say, on average, 2 events happen per unit of time (e.g., per hour, per day).
lambda <- 2

# 2. Define the duration for which we want to simulate the process
# Let's simulate for 10 units of time (e.g., 10 hours, 10 days).
max_time <- 10

# --- Simulation Method 1: Simulate Inter-Arrival Times ---
# The time between events in a Poisson process follows an Exponential distribution.
# We generate enough inter-arrival times to exceed our max_time.
# The rate parameter for rexp() is lambda.
set.seed(123) # For reproducibility

# Generate inter-arrival times
inter_arrival_times <- rexp(n = round(max_time * lambda * 1.5), rate = lambda)
# We generate more than expected (1.5x) to ensure we cover max_time.

# Calculate the cumulative sum to get the actual event times
event_times <- cumsum(inter_arrival_times)

# Filter events that occur within our defined max_time
event_times_within_range <- event_times[event_times <= max_time]

# Get the number of events
num_events <- length(event_times_within_range)

# --- Plotting Method 1: Scatter Plot of Event Occurrences ---
# This shows exactly when each event happens.
plot(event_times_within_range, 1:num_events,
     type = "p", # 'p' for points
     pch = 16,   # Solid circles for points
     col = "darkblue",
     xlab = "Time",
     ylab = "Event Number",
     main = paste("Poisson Process Events Over Time (λ =", lambda, ")"),
     xlim = c(0, max_time),
     ylim = c(0, num_events + 1), # Add some padding to y-axis
     cex = 1.2 # Size of points
)
# Add a horizontal line at each event to make it clearer
segments(0, 1:num_events, event_times_within_range, 1:num_events, col = "lightblue", lty = 2)
points(event_times_within_range, 1:num_events, pch = 16, col = "darkblue", cex = 1.2) # Re-plot points on top


# --- Plotting Method 2: Cumulative Number of Events (Step Plot) ---
# This shows how the total count of events grows over time.
# Create data for the step plot: (time, cumulative count)
cumulative_counts <- 0:num_events
times_for_step_plot <- c(0, event_times_within_range)

plot(stepfun(times_for_step_plot, cumulative_counts),
     xlim = c(0, max_time),
     xlab = "Time",
     ylab = "Cumulative Number of Events",
     main = paste("Cumulative Number of Events in Poisson Process (λ =", lambda, ")"),
     col = "darkred",
     lwd = 2) # Line width

# Add horizontal line at max_time for reference
abline(v = max_time, col = "gray", lty = 2)
text(max_time, 0, paste("Max Time =", max_time), pos = 4, col = "gray")

# Add final count
text(max_time, num_events, paste("Total Events =", num_events), pos = 2, col = "darkred")

# --- Optional: Simulate directly using `rpois` for counts over fixed intervals ---
# This is an alternative way to think about it:
# If you divide your max_time into small intervals (e.g., 1 unit each)
# The number of events in each interval follows a Poisson distribution with mean = lambda * interval_length
print(paste0("Expected number of events in ", max_time, " units of time: ", lambda * max_time))

# Simulate counts for 1-unit intervals
interval_counts <- rpois(max_time, lambda = lambda)
print("Number of events in each 1-unit interval (simulated):")
print(interval_counts)
print(paste("Total events in intervals:", sum(interval_counts)))

