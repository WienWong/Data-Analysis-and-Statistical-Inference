
# Lab 0

# The hashtag is used to add comments

# An addition
5 + 5

# A substraction
5 - 5

# A division
(5 + 5)/2

# A plot
plot(cars, type="o", col="blue")

# Load a data set into R
# Read in your data set and assign to the object:
present <- read.table("http://assets.datacamp.com/course/dasi/present.txt")

# This will print your data set in the console:
present

# R has stored the data in a kind of spreadsheet or table called a data frame.
# Print the number of rows and variables with the 'dim' function:
dim(present)
# 63  3

# Print the names of the variables of the data frame:
names(present)
# "year"  "boys"  "girls"

# Find the number of boys born each year, and assign your answer to 
num_boys <- present$boys

# Find the number of girls born each year, and assign your answer to
num_girls <- present$girls

num_boys
# [1] 1211684 1289734 1444365 1508959 1435301 1404587 1691220 1899876 1813852
# [10] 1826352 1823555 1923020 1971262 2001798 2059068 2073719 2133588 2179960
# [19] 2152546 2173638 2179708 2186274 2132466 2101632 2060162 1927054 1845862
# [28] 1803388 1796326 1846572 1915378 1822910 1669927 1608326 1622114 1613135
# [37] 1624436 1705916 1709394 1791267 1852616 1860272 1885676 1865553 1879490
# [46] 1927983 1924868 1951153 2002424 2069490 2129495 2101518 2082097 2048861
# [55] 2022589 1996355 1990480 1985596 2016205 2026854 2076969 2057922 2057979

# Notice that the way R has printed these data is different. These data are no longer structured in a table with other variables, they are displayed one right after another. Objects that print out in this way are called vectors. R has added numbers in [brackets] along the left side of the printout to indicate locations within the vector. For example, 1211684 follows [1], indicating that 1211684 is the first entry in the vector. And if [55] starts a line, then that would mean the first number on that line would represent the 55th entry in the vector.

# Type here the code to create the plot:
plot(present$year, present$girls)

# By default, R creates a scatterplot with each x,y pair indicated by an open circle. Now, if we want to connect the data points with a line, we could add a third argument: type = "l" (with l being short for line).

# Create the plot here:
plot(present$year, present$girls, type="l")

# Adding columns of a data frame is simple, since they have the same length by definition:
# data_frame$variable_name_1 
# + data_frame$variable_name_2 
# + ...
#
# The vector babies:
babies <- present$boys + present$girls

# Your plot
plot(present$year, babies, type="l")

# You can compute the ratio of the number of boys divided by the number of girls born by typing present$boys/present$girls. Similarly, you can calculate the proportion of male newborns by typing present$boys/(present$boys + present$girls).
# The proportion of boys born in the US has decreased over time?
plot(present$year, present$boys/(present$boys + present$girls))
# True

# Check when boys outnumber girls
present$boys > present$girls

# Plot the boy-to-girl ratio for every year:
plot(present$year, present$boys/present$girls, type="l")

# Extract the year they had max babies difference
present$year[which.max(abs(present$boys - present$girls))]
# 1963
