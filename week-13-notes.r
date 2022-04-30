#############
"R-code notes compilation for  Week 13 April 19th and 21st
Compiled by: Deepta Basak and Bikram Halder, B.Math(hons.) 1st year"
#############

library(tidyverse)
library(viridis)
library(cowplot)

#### Hypothesis Testing Code

prop.test(43, 100)
# Inbuilt R function for z-test


ztestci <- function(x, mu = 0, sigma = 1, alpha = 0.95) {
  z <- qnorm(
    (1 - alpha) / 2,
    lower.tail = FALSE
  ) # P(|Z| >= z)

  sdx <- sigma / sqrt(length(x))

  pvalue <- pnorm(
    (mean(x) - mu) / sdx,
    lower.tail = FALSE
  ) # P(Z >= sqrt(n)(X-mu)/sigma)

  c(mean(x) - z * sdx, mean(x) + z * sdx, pvalue)
  # returns a vector containing
  # 95% confidence interval in the 1st 2 index
  # and pvalue at the 3rd index
}
# Writing custom function for z-test



x <- c(75, 76, 73, 75, 74, 73, 76, 73, 79)
# Data vector
y <- ztestci(x, 76, 1.5)
# Null Hypothesis - H_0: mu = 76
# Alt Hypothesis - H_0: mu > 76
y



t.test(x, mu = 74)
# Inbuilt R function for t-test
# Ex: Try and write out code for t-test

wilcox.test(x, mu = 74, alt = "greater")
# Inbuilt R function for wilcoxon signed rank test


### Chi-squared Test
x <- c(35, 40, 25)
prob <- c(0.38, 0.32, 0.3)
# Null distribution
n <- 100
# Sample size

Chisquare <- sum((x - n * prob)^2 / (n * prob))
# Chisquare statistic follows chisquare with k-1
# degrees of freedom with k = 3

pchisq(Chisquare, df = 2, lower.tail = FALSE)
# p-vaue

df <- data.frame(
  x = c("NDA", "UPA", "3rd"),
  observed = x,
  expected = 100 * prob,
  stringsAsFactors = FALSE
)

plt_obs <- df %>% ggplot() +
  geom_bar(
    mapping = aes(
      x = x, y = observed,
      fill = observed
    ),
    stat = "identity"
  ) +
  theme(legend.position = "none")

plt_exp <- df %>% ggplot() +
  geom_bar(
    mapping = aes(
      x = x, y = expected,
      fill = expected
    ),
    stat = "identity"
  ) +
  theme(legend.position = "none")

plt_diff <- df %>% ggplot() +
  geom_bar(
    mapping = aes(
      x = x, y = observed - expected,
      fill = observed - expected
    ),
    stat = "identity"
  ) +
  theme(legend.position = "none")

plot_grid(plt_exp, plt_obs, plt_diff, nrow = 1)
# Plotting 3 bargraphs for Expected, Observed and Difference of the data





### Contigency Tables
## Bivariate Data is often presented as a two-way table

# For example in Dengue Data from Manipal Hospital
y <- read.table(
  "./dengueb.csv",
  header = TRUE
)

Diagnosis <- y$DIAGNO
Marker <- y$BICARB1

summary(Marker)

# Doctor's needs:
# A patient arrives with Dengue.
# Based on Marker doctor needs to decide on Treatment

z <- replace(Marker, Marker <= 21, 0)
Cat.Marker <- replace(z, 21 < z, 2)
T <- table(Cat.Marker, Diagnosis)
T

# Statistical test performed:
# We collected data of patients : Marker and final diagnosis
chisq.test(T)
# We test if Marker is independent of Diagnosis


prop.test(c(17, 21), c(25, 25), alternative = "less")
# z-test for bivariate data




x <- c(15, 10, 13, 7, 9, 8, 21, 9, 14, 8)
y <- c(15, 14, 12, 8, 14, 7, 16, 10, 15, 12)
t.test(x, y, var.equal = TRUE)
# t-test for bivariate data
