#############
"R-code notes compilation for  Week 3 February 1st, 3rd
Compiled by: Deepta Basak. B.Math(hons.) 1st year"
#############


# Let's know the data-type of a variable

Course <- "B.Sc."
Number <- 40
Smart <- TRUE
# creating 3 variables

mode(Course)
# mode() gives the output that Course is a character datatype
mode(Number)
# Number has numeric datatype
mode(Smart)
# Smart has logical datatype







KA_D_31_1_22 <- c(
  215, 620, 558, 1109, 8813, 350, 780, 420,
  807, 185, 1993, 515, 1997, 2886, 371, 156,
  589, 1746, 838, 964, 296, 128
)
# Vector containing district wise discharge data of COVID19 patients in Karnataka on 31/01/2022
# c() is used to concatenate/combine individual values to get a vector

KA_D <- c(
  215, 620, 558, 1109, 8813, 350, 780, 420,
  # district wise discharge data of COVID19 patients in Karnataka on 31/01/2022
  144, 478, 816, 242, 1051, 249, 1238, 315,
  807, 185, 1993, 515, 1997, 2886, 371, 156,
  589, 1746, 838, 964, 296, 128
)


## Analyzing the above 2 datasets

KA_D_31_1_22[c(1, 3, 5)]
# selects elements at index 1,3,5 from the vector KA_D_31_1_22

KA_D_31_1_22[-c(1:20)]
# removes the elements having index from 1 to 20 in the vector

KA_D_31_1_22p <- (KA_D_31_1_22) / sum(KA_D_31_1_22) * 100
# vector of percentage of discharge across districts

KA_D_31_1_22p
# shows vectorization of computation


KA_D_31_1_22[KA_D_31_1_22 < 1000]
# using logical operators to select elements of the vector: chooses all elements that return TRUE


sum(KA_D_31_1_22 > 2000)
# converts logical operator to numeric and then adds
# returns the number of elements of the vector that satisfy the condition

max(KA_D_31_1_22)
# returns the maximum of the vector

which(KA_D_31_1_22 == max(KA_D_31_1_22))
# picks the position of the maximum









### More on vectors
# Vector is a collection of objects in the same mode/stored as one variable
# R stores everything as a vector

x <- 3:7
x
# x is a vector containing all positive integers from 3 to 7

s <- seq(1, 100, by = 1) # by is the common difference
s
# seq() is used to create a vector containing all numbers from 1 to 100 at a gap of 1


s100 <- seq(1, 100, by = 0.5)
s100
# creates a vector containing all numbers from 1 to 100 at a gap of 0.5

rep(6, 7)
# repeats the specified element in the first argument(6) as many times as the second argument(7 times)

rep(x, 3)
# the first argument can be a vector also






x <- c(1, 45, 6, 7, NA, 99, 0)
x
# when we collect data, there may be missing values
# missing values are represented by NA

x == NA
# cannot test equality to a missing value

mean(x)
# any computation with a missing value will return a missing value

mean(x, na.rm = TRUE)
# na.rm = TRUE removes all missing values before computing anything

is.na(x)
# tests if a value is missing or not

mean(x[!is.na(x)])
# logical operators ! and is.na is used to calculate the mean of all the non-missing values






x <- c("Siva", "looser", "3", "5")
mode(x)
# numbers have been changed to characters

as.numeric(x[3]) + as.numeric(x[4])
# x[3] +x[4] cannot perform computation
# as.numeric() converts the values to numeric before computing

A <- matrix(seq(3, 5, by = 1 / 10), 7, 3)
A
# vector of entries; number of rows(7) and number of columns(3)
# all entries of a matrix have to be of the same mode
# fills entries column wise from 3 to 5 at a gap of 1/10


B <- matrix(seq(3, 5, by = 1 / 10), ncol = 3)
B
# creates a matrix having 3 columns with entries from 3 to 5 at a gap of 1/10


C <- matrix(seq(3, 5, by = 1 / 10), ncol = 3, byrow = TRUE)
C
# fills entries row wise


A[4, 1]
# selects the element at row=4 and column=1








xd <- c("Siva", "looser", 3, 5)
xd
# all elements of vector/matrix have to be of the same mode
# data frame is like a matrix/ rectangular array
# each column in a data frame can be in a different mode



