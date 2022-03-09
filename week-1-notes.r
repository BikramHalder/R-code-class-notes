#############
"R-code notes compilation for  Week 1 January 20th, 20th
Compiled by: Deepta Basak. B.Math(hons.) 1st year"
#############


### Basic computation with R

9 / 44
0.6 * 0.4 + 0.3 * 0.6
log(0.6 * 0.4 + 0.3 * 0.6)
# Above are basic operations in
# / division, * multiplcation, + addition, - subtraction

# Note:
# '[1]' at the beginning of each answer represents the position of that element in the vector



Scores <- c(40, 39, 15, 6, 18, 22, 30, 21, 15, 23)
# In the above command,
# we have assigned values to the variable 'Scores' using the assignment operator '='
# we have used the c-function which catenates the numbers into column vector

Scores
# to display the values, we have to call the variable, as shown above

meancomputation <- (40 + 39 + 15 + 6 + 18 + 22 + 30 + 21 + 15 + 23) / 10
# write our own code to compute mean
# calculates the mean of the values in Scores
meancomputation
# display output
meaninbuilt <- mean(Scores)
# use inbuilt function in R that computes mean of variable.
meaninbuilt
# display output




Scores
Scores2 <- Scores
# create a copy of Scores
Scores2[4] <- 16
Scores2
Scores[c(1, 3, 5)]
# slicing: we collect only positions 1,3,5 in Scores
Scores
y <- which(Scores == 30)
# selects which students Scores are equal to 30
y
z <- which(Scores <= 20)
# selects which students Scores are less than or equal to 20
z
x <- 1:100
x
#' a:b' creates a sequence from a to b distanced by 1
x[x < 10 | x > 90]
# Slicing: using a logical operator | OR.
# Chooses elements from x which are less than 10 and bigger than 90


data()
# lists currently installed data sets






### Let's check airquality dataset

?airquality
airquality
# prints the entire dataset on the screen
head(airquality)
# provides the first 6 rows
tail(airquality)
# provides the last 6 rows
head(airquality, n = 10)
# provides the first 10 rows
airquality[148, 4]
# data can be called using row and column number
airquality$Temp[148]
# we can use the variable name for the given column and call it by its position
airquality[148, ]
# provides the enitre 148th row
airquality[, c(1, 4)]
# provides the 'Ozone' and 'Temp' columns
# using c() function,
# we can form any vector and that will enable display of the respective columns
# we didn't specify the rows, so, all the rows will be displayed

summary(airquality$Temp)
# provides six number summary:
# Min, 1st quartile, Median, Mean, 3rd quartile., Max






### Data Visualization

hist(airquality$Temp)
# histogram on the variable Temp of airquality
plot(airquality$Temp)
# plot() function to plot the Temp variable
plot(airquality$Ozone, airquality$Temp)
# plot() function gives a scatter plot of Ozone vs Temp
plot(airquality)
# gives all possible plots for the dataframe airquality






### Let's install and load some R packages 

install.packages("UsingR")
# installing the package UsingR that has many datasets loaded in it
library("UsingR")
# once installed, it can be added to the workspace using the library() command

install.packages("tidyverse")
library("tidyverse")
mpg
# observations collected by US Environment Protection Agency on 38 models of cars







# ggplot

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
# ggplot() -> creates a coordinate system that you can add layers to
# data=mpg -> tells us the data set to be used
# geom_point() -> adds a layer of points to the plot
# each geom function takes a mapping argument that is always paired with aes()


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# added a 3rd variable called class to a 2-d scatter plot by mapping it to the color aesthetic


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
  scale_color_viridis_d()
# using color palette from viridis package (color blind colors)


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
  scale_color_viridis_d(option = "plasma")
# using the plasma option under the viridis package


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 2)
# facet_wrap():
# Splits the plot into subplots that each display one subset of the data, with respect to a variable


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
  scale_color_viridis_d(option = "plasma") +
  facet_wrap(~class, nrow = 2)
# facets and viridis


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
  scale_color_viridis_d(option = "plasma") +
  facet_grid(drv ~ cyl)
# facet_grid splits the plot by a combination of two variables into subplots that each display one subset of the data


