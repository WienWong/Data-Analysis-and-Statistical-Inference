
# Lab 3A

# In Part A of this lab, we investigate the ways in which the statistics from a random sample of data can serve as point
# estimates for population parameters. We're interested in formulating a sampling distribution of our estimate in order to
# learn about the properties of the estimate, such as its distribution.

# We consider real estate data from the city of Ames, Iowa. The details of every real estate transaction in Ames is recorded
# by the City Assessor's office. Our particular focus for this lab will be all residential home sales in Ames between 2006
# and 2010. This collection represents our population of interest (which is rare to have access to), but we will also work
# with smaller samples from this population.

# Load the 'ames' data frame:
load(url("http://assets.datacamp.com/course/dasi/ames.RData "))

# Make some preliminary inspections:
head(ames)
tail(ames)
names(ames)

# The names() function tells us there are quite a few variables in the data set, enough to do a very in-depth analysis. For
# this lab, we'll restrict our attention to just two of the variables: the above ground living area of the house in square
# feet (Gr.Liv.Area) and the sale price (SalePrice).

# To save some effort throughout the lab, you'll create two objects area and price to store these variables. 

# Assign the variables:
area <- ames$Gr.Liv.Area
price <- ames$SalePrice

# Calculate the summary and draw a histogram of 'area'
summary(area)
summary(price)

hist(area)

# In this lab we have access to the entire population, but this is rarely the case in real life. Gathering information on an
# entire population is often extremely costly or impossible. Because of this, we often take a sample of the population and
# use that to understand the properties of the population.
# If we were interested in estimating the mean living area in Ames based on a sample, we can use the sample() function to
# sample from the population: sample(area, 50).
# This command collects a simple random sample of size 50 from the vector area. This is like going into the City Assessor's
# database and pulling up the files on 50 random home sales. If we didn't have access to the population data, working with
# these 50 files would be considerably simpler than having to go through all 2930 home sales.

# Take a sample of 50 of the area and assign it to samp0.
# Take another sample of 50 and assign it to samp1.
# Compare these two samples by drawing histograms. 

# Create the samples:
samp0 <- sample(area, 50)
samp1 <- sample(area, 50)

# Draw the histograms:
hist(samp0)
hist(samp1)

# If we're interested in estimating the average living area of homes in Ames using the sample, our best single guess is the
# sample mean: mean(samp1).
# Depending on which 50 homes you selected, your estimate could be a bit above or a bit below the true population mean of
# approximately 1,500 square feet. In general, though, the sample mean turns out to be a pretty good estimate of the average
# living area, and we were able to get it by sampling less than 3% of the population.


# Not surprisingly, every time we take another random sample, we get a different sample mean. It's useful to get a sense of
# just how much variability we should expect when estimating the population mean this way.
# The distribution of sample means, called the sampling distribution, can help us understand this variability. In this lab,
# because we have access to the population, we can build up the sampling distribution for the sample mean by repeating the
# above steps many times. Here we will generate 5000 samples and compute the sample mean of each.
# The code in the editor takes 5000 samples of size 50 from the population, calculates the mean of each sample, and stores
# each result in a vector called sample_means50, using what we call a for loop.

# Set up an empty vector of 5000 NAs to store sample means:
sample_means50 <- rep(NA, 5000)

# Take 5000 samples of size 50 of 'area' and store all of them in 'sample_means50'.
for (i in 1:5000) {
    samp <- sample(area, 50)
    sample_means50[i] <- mean(samp)
}

# View the result. If you want, you can increase the bin width to show more detail by changing the 'breaks' argument.
hist(sample_means50, breaks = 13)

# We've added one extra line to the code, which prints the object i during each iteration of the for loop. 

# Set up an empty vector of 5000 NAs to store sample means:
sample_means50 <- rep(NA, 5000)

# Take 5000 samples of size 50 of 'area' and store all of them in 'sample_means50'.
# Also print 'i' (the index counter):
for (i in 1:5000) {
    samp <- sample(area, 50)
    sample_means50[i] <- mean(samp)
    print(i)
}

# NA means not available, and in this case they're used as placeholders until we fill in the values with actual sample means.
# NA is also often used for missing data in R.

# Carefully read the comments in the editor to understand what each line of the code does.

# The vector 'sample_means50' is initialized with NA values
sample_means50 <- rep(NA, 5000)
# The for loop runs 5000 times, with 'i' taking values 1 up to 5000
for (i in 1:5000) {
    # Take a random sample of size 50
    samp <- sample(area, 50)
    # Store the mean of the sample in the 'sample_means50' vector on the ith place
    sample_means50[i] <- mean(samp)
    # Print the counter 'i'
    print(i)
}

