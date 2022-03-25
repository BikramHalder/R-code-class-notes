#############
"R-code notes compilation for  Week 9 March 22nd and 24th
Compiled by: Bikram Halder, B.Math(hons.) 1st year"
#############


## Analysis of Bivariate Data
# - Covariance
# - Corelaion
# - Method of least squares (linear relation between 2 variables)



## Many Data consists of 2 variables
# One of them - Dependent variable aka Response variable
# other one  - independent variable aka Predictor or Explanatory variable







### Let's analyze the dataset of Maternal smoking vs Infant Health
# Dataset - https://www.stat.berkeley.edu/~statlabs/labs.html#babiesI
# Contains - 1236 infant data
# Varaiables - bwt (birth weight in ounces) & smoke (smoking status of mother)
# (From Stat Labs website )



df <- read.table(
  file = "https://www.stat.berkeley.edu/~statlabs/data/babiesI.data",
  header = TRUE
) # Reading the dataset
head(df)

unique(df$smoke)
### Extrancting unique elements from the smoke variable
## Here,
# 0 - Didn't smoke
# 1 - Smoker
# 9 - Don't know



df$number <- 1:1236
# Assigning an extra varible for the convenience of plotting


## loading... tidyverse for ggplot
library(tidyverse)
library(viridis)


ggplot(data = df) +
  geom_point(
    aes(
      x = number,
      y = bwt,
      colour = as.factor(smoke)
    )
  ) +
  scale_colour_viridis_d(option = "plasma")
# Scatter plot of bwt
# where, legend - smoke as factor




ggplot(
  data = df,
  aes(x = bwt, fill = as.factor(smoke))
) +
  geom_histogram(colour = "white") +
  scale_fill_viridis_d()
# Histogram of bwt
# filled - smoke as factor



## Exercise for both the 2 plots above.
# - Change axis labels
# - Add title
# - Change legend






ggplot(
  data = df,
  aes(x = bwt, fill = as.factor(smoke))
) +
  geom_histogram(colour = "white") +
  scale_fill_viridis_d() +
  facet_wrap(
    ~ as.factor(smoke),
    nrow = 1
  )
# Splitting the histogram with facet_wrap() w.r.t. smoke variable

## Exercise:
# - Plot histogram proportions
# - Change axis labels
# - Add title
# - Change legend






df %>%
  ggplot(aes(
    x = as.factor(smoke),
    y = bwt,
    fill = as.factor(smoke)
  )) +
  geom_boxplot() +
  scale_fill_viridis_d()
# Box-plot
# So, Mean bwt (didn't smoke) > Mean bwt (smoker) ?





df %>%
  ggplot(aes(
    x = as.factor(smoke),
    y = bwt,
    fill = as.factor(smoke)
  )) +
  geom_boxplot() +
  scale_fill_viridis(discrete = TRUE, alpha = 0.6) +
  geom_jitter(color = "black", size = 0.2, alpha = 0.9) +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 11)
  ) +
  ggtitle("Boxplot with Data as jitter") +
  xlab("")

# Box-plot with data

## To analyze it's data further
# - Frame an hypothesis
# - Execute & test on data


## Further Ref:
# Book - Stat Labs: Mathematical Statistics Through Applications by Deborah Nolan and Terry P. Speed
# Stat labs website - https://www.stat.berkeley.edu/users/statlabs/







## loading UsingR for fat dataset
library(UsingR)

?fat
# Info about fat dataset

names(fat)
# Variables


# Let's analyze the relation between neck and wrist

# Comparing averages in 2 ways
z <- mean(fat$neck) / mean(fat$wrist)
z

y <- mean(fat$neck / fat$wrist)
y



plt1 <- fat %>%
  ggplot(
    aes(x = wrist, y = neck)
  ) +
  geom_point() +
  geom_smooth(method = "lm")

plt1
# plotting neck vs wrist in ggplot
# method = 'lm' yields a linear regression layer
## Relationship seems linear



plt2 <- fat %>%
  filter(20 <= age & age < 30) %>%
  ggplot(
    aes(x = wrist, y = neck)
  ) +
  geom_point() +
  geom_smooth(method = "lm")


# loading library cowplot
# for the function plot_grid() - used to present multiple plot in a frame
library(cowplot)

plot_grid(plt1, plt2, ncol = 2)
# The variables seem related and also by a linear relationship.




# Let's understand Covariance and Correlation with data

fat %>%
  ggplot(
    aes(
      x = wrist, y = neck,
      col = rgb(.35, 0, 0)
    )
  ) +
  theme(legend.position = "none") +
  geom_point() +
  geom_vline(xintercept = mean(fat$wrist)) +
  geom_hline(yintercept = mean(fat$neck))

# Observe: most of the datapoints are in 1st and 3rd quadrant


# Let's slice and plot it again
fat %>%
  slice(100:175) %>%
  ggplot(
    aes(
      x = wrist, y = neck,
      col = rgb(.35, 0, 0)
    )
  ) +
  theme(legend.position = "none") +
  geom_point() +
  geom_vline(xintercept = mean(fat$wrist[100:175])) +
  geom_hline(yintercept = mean(fat$neck[100:175]))

# Here also most of the datapoints lie 1st and 3rd quadrant



# Plotting relationship between age and ankle with sliced data
fat %>%
  slice(100:175) %>%
  ggplot(
    aes(
      x = ankle, y = age,
      col = rgb(.35, 0, 0)
    )
  ) +
  theme(legend.position = "none") +
  geom_point() +
  geom_vline(xintercept = mean(fat$ankle[100:175])) +
  geom_hline(yintercept = mean(fat$age[100:175]))

# Nope! most of the datapoints are not in 1st and 3rd quadrants
# Thus, no linear relationship






### Covariance
# - measurement of the difference between the two variables in the four regions.

### Correlation
# - Covariance in standardised scale



cor(fat$wrist, fat$neck)
# Correlation between wrist and neck variabele in fat dataset

cor(fat$wrist, fat$height)
# Correlation between wrist and height variabele in fat dataset

cor(fat$age, fat$ankle)
# Correlation between age and ankle variabele in fat dataset



# loading MASS to load the dataset Animals
library(MASS)

# Is it true that animals with larger bodies have larger brains?

# Method 1: plot brain vs body variable
Animals %>%
  ggplot(
    aes(x = brain, y = body)
  ) +
  geom_point()



# Method 2: Computing Correlation between brain and body
cor(Animals$body, Animals$brain)



# Method 3:
# - Assign rank and transform the dataset
# - Compute correlation

cor(rank(Animals$body), rank(Animals$brain))

cor(Animals$body, Animals$brain, method = "spearman")

# AKA spearman correlation coefficient
# i.e., measurement of relationship of monotonic data










# Simple linear regrassion model of wrist vs neck (fat dataset)
fat %>%
  ggplot(
    aes(
      x = wrist, y = neck,
      col = rgb(0, 0, 0.6)
    )
  ) +
  theme(legend.position = "none") +
  geom_point() +
  geom_smooth(
    method = "lm",
    aes(col = rgb(0.4, 0, 0)),
    se = FALSE
  ) +
  geom_vline(xintercept = mean(fat$wrist)) +
  geom_hline(yintercept = mean(fat$neck))



###