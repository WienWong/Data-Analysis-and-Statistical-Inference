
# Lab 3B

# If you have access to data on an entire population, say the size of every house in Ames, Iowa, it's straight forward to
# answer questions like, "How big is the typical house in Ames?" and "How much variation is there in sizes of houses?". If you
# have access to only a sample of the population, as is often the case, the task becomes more complicated.
# What is your best guess for the typical size if you only know the sizes of several dozen houses? This sort of situation
# requires that you use your sample to make inference on what your population looks like.

# Draw a sample of size 60 from population. Assign it to samp.
# Calculate the mean of your sample. Assign it to sample_mean.
# Draw a histogram of the sample.

# Take a sample of size 60 of the population:
population <- ames$Gr.Liv.Area
samp <- sample(population, 60)

# Calculate the mean:
sample_mean <- mean(samp)

# Draw a histogram:
hist(samp)

# Based only on this single sample, the best estimate of the average living area of houses sold in Ames would be the sample
# mean.
# That serves as a good point estimate but it would be useful to also communicate how uncertain we are of that estimate. This
# can be captured by using a confidence interval.
# We can calculate a 95% confidence interval for a sample mean by adding and subtracting 1.96 standard errors to the point
# estimate.
se <- sd(samp)/sqrt(60)
lower <- sample_mean - 1.96 * se
upper <- sample_mean + 1.96 * se
c(lower, upper)

# It is an important inference that we make with this: even though we don't know what the full population looks like, we're
# 95% confident that the true average size of houses in Ames lies between the values lower and upper.

# What does "95% confidence" mean?
# 95% of random samples of size 60 will yield confidence intervals that contain the true average area of houses in Ames, Iowa.

# Obtain a random sample.
# Calculate the sample's mean and standard deviation.
# Use these statistics to calculate a confidence interval.
# Repeat steps (1)-(3) 50 times.
# Inspect the plot that was generated with the provided custom function plot_ci().

# Initialize 'samp_mean', 'samp_sd' and 'n':
samp_mean <- rep(NA, 50)
samp_sd <- rep(NA, 50)
n <- 60

# For loop goes here:
for (i in 1:50) {
    samp <- sample(population, n) 
    samp_mean[i] <- mean(samp)
    samp_sd[i] <- sd(samp)
}

# Calculate the interval bounds here:
se <- samp_sd/sqrt(n)
lower <- samp_mean - 1.96 * se
upper <- samp_mean + 1.96 * se

# Plotting the confidence intervals:
pop_mean <- mean(population)
plot_ci(lower, upper, pop_mean)

# What is the appropriate critical value for a 99% confidence level?
# The critical value for the 99% confidence level is the cut-off for the middle 99% of the standard normal distribution. 
# You can use the command qnorm(0.995).
2.58

# Calculate 50 confidence intervals at the 99% confidence level.

# Initialize 'samp_mean', 'samp_sd' and 'n':
samp_mean <- rep(NA, 50)
samp_sd <- rep(NA, 50)
n <- 60

# For loop goes here:
for (i in 1:50) {
    samp <- sample(population, n) 
    samp_mean[i] <- mean(samp)
    samp_sd[i] <- sd(samp)
}

# Calculate the interval bounds here:
se <- samp_sd/sqrt(n)
lower <- samp_mean - 2.58 * se
upper <- samp_mean + 2.58 * se

# Plotting the confidence intervals:
pop_mean <- mean(population)
plot_ci(lower, upper, pop_mean)



