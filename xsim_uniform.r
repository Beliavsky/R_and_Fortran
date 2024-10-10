# Function to simulate niter sets of n uniformly distributed random numbers
# and compute standard error of the means and variances
simulate_uniform_se <- function(n, niter) {
  # Store means and variances for each iteration
  means <- numeric(niter)
  variances <- numeric(niter)
  
  for (i in 1:niter) {
    # Simulate a set of n uniformly distributed random numbers
    set <- runif(n)
    
    # Compute mean and variance for the set
    means[i] <- mean(set)
    variances[i] <- var(set)
  }
  
  # Compute standard error of the estimated means and variances
  se_mean <- sd(means) / sqrt(niter)
  se_variance <- sd(variances) / sqrt(niter)
  
  # Compute the average of the means and variances
  avg_mean <- mean(means)
  avg_variance <- mean(variances)
  
  # Find the minimum and maximum of the means and variances
  min_mean <- min(means)
  max_mean <- max(means)
  min_variance <- min(variances)
  max_variance <- max(variances)
  
  # Print results with aligned formatting
  cat(sprintf("    %-40s %10d\n", "Number of observations per data set:", n))
  cat(sprintf("    %-40s %10d\n", "Number of data sets:", niter))
  cat(sprintf("    %-40s %20.10f\n", "Average Mean:", avg_mean))
  cat(sprintf("    %-40s %20.10f\n", "Average Variance:", avg_variance))
  cat(sprintf("    %-40s %20.10f\n", "Standard Error of Mean:", se_mean))
  cat(sprintf("    %-40s %20.10f\n", "Standard Error of Variance:", se_variance))
  cat(sprintf("    %-40s %20.10f\n", "Minimum Mean:", min_mean))
  cat(sprintf("    %-40s %20.10f\n", "Maximum Mean:", max_mean))
  cat(sprintf("    %-40s %20.10f\n", "Minimum Variance:", min_variance))
  cat(sprintf("    %-40s %20.10f\n", "Maximum Variance:", max_variance))
}

# Example usage
n <- 100  # Number of random numbers in each set
niter <- 10^6  # Number of iterations
simulate_uniform_se(n, niter)
