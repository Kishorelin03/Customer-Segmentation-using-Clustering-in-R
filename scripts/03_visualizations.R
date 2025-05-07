# Load libraries
library(ggplot2)
library(factoextra)
library(dplyr)

# Load clustered data
data_clustered <- readRDS("~/Downloads/co-op/Projects/CustomerSegmentationR/data/clustered_users.rds")

# Recreate features used for clustering (same as in script 02)
categorical <- data_clustered %>%
  select(Platform, Primary.Usage, Country)

dummy <- dummyVars(" ~ .", data = categorical)
dummy_data <- data.frame(predict(dummy, newdata = categorical))

features <- cbind(dummy_data,
                  TimeSpent = data_clustered$TimeSpent_Scaled,
                  Verified = data_clustered$Verified)

# PCA
pca_result <- prcomp(features, scale. = TRUE)

# Visualize PCA with clusters
fviz_pca_ind(pca_result,
             geom.ind = "point",
             col.ind = data_clustered$Cluster,
             palette = "jco",
             addEllipses = TRUE,
             legend.title = "Cluster")

# Save plot to file (optional)
ggsave("~/Downloads/co-op/Projects/CustomerSegmentationR/output/pca_clusters.png", width = 8, height = 6)

cat("✅ PCA visualization complete.\n")
