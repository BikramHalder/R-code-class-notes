#############
"R-code notes compilation for  Week 5, February 15th
Compiled by: Bikram Halder, B.Math(hons.) 1st year"
############# @BikramHalder

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

# -> Packages - tidyverse- dplyr, tidyr, forcats, readr
# help in dealing with factors.





# factor(x)
# - Store as vector  of integers
# - Displayed as characters



# xn - numeric data as factors
xn <- c(1, 2, 2, 3, 1, 2, 3, 3, 1, 2, 3, 3, 1)
# Create a vector of data
factorxn <- factor(xn)
# Store it as a factor using factor()
factorxn


# Factors in R are stored as a vector of integers but they correspond to a string for display.
# Levels:
# - unique set of values taken by as.character()
# - assigned by default are those given by as.character(x)
# factor levels are always characters



# Both numeric and character data can be stored as factors
mean(xn)
# But, factor levels are always characters
mean(factorxn)
# Since, argument is not numeric, so will return NA

# use levels() function to convert them to original numeric value
mean(as.numeric(levels(factorxn)[factorxn]))


# xc - character data as factors
xc <- c(
    "June", "July", "August", "September",
    "August", "July", "July", "August"
)
factorxc <- factor(xc)
factorxc




#####
table(factorxc)
# table() gives frequency of each level

# ordering is w.r.t. to as.characterc(.) and not related to order in the vector
months <- factor(xc,
    levels = c(
        "Garbage", "January", "February",
        "March", "April", "May", "June", "July", "August",
        "September", "October", "November", "December"
    ),
    ordered = TRUE
)
# we can specify the levels with order needed
months
# Here, levels contain elements not present in months
months[3] < months[4]

# When factor is created, all it's levels are stored with the factor
table(months)
# - Display ALL the levels specified and respective counts
# - occur when subsetting a factor

factor(months)
# retains only the levels present without affecting the ordering
table(factor(months))
# Gives the count of ONLY the levels present in the factor



#####
x <- round(1000 * runif(10))
x

# cut() function is used to convert a numeric variable into a factor
# Syntax: cut(numeric data, breaks)
xfactor <- cut(x, 4)
# breaks
# - arbitary by default
# - specifies how range of numbers will be converted to factor values
xfactor


cut(x, 3, labels = c("L", "M", "H"))
# label() - used to specify the levels of the factors

# Nicer set of labels with pretty()
xpfactor <- cut(x, pretty(x, 4))
xpfactor
# but may not provide more levels than specified
table(xpfactor)

# Produce factors based on percentiles of your data
xqfactor <- cut(x, quantile(x, probs = seq(0, 1, 0.25)))
table(xqfactor)
# obsevations are distributed "equally" in each level




##### Create factors from dates/times
everyday <- seq(
    from = as.Date("2021-1-1"),
    to = as.Date("2021-12-31"),
    by = "day"
)

# strptime(), strftime() with factors and levels would be very useful for extracting information with ordering from a scraped dataset

# format() : can be used to extract month using "%b"
cmonth <- format(everyday, "%b")
head(cmonth, 3)

# Extract month from each day
df <- as.data.frame(table(cmonth))
# table()
# - tabulates values in each month
# - ordering in alphabetcal
names(df) <- c("Month", "Freq")
df

# unique(): returns the unique values in the order that are encountered
months <- factor(cmonth,
    levels = unique(cmonth), ordered = TRUE
)
# stored months as factors
df2 <- as.data.frame(table(months))
names(df2) <- c("Month", "Freq")
# specified levels & ordering using the unique()
df2



## vector of all Dates of the year 2021
everyday <- seq(
    from = as.Date("2021-1-1"), to = as.Date("2021-12-31"),
    by = "day"
)

wks <- cut(everyday, breaks = "week")
# levels - 53 dates of each week of the year 2021
wks

qtrs <- cut(everyday, "3 months",
    labels = paste("Q", 1:4, sep = "")
)
# levels - 4 quarters of the year 2021
qtrs







###
# The https://www.isibang.ac.in/~athreya/Teaching/ISCD/Master.csv file contains Deceased data from Karnataka COVID-19 Bulletin
decdf <- read.csv(
    file = "https://www.isibang.ac.in/~athreya/Teaching/ISCD/Master.csv",
    header = TRUE
)
# Use months() to extract months of reporting date
decdf$Month <- months(as.Date(decdf$MB.Date))
# Use table() to compute reported cases across months
data <- as.data.frame(table(decdf$Month))
names(data) <- c("name", "val")
data

# Loading tidyverse package
library(tidyverse)
# Note:
# - ggplot uses ordering alphabetically
# - treats Month as factor and default level ordering
ggplot(data = data, aes(x = name, y = val, fill = name)) +
    geom_bar(stat = "identity", alpha = .6, width = .4) +
    coord_flip() +
    scale_fill_viridis_d() +
    xlab("") +
    theme_bw()



####
# Same code as before - some correction but failed to get required result
decdf <- read.csv(
    file = "https://www.isibang.ac.in/~athreya/Teaching/ISCD/Master.csv",
    header = TRUE
)
decdf$Month <- months(as.Date(decdf$MB.Date))
data <- as.data.frame(table(decdf$Month))
names(data) <- c("name", "val")

data <- arrange(data, val)
# Note:
# ggplot() takes into account ordering from the factor given by its levels
# & NOT as we see in the data-frame
# Inspite of arranging our dataframe, the plot is still the same as before
library(tidyverse)
ggplot(data = data, aes(x = name, y = val, fill = name)) +
    geom_bar(stat = "identity", alpha = .6, width = .4) +
    scale_fill_viridis_d() +
    coord_flip() +
    xlab("") +
    theme_bw()



######
# Same code as before - some correction to get required result
library(tidyverse)
decdf <- read.csv(file = "../Master.csv", header = TRUE)
decdf$Month <- months(as.Date(decdf$MB.Date))
data <- as.data.frame(table(decdf$Month))
names(data) <- c("name", "val")
data <- arrange(data, val)

# Reorder the levels according to the values
data$name <- factor(data$name, levels = data$name)

# ggplot() obliges the order now
ggplot(data = data, aes(x = name, y = val, fill = name)) +
    geom_bar(stat = "identity", alpha = .6, width = .4) +
    coord_flip() +
    scale_fill_viridis_d() +
    xlab("") +
    theme_bw()



######
# With dplyr(R package): Order months according to reported deaths
# With forcats(R package): fct_infreq
decdf <- read.csv(
    file = "https://www.isibang.ac.in/~athreya/Teaching/ISCD/Master.csv",
    header = TRUE
)
decdf$Month <- months(as.Date(decdf$MB.Date))

library(tidyverse)
ggplot(
    data = decdf,
    aes(
        x = fct_infreq(Month),
        fill = cut(Age.In.Years, pretty(Age.In.Years, 4))
    )
) +
    geom_bar(stat = "count", alpha = .6, width = .4) +
    scale_fill_viridis_d() +
    xlab("") +
    coord_flip() +
    theme_bw()

###
library(dplyr)
library(forcats)
# Same plot using dplyr, forcats package and more style
ggplot(
    decdf,
    aes(
        x = fct_infreq(Month),
        fill = cut(Age.In.Years, pretty(Age.In.Years, 4)) # cut() is used to add Age.In.Years bin layer
    )
) +
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
        ),
        axis.title.x = element_text(
            color = "#e95462",
            size = 14, vjust = 0.5, face = "bold"
        ),
        axis.title.y = element_text(
            color = "#e95462",
            size = 14, face = "bold"
        )
    )

## Viridis hexcode https://waldyrious.net/viridis-palette-generator/