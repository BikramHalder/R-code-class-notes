#############
"R-code notes compilation for  Week 4, February 8th and 10th
Compiled by: Devansh Kamra, B.Math(hons.) 1st year"
#############


# R - Date and time

# R handles date & time in 3 classes
# - as.Date
# - POSIXlt
# - POSIXct
# POSIX - Portable OS interface on UNIX (allow for date & time without timezone)

#  2 packages for date-time manipulation
# - chron (pack)
# - lubricate (pack)



# For handling dates without times as.Date() is the best choice
as.Date("1/15/2001", format = "%m/%d/%Y")
as.Date("April 26, 2001", format = "%B %d, %Y")
as.Date("22JUN01", format = "%d%b%y")

#  Code - Value
#  %d  - day of the month (decimal number)
#  %m  - month (decimal number)
#  %Y  - Year (4 digits)
#  %B  - Month (Full name)
#  %y  - Year (2 digits)
#  %b  - Month (3 letter abbrebiated name)
# We should specify format if input dates are not in standard format


#####
bdays <- c(
    CRRao = as.Date("1920-09-10"),
    PCMahalanobis = as.Date("1893-06-29"),
    Cramer = as.Date("1893-09-25"),
    KRParthasarathy = as.Date("1936-06-25")
)

# weekdays() and months()
# - 2 inbuilt functions in R
# - provide day of the weekand and name of the month respectively

# A vector of weekdays extarcted from the elements bdays
weekdays(bdays)
# A vector of months extarcted from the elements bdays
months(bdays)




##### Computation with dates
# We must specify format of date

datef1 <- as.Date("02/08/2021", format = "%m/%d/%Y")
datef1

datef2 <- as.Date("February 8, 2021", format = "%B %d, %Y")
datef2


###
datef <- as.Date("04/08/2021", format = "%m/%d/%Y")
datef2 <- as.Date("October 8, 2021", format = "%B %d, %Y")

# Subtraction - specifies difference in days
datef1 - datef2

# Built-in function difftime() - specifies the diff in specified units
difftime(datef1, datef2, units = "weeks")
difftime(datef1, datef2, units = "days")
difftime(datef1, datef2)

datef1
datef2

# Add and subract days form dates
datef2 + 10
datef1 - 10



#### Vector of dates
three.days <- as.Date(c("2020-07-22", "2019-04-20", "2022-10-06"))
three.days

# interval differences between dates
diff(three.days)



###
# Produce 7 dates that differ by a week, starting from datef1
Seven <- seq(datef1, length = 7, by = "week")
Seven

# Produce 7 dates that differ by a 14 days, starting from datef1
Seven <- seq(datef1, length = 7, by = 14)
Seven

# Produce 7 dates that differ by a 2 weeks (same as prev one), starting from datef1
Seven <- seq(datef1, length = 7, by = "2 weeks")
Seven



### It is conjunction with a package - stringr --- very useful
# Combine dates & times with string manipulation
?strptime

install.packages("stringr")


# POSIX- Portable OS interface on UNIX (allow for dat & time without timezone)
# chron - (allows for dates & time)
### as.POSIXct()
# - Handles dates and times
# - also takes care of time zones
# - accurate representation of time

Time1 <- as.POSIXct("2023-07-24 23:55:26")
Time1

Time2 <- as.POSIXct("25072023 08:32:07", format = "%d%m%Y %H:%M:%S")
Time2

# Specifying timezone
Time3 <- as.POSIXct("2020-01-01 11:42:03", tz = "GMT")
Time3 <- as.POSIXct("2020-01-01 11:42:03", tz = Sys.timezone())
Time3

# To get timezone of the system
Sys.timezone()

# Operations with times
Time2 > Time1

# Time difference
Time2 - Time1

# adds 30s
Time1 + 30
# subtract 30s
Time1 - 30


##### Use as. to do computations

# Adjust for daylight savings time
as.POSIXct("2021-03-10 08:32:07") - as.POSIXct("2023-03-09 23:55:26")
Sys.time()

# - Internal integer representstion
unclass(Time1)
# - difference from 1970-01-01 00:00:00 UTC
difftime(Time1, as.POSIXct("1970-01-01 00:00:00", tz = "UTC"), units = "secs")


## lt - Local time
## ct - Calender time
Time1.lt <- as.POSIXlt("2022-07-24 23:55:26")
Time1.lt

## These 2 functions are used to strip specific units from date & time
# in column form
unclass(Time1.lt)
# in list form
unlist(Time1.lt)

