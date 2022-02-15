#############
"R-code notes compilation for  Week 1 January 20th, 20th
Compiled by: Bikram Halder, B.Math(hons.) 1st year"
############# @BikramHalder


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


####
bdays <- c(
  CRRao = as.Date("1920-09-10"),
  PCMahalanobis = as.Date("1893-06-29"),
  Cramer = as.Date("1893-09-25"),
  KRParthasarathy = as.Date("1936-06-25")
)
# returns weekdays and bdays resp.
weekdays(bdays)
months(bdays)




###
datef1 <- as.Date("02/08/2021", format = "%m/%d/%Y")
datef1

datef2 <- as.Date("February 8, 2021", format = "%B %d, %Y")
datef2



###
datef <- as.Date("04/08/2021", format = "%m/%d/%Y")
datef2 <- as.Date("October 8, 2021", format = "%B %d, %Y")

datef1 - datef2
# specifies the diff in days
difftime(datef1, datef2, units = "weeks")
difftime(datef1, datef2, units = "days")
difftime(datef1, datef2)

datef1
datef2

# Add-sub days
datef2 + 10
datef1 - 10




#### Vector of dates
three.days <- as.Date(c("2020-07-22", "2019-04-20", "2022-10-06"))
three.days

# diff between dates
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



### It is conjunction with a package - stringr ---- very useful
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


###
Time3 <- as.POSIXct("2020-01-01 11:42:03", tz = Sys.timezone())
Time3

Sys.timezone()

# Operations with times
Time2 > Time1

Time2 - Time1
Time1 + 30
Time1 - 30


##
as.POSIXct("2021-03-10 08:32:07") - as.POSIXct("2023-03-09 23:55:26")
Sys.time()

unclass(Time1)
difftime(Time1, as.POSIXct("1970-01-01 00:00:00", tz = "UTC"), units = "secs")


## lt - Local time
## ct - Calender time
Time1.lt <- as.POSIXlt("2022-07-24 23:55:26")
Time1.lt
##
unclass(Time1.lt)
unlist(Time1.lt)
##
Time1.lt$sec
Time1.lt$wday
trunc(Time1.lt, "days")
trunc(Time1.lt, "mins")