#############
"R-code notes compilation for  Week 13 April 26th & 28th
Compiled by: Bikram Halder, B.Math(hons.) 1st year"
#############


# libraries
library(tidyverse)
library(viridis)
library(hrbrthemes)

### Testing wheather an Athlete is a Smoker or Non-Smoker

# Sample
data <- data.frame(
  "Non-Smoker" = c(7, 0),
  "Smoker" = c(2, 5),
  row.names = c("Athlete", "Non-Athlete"),
  stringsAsFactors = FALSE
)
data

# H_0: Variables are indep or there is no relationship between variables
# H_A: Variables are dep or there is relationship between variables

# chisq test for indep
chisq.test(data)

# Non-parametric Fisher's exact test
fisher.test(data)



# Tea vs Milk
dataTM <- data.frame(
  "Tea First" = c(3, 1),
  "Milk First" = c(1, 3),
  row.names = c("Tea", "Milk"),
  stringsAsFactors = FALSE
)
dataTM


# chisq test for indep
chisq.test(dataTM)

# Non-para,etric Fisher's exact test
fisher.test(dataTM)



### Online vs Offline Education

# H_0: No difference between online & offline
# H_A: offline has improved exchange of ideas

# Sample 8 pairs of identical twins of B. Math(Hons.)
# For each pair one is offline and other one is online
# Do some communication test at the end of semester
offline <- c(82, 69, 73, 43, 58, 56, 76, 65)
online <- c(63, 42, 74, 37, 51, 43, 80, 62)

response <- offline - online
response

# Ranking the data
rank(abs(response))

# Sum of the ranks of the +ve terms is given as
Wp <- 7 + 8 + 4 + 5 + 6 + 2

# sign rank -> computes the distribution of  Wilcoxon Signed rank Statistic
dsignrank(32, 8)
pval <- 1 - psignrank(32, 8)
pval

# At 0.05 we will reject the null hypothesis





### Bootstrap for the Gamma distribution

set.seed(10)

n <- 20
a <- .20

my.samp <- rgamma(n, shape = a, rate = 1)
# 20 samples of gamma distribution with shape 0.2 and rate 1

barx <- mean(my.samp)
B <- 1e3
# number of bootstrap samples. 1e3 is standard.

boot.np <- numeric(length = B)
boot.p <- numeric(length = B)


for (b in 1:B) {
  boot.samp.np <- sample(my.samp, replace = TRUE)
  # Non-parametric Bootstrap samples
  boot.np[b] <- mean(boot.samp.np)
  # Non-parametric Bootstrap estimator

  boot.samp.p <- rgamma(n, shape = barx, rate = 1)
  # Parametric bootstrap samples
  boot.p[b] <- mean(boot.samp.p)
  # Parametric bootstrap estimator
}


## 95% Bootstrap confidence interval

quantile(boot.np, probs = c(.025, .975))
# non-parameteric

quantile(boot.p, probs = c(.025, .975))
# parametric


## 95% asymptotic CI
c(barx - qnorm(.975) * sqrt(barx / n), barx + qnorm(.975) * sqrt(barx / n))

# Simulate repeated estimates to construct a 95% CI
true.samp <- numeric(length = 1e4)

for (i in 1:1e4) {
  samp <- rgamma(n, shape = a, rate = 1)
  true.samp[i] <- mean(samp)
}

quantile(true.samp, probs = c(.025, .975))
# getting sample quantiles of true.samp

df <- data.frame(
  "Non-parametric" = boot.np,
  "Parametric" = boot.p,
  "Approximate normal" = rnorm(
    1e4,
    mean = barx,
    sd = sqrt(barx / n)
  ),
  "Truth" = true.samp
)

df <- df %>%
  gather(key = "Samples", value = "value") %>%
  mutate(text = gsub("\\.", " ", Samples)) %>%
  mutate(value = value)

# Plotting
plt_1 <- df %>% ggplot(
  mapping = aes(x = value, color = Samples, fill = Samples)
) +
  geom_density(
    alpha = 0.6,
    size = 1.2
  ) +
  scale_fill_viridis(discrete = TRUE) +
  scale_color_viridis(discrete = TRUE) +
  xlim(0, 1.5) +
  labs(
    x = "Data", y = "Densities",
    title = "Comparing sampling densities"
  ) +
  theme_ipsum() +
  theme(
    legend.justification = c("right", "top")
  )


plt_1





### Repeating the same process with n = 1000

n <- 1000
a <- .20

my.samp <- rgamma(n, shape = a, rate = 1)
# 20 samples of gamma distribution with shape 0.2 and rate 1

barx <- mean(my.samp)
B <- 1e3
# number of bootstrap samples. 1e3 is standard.

boot.np <- numeric(length = B)
boot.p <- numeric(length = B)


for (b in 1:B) {
  boot.samp.np <- sample(my.samp, replace = TRUE)
  # Non-parametric Bootstrap samples
  boot.np[b] <- mean(boot.samp.np)
  # Non-parametric Bootstrap estimator

  boot.samp.p <- rgamma(n, shape = barx, rate = 1)
  # Parametric bootstrap samples
  boot.p[b] <- mean(boot.samp.p)
  # Parametric bootstrap estimator
}


## 95% Bootstrap confidence interval

quantile(boot.np, probs = c(.025, .975))
# non-parameteric

quantile(boot.p, probs = c(.025, .975))
# parametric


## 95% asymptotic CI
c(barx - qnorm(.975) * sqrt(barx / n), barx + qnorm(.975) * sqrt(barx / n))

# Simulate repeated estimates to construct a 95% CI
true.samp <- numeric(length = 1e4)

for (i in 1:1e4) {
  samp <- rgamma(n, shape = a, rate = 1)
  true.samp[i] <- mean(samp)
}

quantile(true.samp, probs = c(.025, .975))
# getting sample quantiles of true.samp


df <- data.frame(
  "Non-parametric" = boot.np,
  "Parametric" = boot.p,
  "Approximate normal" = rnorm(
    1e4,
    mean = barx,
    sd = sqrt(barx / n)
  ),
  "Truth" = true.samp
)

df <- df %>%
  gather(key = "Samples", value = "value") %>%
  mutate(text = gsub("\\.", " ", Samples)) %>%
  mutate(value = value)



# Plotting
plt_2 <- df %>% ggplot(
  mapping = aes(x = value, color = Samples, fill = Samples)
) +
  geom_density(
    alpha = 0.6,
    size = 1.2
  ) +
  scale_fill_viridis(discrete = TRUE) +
  scale_color_viridis(discrete = TRUE) +
  xlim(0, 1.5) +
  labs(
    x = "Data", y = "Densities",
    title = "Comparing sampling densities"
  ) +
  theme_ipsum() +
  theme(
    legend.justification = c("right", "top")
  )


plt_2