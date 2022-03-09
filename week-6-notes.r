#############
"R-code notes compilation for  Week 4, February 8th and 10th
Compiled by: Prognadipto Majumder, B.Math(hons.) 1st year"
#############



runningmean <- function(x, N) {
  y <- sample(x, N, replace = TRUE)
  # THIS samples N points wih replacement
  c <- cumsum(y)
  # cumulative sums of the 1st i values in i th position
  n <- 1:N
  c / n
  # Division is vectorised, mean of 1st i values of y is in ith position
}


u <- runningmean(c(0, 1), 1000)
# Simulating 1000 trials of Ber(1/2)
# the 1000 bernoulli-1/2 variables being X1,X2...X1000,
# The function returns the mean of the first i R.V.'s in the i th place.
# that is ,
# u[i]=(X1+X2+...+Xi)/i





# We "guess" the value of u[i] will converge to 1/2 as
# i gets really large. (It should converge with probability 1)


#######
x <- 1:1000
plot(u ~ x, type = "l")
# PLOTS line graph in base R code
#####



x <- 1:1000
plot(u ~ x, type = "l")
replicate(10, lines(
  runningmean(c(0, 1), 1000) ~ x,
  type = "l",
  col = rgb(runif(3), runif(3), runif(3))
))

# this prints 10 line graphs in the same plot by replicate command that makes
# 10 function calls. For each call, we RANDOMLY assign a colour to graph.




#####
par(mfrow = c(1, 3))
# par() is used to set graphical entry parameters.
# mfrow=c(1,3) is the command that ensures all subsequent figures will be
# drawn in a 1by 3 array on the device  BY COLUMNS.


u <- runningmean(c(0, 1), 100)
x <- 1:100

plot(u ~ x, type = "l")

replicate(
  10,
  lines(
    runningmean(c(0, 1), 100) ~ x,
    type = "l",
    col = rgb(runif(3), runif(3), runif(3))
  )
)





u <- runningmean(c(0, 1), 1000)
x <- 1:1000

plot(u ~ x, type = "l")

replicate(10, lines(
  runningmean(c(0, 1), 1000) ~ x,
  type = "l",
  col = rgb(runif(3), runif(3), runif(3))
))





u <- runningmean(c(0, 1), 10000)
x <- 1:10000

plot(u ~ x, type = "l")

replicate(10, lines(
  runningmean(c(0, 1), 10000) ~ x,
  type = "l",
  col = rgb(runif(3), runif(3), runif(3))
))



####

# As the number of trials increases , we can see that
# the variation of the mean of the random variables from 1/2 decreases rapidly