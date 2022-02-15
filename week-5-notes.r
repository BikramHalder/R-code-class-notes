####
"R-code notes compilation for  Week 1 January 20th, 20th
Compiled by: Bikram Halder, B.Math(hons.) 1st year"
####

# R categorical data
# Factors and Levels
# - used to plot categorical data in R

# See the following packages in the book - R for Data Science
# - dplyr (https://r4ds.had.co.nz/transform.html#dplyr-basics)
# - forcats (https://r4ds.had.co.nz/factors.html#prerequisites-9)


# Keys: How base-R handles categorical data or variables?


# Categorical Variables - Qualitative variables
# ,i.e., those which cannot meaningfully be expressed in numbers.
# Eg.: Clothes, Colour.
# -> Base-R deals with them through the use of factors.
# -> factors are useful in Statistical Modeling and Plotting data.
# -> Packages - tidyverse, dplyr, tidyr, forcats, readr  help in dealing with factors.






# Store as vector  of integers
# displayed as char
# Levels : assigned by default all those given by as.character(x)
#  factor levels are always characters



xn <- c(1, 2, 2, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1)
factorxn <- factor(xn) # numeric data as factors
factorxn

mean(xn)
mean(factorxn)
mean(as.numeric(levels(factorxn)[factorxn]))
# Ordering is w.r.t. as.character(.) & not related to order in maths

###
xc <- c(
  "June", "July", "August", "September",
  "August", "July", "July", "August"
)

factorxc <- factor(xc) # char data
factorxc






###
table(factorxc)
months <- factor(xc,
  levels = c(
    "Garbage", "January", "February",
    "March", "April", "May", "June", "July", "August",
    "September", "October", "November", "December"
  ),
  ordered = TRUE
)
# Specify levels needed
# orders can be spscified
months

months[3] < months[4]

table(months)
# When factor is creates, all it's levels are stored with the factor
# Display ALL the levels specified and counts
table(factor(months))
factor(months)
# retains only he levels present
# maintains the ordering




##
everyday <- seq(
  from = as.Date("2021-1-1"), to = as.Date("2021-12-31"),
  by = "day"
)
cmonth <- format(everyday, "%b")
head(cmonth, 3)
df <- as.data.frame(table(cmonth))
names(df) <- c("Month", "Freq")
df
##
everyday <- seq(
  from = as.Date("2021-1-1"), to = as.Date("2021-12-31"),
  by = "day"
)
wks <- cut(everyday, breaks = "week")
# cut() - used to convert a numeric variable into a factor
# cut(numeric data, breaks)
# breaks are arbitary by default
# Ex -
qtrs <- cut(everyday, "3 months", labels = paste("Q", 1:4, sep = ""))





#### Combining factors--
a.fac <- factor(c("X", "Y", "Z", "X"))
b.fac <- factor(c("X", "X", "Y", "Y", "Z"))
a.fac
b.fac
c(a.fac, b.fac)
factor(c(levels(a.fac)[a.fac], levels(b.fac)[b.fac]))
levels(a.fac)[a.fac]
factor(c(as.character(a.fac), as.character(b.fac)))
l1 <- factor(sample(letters, size = 10, replace = TRUE))
l2 <- factor(sample(letters, size = 10, replace = TRUE))
l1
l2
cl12 <- c(l1, l2)
cl12
l12
###
cmonth <- format(everyday, "%b")
months <- factor(cmonth, levels = unique(cmonth), ordered = TRUE)
head(months, 3)
df2 <- as.data.frame(table(months))
names(df2) <- c("Month", "Freq")
df2
###
decdf <- read.csv(file = "./Master.csv", header = TRUE)
decdf$Month <- months(as.Date(decdf$MB.Date))
data <- as.data.frame(table(decdf$Month))
names(data) <- c("name", "val")
data
library(tidyverse)
ggplot(data = data, aes(x = name, y = val, fill = name)) +
  geom_bar(stat = "identity", alpha = .6, width = .4) +
  coord_flip() +
  scale_fill_viridis_d() +
  xlab("") +
  theme_bw()
####
decdf <- read.csv(file = "../Master.csv", header = TRUE)
decdf$Month <- months(as.Date(decdf$MB.Date))
data <- as.data.frame(table(decdf$Month))
names(data) <- c("name", "val")
library(tidyverse)
data <- arrange(data, val)
ggplot(data = data, aes(x = name, y = val, fill = name)) +
  geom_bar(stat = "identity", alpha = .6, width = .4) +
  scale_fill_viridis_d() +
  coord_flip() +
  xlab("") +
  theme_bw()
######
library(tidyverse)
decdf <- read.csv(file = "../Master.csv", header = TRUE)
decdf$Month <- months(as.Date(decdf$MB.Date))
data <- as.data.frame(table(decdf$Month))
names(data) <- c("name", "val")
data <- arrange(data, val)
data$name <- factor(data$name, levels = data$name)
ggplot(data = data, aes(x = name, y = val, fill = name)) +
  geom_bar(stat = "identity", alpha = .6, width = .4) +
  coord_flip() +
  scale_fill_viridis_d() +
  xlab("") +
  theme_bw()
######
decdf <- read.csv(file = "../Master.csv", header = TRUE)
decdf$Month <- months(as.Date(decdf$MB.Date))
library(tidyverse)
ggplot(decdf, aes(x = fct_infreq(Month), fill = cut(Age.In.Years, pretty(Age.In.Years, 4)))) +
  geom_bar(stat = "count", alpha = .6, width = .4) +
  scale_fill_viridis_d() +
  xlab("") +
  coord_flip() +
  theme_bw()
## using dplyr
ggplot(decdf, aes(x = fct_infreq(Month), fill = cut(Age, pretty(Age, 4)))) +
  labs(fill = "Age") +
  geom_bar(stat = "count", width = .4) +
  scale_fill_viridis_d() +
  coord_flip() +
  theme_bw() +
  ggtitle("Deceased Month Count- Age Stacked") +
  ylab("Count of Deceased") +
  xlab("Month") +
  theme_bw() +
  theme(
    plot.title = element_text(
      color = "#e95462",
      size = 14,
      face = "bold",
      hjust = 0.5
    )
  ) +
  theme(
    axis.title.x = element_text(color = "#e95462", 
    size = 14, vjust = 0.5, face = "bold"),
    axis.title.y = element_text(
      color = "#e95462",
      size = 14, face = "bold"
    )
  )

## Viridis hexcode https://waldyrious.net/viridis-palette-generator/