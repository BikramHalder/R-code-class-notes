#############
"R-code notes compilation for  Week 2 January 25th, 27th
Compiled by: Deepta Basak. B.Math(hons.) 1st year"
#############

# Data visualization using ggplot


install.packages("tidyverse")
library("tidyverse")


mpg
# fuel economy data from 1999-2008 of popular model of cars


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
# scatter plot -> one variable against another (numeric)
# displ -> engine displacement in litres
# hwy -> highway miles per gallon
# The above plot shows negative relationship between Engine Size and Fuel Efficiency



df <- mpg[c("displ", "hwy", "class")]
# creating a dataset df containing only the variables displ, hwy and class from the dataset mpg

head(df)
# a tibble: 6x3




ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))
# Added a 3rd variable called class to a 2-d plot by mapping it to an aesthetic
# aes() -> associates the names of the aesthetics with the names of the variables


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), colour = "blue")
# Setting color = "blue" colors all of the points blue


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
# The alpha aesthetic scales the variable class by opacity of the points


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
# Here scaling is done by assigning different shapes to the distinct observations of the variable class


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = class)) +
  scale_colour_viridis_d()
# Using color palette from viridis package (color blind colors)


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = class)) +
  scale_colour_viridis_d(option = "plasma")
# Using the plasma option for viridis colors


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 2)
# facet_wrap()
# - splits the plot into subplots that each display one subset of the data, with respect to the variable class

# nrow=2 specifies to arrange all of the subplots in 3 rows


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = class)) +
  scale_colour_viridis_d(option = "plasma") +
  facet_wrap(~class, nrow = 2)
# facets and viridis


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = class)) +
  scale_colour_viridis_d(option = "plasma") +
  facet_grid(drv ~ cyl)
# facet_grid()
# - splits the plot by a combination of two variables into subplots that each display one subset of the data


ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class))
# geom_bar()
# - creates a bar chart with the x-axis displaying the variable class and the y-axis displaying the count of each observation of class
# stat_count() - default statistical transformation of geom_bar()


ggplot(data = mpg) +
  stat_count(mapping = aes(x = class))
# replacing geom_bar with stat_count produces the same plot




table <- as.data.frame(table(mpg$class))
# creates a frequency table

ggplot(data = table) +
  geom_bar(
    mapping = aes(x = Var1, y = Freq),
    stat = "identity"
  )
# the y-axis is mapped to the Freq variable
# for manually assigning variables to the y-axis, we have to use stat="identity"


ggplot(data = mpg) +
  stat_summary(
    mapping = aes(x = class, y = hwy),
    fun.min = min,
    fun.max = max,
    fun = median
  )
# specifying the summary function using stat_summary



ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, color = class))
# color=class just colors the border of each bar with respect to the class


ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = class)) +
  scale_fill_viridis_d()
# fill=class colors the entire bar; the viridis (color blind colors) color scheme has been used


ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = class)) +
  scale_fill_viridis_d() +
  coord_flip()
# coord_flip() flips the x and y axes


ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = class)) +
  scale_fill_viridis_d() +
  coord_polar()
# coord_polar() produces a stacked bar chart with polar coordinates, also known as a coxcomb chart


ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = trans)) +
  scale_fill_viridis_d()
# fill=trans creates a stacked bar chart with each bar divided into sub-bars according to the variable trans


ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = trans), position = "dodge") +
  scale_fill_viridis_d()
# position="dodge" places the overlapping objects beside one another, making it easier to compare the values
# position -> stack, fill, identity,...



ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
# geom_boxplot creates a vertical boxplot
# boxplot is used to summarize data using the five-number summary


ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()
# using coord_flip(), we get a horizontal boxplot


ggplot(
  data = filter(mpg, class == "subcompact"),
  mapping = aes(x = class, y = hwy)
) +
  geom_boxplot() +
  coord_flip()
# creates a boxplot specifically for the class subcompact



ggplot(data = mpg, mapping = aes(x = cty)) +
  geom_histogram()
# geom_histogram() produces a histogram
# first specifies a sequence of points called breaks
# then, it counts the number of observations between the breaks, called bins
# a bar is placed in each bin with the height proportional to the frequency or the number of observations


ggplot(data = mpg, mapping = aes(x = cty, fill = class)) +
  geom_histogram() +
  scale_fill_viridis_d()
# creates a stacked histogram with viridis colors


ggplot(data = mpg, mapping = aes(x = cty, fill = class)) +
  geom_histogram(binwidth = 5) +
  scale_fill_viridis_d()
# manually specifying the binwidth, which is the width between two breaks

