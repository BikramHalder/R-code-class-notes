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
# Varaiables - bwt (birth weight in ounces) & smoke
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







#