# getting seconds of Time1.lt
Time1.lt$sec
# getting corresponding weekday number of Time1.lt
Time1.lt$wday

# date & time till the day
trunc(Time1.lt, "days")
# date & time till the minuites
trunc(Time1.lt, "mins")




#### The chron R package
require(chron)

# Creating times in chron

time1.c <- as.chron("2013-07-24 23:55:26")
# Gives time in chron format
time1.c

time2.c <- as.chron("07/25/13", "%m/%d/%Y")
# Gives date in the specified format
time2.c

# Extracting the date with date()
dates(time1.c)

# Operaions with time variable
# logical statement comparing time
time2.c > time1.c

# Adding 10 days
time1.c + 10

# Subtraction of time vaiable
time2.c - time1.c

# Gives difference in the unit specified hours
difftime(time2.c, time1.c, unit = "hours")

# Gives difference in the time
as.chron("2013-03-10 08:32:07") - as.chron("2013-03-09 23:55:26")

# NOTE: Chron does not adjust for the time zones
#####










#####
# The https://www.isibang.ac.in/~athreya/Teaching/ISCD/Master.csv file contains Deceased data from Karnataka COVID-19 Bulletin
decdf <- read.csv(
    file = "https://www.isibang.ac.in/~athreya/Teaching/ISCD/Master.csv",
    header = TRUE
)
head(decdf)
names(decdf) <- c(
    "Sno", "District", "Pid", "Age", "Sex",
    "Description", "Symptoms", "CMB", "DOA",
    "DOD", "MB.Date", "Notes"
)


###### Loading the dplyr R package
library(dplyr)


### filter():
# - Extract rows that meet logical criteria
# - filters data according to the given condition

# Filters data by age greater than 100
filter(decdf, Age > 100)
# Retains only the rows satisfying the given conditions
filter(decdf, Age > 100 & Sex == "Female")


head(decdf$DOA)
head(decdf$MB.Date)

# Drop the NA rows
decdf <- filter(decdf, !is.na(DOD))
# Can't be done with subset()


### mutate()
# - To add new variable without affecting original ones
decdf <- mutate(
    decdf,
    reporting.time = as.Date(decdf$MB.Date) - as.Date(decdf$DOD)
    # Here we have added new variable "reporting.time" to the dataframe
    # Original variables are not affected
)

# Similarly added a new variable "months"
decdf <- mutate(decdf,
    Month = months(as.Date(decdf$MB.Date))
)


### distinct()
# - Removes rows with duplicate values

# Selects distinct rows of Age variable
DT <- distinct(decdf, Age)

# Other variables can be kept with .keep_all = TRUE argument
DT <- distinct(decdf, Age, .keep_all = TRUE)



### slice():  Select rows by position
SL <- slice(decdf, 10:12)
head(SL, 2)



### group_by():
# - To create a "grouped" copy of a table grouped by columns in ... dplyr functions will manipulate each "group" separately and combine the results.

GS <- group_by(decdf, Sex)
# groups data by the specified variable.
head(GS, 3)

# NOTE: Display does NOT show grouping, but it will specify the groups



### summarise():
# - Compute table of summaries
# - Summarises multiple values into a single value

# - Gives the mean of age for each gender.
summarise(GS, mean(Age, na.rm = TRUE))



### sample_n():
# - To select random rows according to the value specified

# Selects 2 random rows from dataframe decdf.
sample_n(decdf, size = 2)

# Selects 0.0001-fraction of rows at random.
sample_frac(decdf, size = 0.0001)



### count():
# - To count the unique values of one or more variables

# Gives a frequency table for months
count(decdf, Month)



### arrange():
# - Order rows by values of a column or columns (low to high)
# - use with desc() to order from high to low

orderdf <- arrange(decdf, Age)
# Creates a new dataframe orderdf having rows arranged by - Age.
head(orderdf, 2)

# Arranges the data in alphabetical order of the variable - Description
orderdf2 <- arrange(decdf, Description)



### The pipe operator - %>%
# - Used to chain codes
# - x %>% f(y) becomes f(x, y)

filteredData <- filter(decdf, Month != "September")
groupedData <- group_by(filteredData, Month)
summarise(groupedData, mean(Age, na.rm = TRUE))

# The same code written shortly with Pipe - %>%
decdf %>%
    filter(Month != 5) %>%
    group_by(Month) %>%
    summarise(mean(Age, na.rm = TRUE))


#####