KA_District <- c(
  "Bagalakote", "Ballari", "Belagavi",
  "Bengaluru Rural", "Bengaluru Urban",
  "Bidar", "Chamarajanagara", "Chikkaballapura",
  "Chikkamagaluru", "Chitradurga",
  "Dakshina Kannada", " Davanagere",
  "Dharwada", "Gadag", "Hassana", "Haveri",
  "Kalaburagi", "Kodagu", "Kolara",
  "Koppala", "Mandya", "Mysuru", "Raichuru",
  "Ramanagara", "Shivamogga", "Tumakuru",
  "Udupi", "Uttara Kannada", "Vijayapura",
  "Yadagiri"
)
# creates a vector with (corresponding) names of districts


KA_Discharge <- data.frame(KA_District, KA_D)
# creates a data frame having variables KA_District and KA_D

class(KA_Discharge)
# specifies as data frame

mode(KA_Discharge)
# specifies the mode as list

sapply(KA_Discharge, mode)
# applies the mode function to each variable/column in the data frame

names(KA_Discharge) <- c("District", "Recovered")
# renames the variables of the data frame

KA_Discharge$Recovered
# displayes the Recovered column of the dataframe KA_Discharge

KA_Discharge[3, 2]
# selects the 3rd entry of the 2nd column

KA_Discharge[3, ]
# displays the entire 3rd row

KA_Discharge[, "Recovered"]
# displays the entire Recovered column




Deaths <- c(
  346, 1712, 975, 903, 16593, 407, 515, 446, 400, 221, 1750, 611,
  1333, 328, 1291, 652, 856, 343, 647, 530, 673, 2494, 346,
  338, 1105, 1172, 509, 793, 500, 206
)
# vector containing the number of deaths


KA_Discharge$Deaths <- Deaths
# creates a variable Deaths in the dataframe KA_Discharge by filling the entries from the vector Deaths

head(KA_Discharge)
# displays the first 6 rows of KA_Discharge



kabulldf <- read.csv(
  file = "https://www.isibang.ac.in/~athreya/Teaching/ISCD/KAbulletin.csv",
  header = TRUE
)
# data extracted from Government of Karntaka  COVID-19 bulletins from
# https://covid19.karnataka.gov.in/govt_bulletin/en
# Make sure to set the correct working directory using set_wd()
# read.csv -> used to read csv files
# file = "..." -> where csv file is located
# header = TRUE -> 1st row fo csv file provides the names of the variables


head(kabulldf)
# reveals that the data frame has 8 variables

mode(kabulldf)
# mode is list

sapply(kabulldf, mode)
# displayes the mode of all the variables

kabulldf[which.max(kabulldf$"Today.s.Positives"), ]
# selects the district that has the max Today's positives

# QUERIES : finds objects that have certain properties
hpkabulldf <- subset(kabulldf, kabulldf$"Today.s.Positives" > 1000)
# subset()
# 2 arguments:
# 1. the data frame, and
# 2. the condition for creating the subset


hpkabulldf <- subset(kabulldf, Today.s.Positives > 1000)
# this also works






IRDkabulldf <- subset(kabulldf,
  select = c("Total.Positives", "Total.Discharges", "Deaths")
)

head(IRDkabulldf)
# IRDkadulldf is a subset of kabulldf having on the specified variables
# data frame created as a subset retains the original column names


okabulldf <- kabulldf[order(kabulldf$Today.s.Positives), ]
head(okabulldf, 4)
# reorders the rows of the dataframe corresponding to the order of the variable Today.s.Positives














### Generating random data in R
# Goal: Generate samples from a given distribution

sample(1:6, 10, replace = T)
# rolling of a fair die
# 1:6 -> the vector to sample from {1,2,3,4,5,6}
# 10 ->  how many samples to generate
# replace = T -> sample with replacement
# probability is not specified, so it is a fair die


sample(c(0, 1), 10, replace = TRUE, prob = c(0.3, 0.7))
# tossing a biased coin 10 times
# chooses 0 with prob 0.3 and 1 with prob 0.7



### Binomial (n,p) distribution
rbinom(10, 6, 0.5)
# Syntax: rbinom(m, size, prob)
# m -> number of samples required
# size -> number of bernoulli trials (n)
# prob -> probability of success (p)

rbinom(1000, 10, 0.5)
hist(rbinom(1000, 10, 0.5))




### Normal distribution
rnorm(1, 10, 5)

### Exponential distribution
rexp(1000, 1)