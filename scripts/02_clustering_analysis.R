# Load required libraries
library(caret)
library(factoextra)
library(dplyr)

# Load cleaned data
data_clean <- readRDS("~/Downloads/co-op/Projects/CustomerSegmentationR/data/cleaned_users.rds")

# Encode categorical variables (Platform, Primary.Usage, Country)
categorical <- data_clean %>%
  select(Platform, Primary.Usage, Country)

dummy <- dummyVars(" ~ .", data = categorical)
dummy_data <- data.frame(predict(dummy, newdata = categorical))

# Combine with scaled tim and verified flag
features <- cbind(dummy_data,
                  TimeSpent = data_clean$TimeSpent_Scaled,
                  Verified = data_clean$Verified)

# Determine optimal number of clusters (Elbow method)
fviz_nbclust(features, kmeans, method = "wss")

# Apply K-means clustering with k = 4 (adjustable)
set.seed(123)
k_model <- kmeans(features, centers = 4, nstart = 25)

# Add cluster labels to original data
data_clustered <- cbind(data_clean, Cluster = as.factor(k_model$cluster))

# Save full output for visualization and analysis
saveRDS(data_clustered, "~/Downloads/co-op/Projects/CustomerSegmentationR/data/clustered_users.rds")

# Cluster summary
cluster_summary <- data_clustered %>%
  group_by(Cluster) %>%
  summarise(
    Count = n(),
    AvgTimeSpent = mean(Daily.Time.Spent..min.),
    VerifiedRate = mean(Verified)
  )

# Export summary
write.csv(cluster_summary, "~/Downloads/co-op/Projects/CustomerSegmentationR/data/cluster_summary.csv", row.names = FALSE)

cat("✅ K-means clustering completed and results saved.\n")
