# Simulate multivariate normal data, add outliers, and identify them using the Mahalanobis distance

library(MASS)

simulate_bivariate_normal <- function(n, p, mu = c(0, 0), sigma = c(1, 1)) {
  cov_matrix <- matrix(c(sigma[1]^2, p * sigma[1] * sigma[2],
                         p * sigma[1] * sigma[2], sigma[2]^2), 
                       nrow = 2)
  return(mvrnorm(n, mu = mu, Sigma = cov_matrix))
}

set.seed(123) # For reproducibility
n <- 10**3
p <- 0.8
m <- 3 # Number of outliers
outlier_sizes <- c(10.0, 15.0, 20.0) # Sizes of the outliers
outlier_indices <- sample(1:n, m) # Randomly select indices for the outliers

# Simulate data
samples <- simulate_bivariate_normal(n, p)
cat("#samples:", n)
cat("\nTarget, sample correlations (p):", p, cor(samples[, 1], samples[, 2]))

# Add outliers
for (i in 1:m) {
  samples[outlier_indices[i], 1] <- samples[outlier_indices[i], 1] + outlier_sizes[i]
}
cat("\nAfter adding outliers, sample correlations (p):", p, cor(samples[, 1], samples[, 2]), "\n")

# Detect outliers using Mahalanobis distance
center <- colMeans(samples)
cov_matrix <- cov(samples)
distances <- mahalanobis(samples, center, cov_matrix)
p_values <- 1 - pchisq(distances, df = 2)

# Threshold for outliers (e.g., chi-squared critical value with df = 2)
threshold <- qchisq(0.99, df = 2)
outliers <- which(distances > threshold)

# Create a data frame of outlier indices, Mahalanobis distances, p-values, and sizes
outlier_info <- data.frame(
  Index = outliers,
  Distance = distances[outliers],
  P_Value = p_values[outliers],
  Outlier_Size = ifelse(outliers %in% outlier_indices, 
                        outlier_sizes[match(outliers, outlier_indices)], NA)
)

# Sort the outliers in descending order of significance (ascending order of p-value)
outlier_info <- outlier_info[order(outlier_info$P_Value), ]

# Print the outliers and their statistical significance
cat("Outliers detected (sorted by significance):\n")
print(outlier_info)
