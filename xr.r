# Initialize data
real_data <- seq(1, 10, by = 1)  # This will explicitly set real_data as numeric
int_data <- 1:10                 # Integer data

# Format function for aligned output with colon
fmt_real <- function(label, values) {
  cat(sprintf("%32s: ", label))  # Add the colon and space after label
  cat(sprintf("%10.4f", values), "\n")
}

fmt_int <- function(label, values) {
  cat(sprintf("%32s: ", label))  # Add the colon and space after label
  cat(sprintf("%10d", values), "\n")
}

fmt_real("Real data", real_data)
fmt_int("Integer data", int_data)
fmt_real("Mean of real_data", mean(real_data))
fmt_real("Mean of int_data", mean(int_data))
fmt_real("Standard deviation of real_data", sd(real_data))
fmt_real("Standard deviation of int_data", sd(int_data))
fmt_real("Variance of real_data", var(real_data))
fmt_real("Variance of int_data", var(int_data))
fmt_real("Median of real_data", median(real_data))
fmt_real("Median of int_data", median(int_data))
fmt_real("Range of real_data", range(real_data))
fmt_int("Range of int_data", range(int_data))
quantiles_real <- quantile(real_data, probs = c(0.25, 0.50, 0.75))
quantiles_int <- quantile(int_data, probs = c(0.25, 0.50, 0.75))
fmt_real("Quantiles of real_data", quantiles_real)
fmt_real("Quantiles of int_data", quantiles_int)
fmt_real("IQR of real_data", IQR(real_data))
fmt_real("IQR of int_data", IQR(int_data))
fmt_real("Product of real_data", prod(real_data))
fmt_int("Product of int_data", prod(int_data))