# Print the first few random medians
head(sample_means50)

# Initialize a vector of 100 NAs called sample_means_small.
# Run a loop for 100 times that takes a sample of size 50 from area and stores the sample mean in sample_means_small.

sample_means_small <- rep(NA, 100)

for(i in 1:100){
    sp <- sample(area, 50)
    sample_means_small[i] <- mean(sp)
}

sample_means_small

# Which of the following is true about the elements in the sampling distributions you created? 
# (The elements in sample_means_small.)
# Each element represents a mean square footage from a simple random sample of 50 houses.

# Mechanics aside, let's return to the reason we used a for loop: to compute a sampling distribution, specifically, 
# this one: hist(sample_means50).

# The sampling distribution that we computed tells us much about estimating the average living area in homes in Ames. Because
# the sample mean is an unbiased estimator, the sampling distribution is centered at the true average living area of the the
# population, and the spread of the distribution indicates how much variability is induced by sampling only 50 home sales.

# Let's see what the effect is of the sample size on our distribution. Take a look at the code. Here we create two more
# sampling distributions sample_means10 and sample_means100.

# Initialize the sample distributions:
sample_means10 <- rep(NA, 5000)
sample_means100 <- rep(NA, 5000)

# Run the for loop:
for (i in 1:5000) {
    samp <- sample(area, 10)
    sample_means10[i] <- mean(samp)
    samp <- sample(area, 100)
    sample_means100[i] <- mean(samp)
}

# Take a look at the results:
head(sample_means10)
head(sample_means50) # was already loaded
head(sample_means100)

# Note that we're able to use a single for loop to build two distributions by adding additional lines inside the curly braces.
# Don't worry about the fact that samp is used for the name of two different objects. In the second command of the for loop,
# the mean of samp is saved to the relevant place in the vector sample_means10.
# With the mean saved, we're now free to overwrite the object samp with a new sample, this time of size 100.
# In general, anytime you create an object using a name that is already in use, the old object will get replaced with the new
# one, i.e. R will write over the existing object with the new one, which is something you want to be careful about if you
# don't intend to do so.

# Initialize the sample distributions:
sample_means10 <- rep(NA, 5000)
sample_means100 <- rep(NA, 5000)

# Run the for loop:
for (i in 1:5000) {
    samp <- sample(area, 10)
    sample_means10[i] <- mean(samp)
    samp <- sample(area, 100)
    sample_means100[i] <- mean(samp)
}

# Take a look at the results:
head(sample_means10)
head(sample_means50)  
head(sample_means100)

# To see the effect that different sample sizes have on the sampling distribution, let's plot the three distributions on top
# of one another.
# In R you can plot all three of them on the same graph by specifying that you'd like to divide the plotting area into three
# rows and one column of plots. You do this with the following command:
par(mfrow = c(3, 1))

# For easy comparison, we'd also like to use the same scale for each histogram. As a common scale, we'll use to the limits
# (min, max) of the first sample distribution:
xlimits <- range(sample_means10)

# Now we can set the xlim argument of the hist() function to the xlimits object to specify the range of the x-axis of the
# histograms.

# To help you get started we've already divided the plotting area and initialized the xlimits.
# Use the hist() function three times to draw the sample distributions sample_means10, sample_means50 and sample_means100.
# Set the breaks argument of each of the histograms to 20.
# Set the xlim argument of each of the histograms to xlimits.

# Divide the plot in 3 rows:
par(mfrow = c(3, 1))

# Define the limits for the x-axis:
xlimits <- range(sample_means10)

# Draw the histograms:
hist(sample_means10, breaks=20, xlim=xlimits)
hist(sample_means50, breaks=20, xlim=xlimits)
hist(sample_means100, breaks=20, xlim=xlimits)

# Take a sample of size 50 from 'price':
sample_50 <- sample(price, 50)
# Print the mean:
mean(sample_50)

# Initialize an object sample_means50 with 5000 NAs.
# Use a for loop to create 5000 samples of size 50 of price.
# Inside the loop, calculate the mean of each sample and assign it to its place in sample_means50.
# Inspect the result by printing sample_means50 using the head() function.

sample_means50 <- rep(NA, 5000)

for(i in 1:5000){
    sp <- sample(price, 50)
    sample_means50[i] <- mean(sp)
}

head(sample_means50)


# Create sample_means150 and populate it with means of samples of size 150.
# Finish with drawing histograms of both sample_means50 and sample_means150

sample_means150 <- rep(NA, 5000)

for(i in 1:5000){
    sp <- sample(price, 150)
    sample_means150[i] <- mean(sp)
}

hist(sample_means150)
hist(sample_means50)
