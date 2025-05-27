# probability_experiment.R
# Die roll frequency distribution
# --- Die Roll Frequency Distribution ---

# 1. Define parameters for the simulation
num_rolls <- 1000 # Number of times to roll the die

# 2. Simulate die rolls
# sample(x, size, replace = TRUE)
# x = the possible outcomes (1 to 6 for a die)
# size = how many times to sample (number of rolls)
# replace = TRUE means we can roll the same number multiple times (which is how a die works)
set.seed(123) # For reproducibility, so you get the same results if you run it again
die_rolls <- sample(1:6, size = num_rolls, replace = TRUE)

# --- 3. Calculate Frequencies ---
# The table() function is perfect for counting the occurrences of each unique value.
# It automatically creates a frequency table.
roll_frequencies <- table(die_rolls)

# To ensure all 6 outcomes (1-6) are always present in the table, even if some
# didn't appear in the simulation (especially with few rolls), we can do this:
# Create a factor with all levels (1-6) and then make a table.
roll_frequencies_complete <- table(factor(die_rolls, levels = 1:6))

print("--- Die Roll Frequencies ---")
print(roll_frequencies_complete)

# Calculate relative frequencies (proportions)
relative_frequencies <- prop.table(roll_frequencies_complete)
print("--- Relative Frequencies (Proportions) ---")
print(round(relative_frequencies, 4)) # Round to 4 decimal places
print("----------------------------")


# --- 4. Visualize the Frequency Distribution (Bar Plot) ---

barplot(roll_frequencies_complete,
        main = paste("Frequency Distribution of", num_rolls, "Die Rolls"), # Plot title
        xlab = "Die Face (Outcome)",                                     # X-axis label
        ylab = "Frequency (Count)",                                      # Y-axis label
        col = "lightcoral",                                              # Bar color
        border = "darkred",                                              # Bar border color
        ylim = c(0, max(roll_frequencies_complete) * 1.1)                # Set y-axis limit with some padding
)

# Add text labels on top of the bars to show exact counts
text(x = seq_along(roll_frequencies_complete),
     y = roll_frequencies_complete,
     labels = roll_frequencies_complete,
     pos = 3, # Position above the bar
     cex = 0.8, # Text size
     col = "darkred"
)

# --- Optional: Visualize Relative Frequencies (Bar Plot) ---
# This shows the proportion of times each face appeared.
barplot(relative_frequencies,
        main = paste("Relative Frequency Distribution of", num_rolls, "Die Rolls"),
        xlab = "Die Face (Outcome)",
        ylab = "Relative Frequency (Proportion)",
        col = "lightgreen",
        border = "darkgreen",
        ylim = c(0, max(relative_frequencies) * 1.2) # Adjusted ylim for proportions
)

# Add text labels on top of the bars for proportions
text(x = seq_along(relative_frequencies),
     y = relative_frequencies,
     labels = round(relative_frequencies, 3), # Round proportions for labels
     pos = 3,
     cex = 0.8,
     col = "darkgreen"
)

# Add a horizontal line for the theoretical probability (1/6)
abline(h = 1/6, col = "blue", lty = 2, lwd = 2)
text(x = 6, y = 1/6 + 0.01, labels = "Theoretical (1/6)", col = "blue", pos = 2)
