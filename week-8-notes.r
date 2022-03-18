#############
"R-code notes compilation for  Week 8 March 15th, 17th
Compiled by: Deepta Basak. B.Math(hons.) 1st year"
#############


# Simulating Central Limit 

# loading tidyverse for ggplot
library(tidyverse)




binomialsim1 <- rbinom(100, 10, 0.25)
# Generates 100 Binomial(10,0.25) samples
binomialsim2 <- replicate(100, rbinom(1, 10, 0.75))
# Generates 100 Binomial(10,0.75) samples
binomialsim3 <- replicate(100, rbinom(1, 10, 0.5))
# Generates 100 Binomial(10,0.5) samples

# Let's plot these
par(mfrow = c(1, 3))
#  par() -> used to set graphical entry parameters.
#  mfrow = c(1, 3) -> ensures all subsequent figures will be drawn in a 1x3 array on the device BY COLUMNS.

# Histogram plots of all the above three simulations
hist(binomialsim1, xlim = c(0, 10), main = "Binomial(10, 0.25)")
hist(binomialsim2, xlim = c(0, 10), main = "Binomial(10, 0.75)")
hist(binomialsim3, xlim = c(0, 10), main = "Binomial(10, 0.5)")
# From the above plots, it seems that for n = 10,
# symmetry is achieved when p = 0.5 and not when p = 0.25 or p = 0.75



### Visualizing the Central Limit Theorem

## n = 10
binomialsim1 <- replicate(
  100,
  (rbinom(1, 10, 0.1) - 1) / sqrt(10 * 0.1 * 0.9)
)
binomialsim2 <- replicate(
  100,
  (rbinom(1, 10, 0.25) - 2.5) / sqrt(10 * 0.25 * 0.75)
)
binomialsim3 <- replicate(
  100,
  (rbinom(1, 10, 0.5) - 5) / sqrt(10 * 0.5 * 0.5)
)

# Plotting
par(mfrow = c(1, 3))
# Standardized histograms for Binomial distribution with n = 10 and p = 0.1, 0.25, 0.5
hist(binomialsim1, main = "Std-Binomial(10, 0.1)")
hist(binomialsim2, main = "Std-Binomial(10, 0.25)")
hist(binomialsim3, main = "Std-Binomial(10, 0.5)")
# Perhaps n = 10 is not large enough to see the Central Limit Theorem occurring




## n = 20
binomialsim1 <- replicate(
  100,
  (rbinom(1, 20, 0.1) - 2) / sqrt(20 * 0.1 * 0.9)
)
binomialsim2 <- replicate(
  100,
  (rbinom(1, 20, 0.25) - 5) / sqrt(20 * 0.25 * 0.75)
)
binomialsim3 <- replicate(
  100,
  (rbinom(1, 20, 0.5) - 10) / sqrt(20 * 0.5 * 0.5)
)

# Plotting
par(mfrow = c(1, 3))
# Standardized histograms for Binomial distribution with n = 20 and p = 0.1, 0.25, 0.5
hist(binomialsim1, main = "Std-Binomial(20, 0.1)")
hist(binomialsim2, main = "Std-Binomial(20, 0.25)")
hist(binomialsim3, main = "Std-Binomial(20, 0.5)")
# n = 20 seems better for visualizing the Central Limit Theorem




## n = 50
binomialsim1 <- replicate(
  100,
  (rbinom(1, 50, 0.1) - 5) / sqrt(50 * 0.1 * 0.9)
)
binomialsim2 <- replicate(
  100,
  (rbinom(1, 50, 0.25) - 12.5) / sqrt(50 * 0.25 * 0.75)
)
binomialsim3 <- replicate(
  100,
  (rbinom(1, 50, 0.5) - 25) / sqrt(50 * 0.5 * 0.5)
)

# Plotting
par(mfrow = c(1, 3))
# Standardized histograms for Binomial distribution with n = 50 and p = 0.1, 0.25, 0.5
hist(binomialsim1, main = "Std-Binomial(50, 0.1)")
hist(binomialsim2, main = "Std-Binomial(50, 0.25)")
hist(binomialsim3, main = "Std-Binomial(50, 0.5)")
# With n = 50, we get closer to a Normal distribution









## Confidence Intervals

