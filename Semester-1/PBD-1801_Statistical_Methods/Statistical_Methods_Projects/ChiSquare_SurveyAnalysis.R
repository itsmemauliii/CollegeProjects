# Load data
survey_data <- read.csv("survey_data.csv")
survey_data
# Create contingency table
table_data <- table(survey_data$Gender, survey_data$ProductPreference)
table_data
# Chi-square test
chisq.test(table_data)
# Expected values
chisq.test(table_data)$expected
# Visualizing with mosaic plot
mosaicplot(table_data, main = "Product Preference by Gender", col = TRUE)
