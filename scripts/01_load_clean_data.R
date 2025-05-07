# Load required libraries
library(tidyverse)
library(lubridate)

# Read the dataset
data <- read.csv("~/Downloads/co-op/Projects/CustomerSegmentationR/data/social_media_users.csv", stringsAsFactors = FALSE)

# Quick view of the data
glimpse(data)
summary(data)
head(data)

# Convert 'Date.Joined' to Date type
data$Date.Joined <- as.Date(data$Date.Joined)

# Rename columns for easier access (remove dots)
colnames(data) <- make.names(colnames(data))

# Select features for clustering
# We'll use Daily.Time.Spent, Verified.Account, and optionally encode categorical vars later
data_clean <- data %>%
  select(Platform, Primary.Usage, Country, Daily.Time.Spent..min., Verified.Account) %>%
  filter(!is.na(Daily.Time.Spent..min.))  # remove rows with missing time

# Encode Verified.Account to 0/1
data_clean$Verified <- ifelse(data_clean$Verified.Account == "Yes", 1, 0)

# Normalize Daily Time Spent
data_clean$TimeSpent_Scaled <- scale(data_clean$Daily.Time.Spent..min.)

# Save cleaned data for next step
saveRDS(data_clean, "~/Downloads/co-op/Projects/CustomerSegmentationR/data/cleaned_users.rds")

cat("✅ Data cleaned and saved as RDS file.\n")