cifn <- function(x, alpha = 0.95) {
  z <- qnorm(
    (1 - alpha) / 2,
    lower.tail = FALSE
  )
  # z = 1.96
  sdx <- sqrt(1 / length(x))
  # sdx = \frac{1}{\sqrt{n}}
  c(mean(x) - z * sdx, mean(x) + z * sdx)
  # (mean(x) - \frac{1.96}{\sqrt{n}}, mean(x) - \frac{1.96}{\sqrt{n}})
}

##

x1 <- rnorm(100, 0, 1)
# 100 samples from Normal(0,1)
y <- cifn(x1)
# 95% confidence interval

x2 <- rnorm(100, 0, 1)
# 100 samples from Normal(0,1)
z <- cifn(x2)
# 95% confidence interval

x3 <- rnorm(100, 0, 1)
# 100 samples from Normal(0,1)
w <- cifn(x3)
# 95% confidence interval


## Let's plot the confidence intervals
par(mfrow = c(1, 3))

plot(c(0, 0), y, type = "l", xlab = "", ylab = "", axes = FALSE)
axis(2, at = c(-0.25, -0.15, -0.1, 0, 0.1, 0.15, 0.25))
points(0, 0, pch = 19, col = "blue")
points(0, y[1], pch = 23, col = "brown")
points(0, y[2], pch = 24, col = "brown")
# Plot of the first confidence interval y

plot(c(0, 0), z, type = "l", xlab = "", ylab = "", axes = FALSE)
axis(2, at = c(-0.25, -0.15, -0.1, 0, 0.1, 0.15, 0.25))
points(0, 0, pch = 19, col = "blue")
points(0, z[1], pch = 23, col = "brown")
points(0, z[2], pch = 24, col = "brown")
# Plot of the second confidence interval z

plot(c(0, 0), w, type = "l", xlab = "", ylab = "", axes = FALSE)
axis(2, at = c(-0.25, -0.15, -0.1, 0, 0.1, 0.15, 0.25))
points(0, 0, pch = 19, col = "blue")
points(0, w[1], pch = 23, col = "brown")
points(0, w[2], pch = 24, col = "brown")
# Plot of the third confidence interval w

### In this simulation, 0 belongs to all three confidence intervals y, z, w








# Checking confidence intervals with differnent number of trials
###
normaldata <- replicate(10,
  rnorm(100, 0, 1),
  simplify = FALSE
)
# Generate 10 trials of 100 samples from the Normal(0,1) distribution

cidata <- sapply(normaldata, cifn)
# Apply cfin() to each trial

TRUEIN <- cidata[1, ] * cidata[2, ] < 0
table(TRUEIN)
# Check how many of the confidence intervals contain 0

require(ggplot2)
df <- data.frame(x = 1:10, z1 = cidata[1, ], z2 = cidata[2, ])

ggplot(df, aes(x = x, y = 0)) +
  geom_point(size = 4, color = "#760b0b") +
  geom_errorbar(
    aes(ymax = z2, ymin = z1),
    color = "#371edd"
  )
# ggplot of the above 10 trials





###
normaldata <- replicate(40,
  rnorm(100, 0, 1),
  simplify = FALSE
)
# Generate 40 trials of 100 samples from the Normal(0,1) distribution

cidata <- sapply(normaldata, cifn)
# Apply cfin() to each trial

TRUEIN <- cidata[1, ] * cidata[2, ] < 0
table(TRUEIN)
# Check how many of the above confidence intervals contain 0

require(ggplot2)
df <- data.frame(x = 1:40, z1 = cidata[1, ], z2 = cidata[2, ])

ggplot(df, aes(x = x, y = 0)) +
  geom_point(size = 1, color = "#760b0b") +
  geom_errorbar(
    aes(ymax = z2, ymin = z1),
    color = "#371edd"
  )
# ggplot of the above 40 trials






###
normaldata <- replicate(100,
  rnorm(100, 0, 1),
  simplify = FALSE
)
# Generate 100 trials of 100 samples from the Normal(0,1) distribution

cidata <- sapply(normaldata, cifn)
# Apply cfin() to each trial

TRUEIN <- cidata[1, ] * cidata[2, ] < 0
table(TRUEIN)
# Check how many of the above confidence intervals contain 0

require(ggplot2)
df <- data.frame(x = 1:100, z1 = cidata[1, ], z2 = cidata[2, ])

ggplot(df, aes(x = x, y = 0)) +
  geom_point(size = 0.5, color = "#760b0b") +
  geom_errorbar(
    aes(ymax = z2, ymin = z1),
    color = "#371edd"
  )
# ggplot of the above 100 trials




###