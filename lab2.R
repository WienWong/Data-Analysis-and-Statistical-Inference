
# Lab 2

# The goals for this lab are to (1) think about the effects of independent and dependent events, (2) learn how to simulate
# shooting streaks in R, and (3) to compare a simulation to actual data in order to determine if the hot hand phenomenon
# appears to be real.

# Load the data frame
load(url("http://assets.datacamp.com/course/dasi/kobe.RData"))

# Inspect your data
head(kobe)
tail(kobe)

# In the kobe data frame, every row records a shot taken by Kobe Bryant. If he hit the shot (made a basket), a hit, H, is
# recorded in the column named basket, otherwise a miss, M, is recorded.

# Just looking at the string of hits and misses, it can be difficult to gauge whether or not it seems like Kobe was shooting
# with a hot hand. One way we can approach this is by considering the belief that hot hand shooters tend to go on shooting
# streaks. For this lab, we define the length of a shooting streak to be the number of consecutive baskets made until a miss
# occurs.

# Print the variable names of the data frame.
names(kobe)
# [1] "vs"          "game"        "quarter"     "time"        "description"
# [6] "basket"  

# Print the first 9 values of the 'basket' variable
kobe$basket[1:9]
# [1] "H" "M" "M" "H" "H" "M" "M" "M" "M"
# You can see that within the nine shot attempts, there are six streaks, which are separated by a | above. Their lengths are
# one, zero, two, zero, zero, zero.

# Definition: the length of a shooting streak is the number of consecutive baskets (hits) until a miss occurs.
# What does a streak length of 1 mean, i.e. how many hits and misses are in a streak of 1?
# A hit followed by a miss.

# What about a streak length of 0? How many hits and misses are in a streak of 0?
# A miss followed by a miss.

# To start, let's look at the distribution of the shooting streaks. Along with the data frame, we also loaded the custom
# function calc_streak() into the workspace.

# We'll use this function to calculate the lengths of all shooting streaks and then look at the distribution with a barplot.
# Note that a bar plot is preferable to a histogram here since our variable is discrete (we're dealing with counts) instead
# of continuous.

# Use the function calc_streak() to calculate the length of Kobe's streaks (by using the variable basket) and assign the
# result to kobe_streak.

kobe_streak <- calc_streak(kobe$basket)

# Draw a barplot of the result:

barplot(table(kobe_streak))

# The typical length of a streak, as measured by the median, is 0.
# The IQR of the distribution is 1.
# Streak lengths of 3 and 4 are unusually high compared to the rest of the distribution.

# So the key is to compare Kobe's data with that of a shooter who we know to have independent shots. While we don't have any
# such data, that is very easy to simulate in R.

# In a simulation, you set the ground rules of a random process and then the computer uses random numbers to generate an
# outcome that adheres to those rules. As an example, you can simulate flipping a fair coin with the following commands.

outcomes <- c("heads", "tails")
sample(outcomes, size=1, replace=TRUE)
# The vector outcomes can be thought of as a hat with two slips of paper in it: one slip says “heads” and the other says
# “tails”. The function sample() draws one slip from the hat and tells us if it was a head or a tail.

# Try some simulations!
outcomes <- c("heads", "tails")
sample(outcomes, size=1, replace=TRUE)
sample(outcomes, size=1, replace=TRUE)
sample(outcomes, size=1, replace=TRUE)
sample(outcomes, size=1, replace=TRUE)
sample(outcomes, size=1, replace=TRUE)
sample(outcomes, size=1, replace=TRUE)
sample(outcomes, size=1, replace=TRUE)
sample(outcomes, size=1, replace=TRUE)
sample(outcomes, size=1, replace=TRUE)
sample(outcomes, size=1, replace=TRUE)

# If you wanted to simulate flipping a fair coin 100 times, you could either run the function 100 times or, more simply,
# adjust the size argument, which governs how many samples to draw. Since there are only two elements in outcomes, the
# probability that we “flip” a coin and it lands heads is 0.5.

# Suppose again that you have a hat with two slips of paper in it: one slip says “heads” and the other says “tails”.
# Therefore at each draw, the probability of drawing a chip that says “head” is 50%, and “tail” is 50%. The replace = TRUE
# argument indicates we put the chip back in the hat before drawing again, therefore always keeping the 50/50 odds.


# Simulate flipping a fair coin 100 times with the sample() function by setting the size to 100. Assign the result to
# sim_fair_coin.
# Inspect the results by printing the object and using the table() function to count the amounts of heads and tails.

outcomes <- c("heads", "tails")
sim_fair_coin <- sample(outcomes, size=100, replace=TRUE)

# Print the object:
sim_fair_coin

# Compute the counts of heads and tails:
table(sim_fair_coin)
# sim_fair_coin
# heads tails 
# 53    47


# Until now you've been running simulations where each outcome had an equal probability. However, the sample() function also
# allows you to set the probabilities.

# You can set these probabilities by adding an argument called prob to the sample() function. This argument needs a vector of
# probability weights, one for each possible outcome. 
# An example of such a vector for three possible outcomes is c(0.1, 0.6, 0.3).

# Note that for the fair coin the probability weight vector is c(0.5, 0.5). The default of the sample() function (when no
# prob is given) is for all outcomes to have equal probability.

# Run 100 simulations of an unfair coin that lands on head 20% of the time. Do this by assigning assign the result to
# sim_unfair_coin. 
# Inspect the result using the table() function.

outcomes <- c("heads", "tails")
sim_unfair_coin <- sample(outcomes, size=100, prob=c(0.2, 0.8), replace=TRUE)

# Print the object:
sim_unfair_coin

# Compute the counts of heads and tails:
table(sim_unfair_coin)
# sim_unfair_coin
# heads tails 
# 15    85 

# Simulating a basketball player who has independent shots uses the same mechanism that we used to simulate a coin flip. To
# simulate a single shot from an independent shooter with a shooting percentage of 50% we type,
outcomes <- c("H", "M")
sim_basket <- sample(outcomes, 
                     size = 1, 
                     replace = TRUE)

# To make a valid comparison between Kobe and our simulated independent shooter, we need to align both their shooting
# percentages and their numbers of attempted shots.

# Run a simulation to sample 133 shots (the number of shots of Kobe in this data set) with a shooting percentage of 45%.
# Assign the output of this simulation to a new object called sim_basket.
# Inspect your simulation.

outcomes <- c("H", "M")
sim_basket <- sample(outcomes, 
                     size = 133, 
                     prob = c(.45, .55),
                     replace = TRUE)

table(sim_basket)
# sim_basket
# H  M 
# 65 68

# With the results of the simulation saved as sim_basket, you have the data you need to compare Kobe to your independent
# shooter. We can look at Kobe's data alongside our simulated data: kobe$basket vs. sim_basket.
# Both data sets represent the results of 133 shot attempts, each with the same shooting percentage of 45%. We know that our
# simulated data is from a shooter that has independent shots. That is, we know the simulated shooter does not have a hot
# hand.


# Using the custom function calc_streak(), compute the streak lengths of kobe$basket and sim_basket. Assign the results to
# kobe_streak and sim_streak relatively. 
# Compare them using the techniques you've learned: simply printing the streaks, summarizing using summary, and drawing
# barplots.

# Calculate streak lengths:
kobe_streak <- calc_streak(kobe$basket)
sim_streak <- calc_streak(sim_basket)

# Compute summaries:
kobe_streak
[1] 1 0 2 0 0 0 3 2 0 3 0 1 3 0 0 0 0 0 1 1 0 4 1 0 1 0 1 0 1 2 0 1 2 1 0 0 1 0
[39] 0 0 1 1 0 1 0 2 0 0 0 3 0 1 0 1 2 1 0 1 0 0 1 3 3 1 1 0 0 0 0 0 1 1 0 0 0 1
sim_streak
[1] 4 0 0 0 2 0 1 0 0 0 0 0 1 0 3 1 0 0 1 0 1 0 3 1 2 0 0 0 0 3 0 1 1 0 0 1 3 1
[39] 3 0 0 0 3 0 1 0 0 0 0 1 1 2 2 2 0 0 3 3 0 1 1 4 0 1 0 4 0 1 2

summary(kobe_streak)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.0000  0.0000  0.0000  0.7632  1.0000  4.0000 
summary(sim_streak)
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.000   0.000   0.000   0.942   1.000   4.000 

# Make bar plots:
kobe_table <- table(kobe_streak)
sim_table <- table(sim_streak)
barplot(kobe_table)
barplot(sim_table)
