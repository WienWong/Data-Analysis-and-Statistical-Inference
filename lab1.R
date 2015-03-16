
# Lab 1

# Load the cdc data frame by using 
load(url("http://assets.datacamp.com/course/dasi/cdc.Rdata"))

# The object cdc is a data matrix, with each row representing a case, and each column representing a variable. R calls this data format a data frame.

# To see what kind of data your data frame contains, you can use the names() function. This function returns a vector of variable names 
names(cdc)
# [1] "genhlth"  "exerany"  "hlthplan" "smoke100" "height"   "weight"   "wtdesire"
# [8] "age"      "gender"  

# Use the head() and tail() functions to view first and last entries of the data frame.
head(cdc)
tail(cdc)

# What type of variable is genhlth?
# categorical, ordinal
# What type of variable is weight?
# numerical, continuous
# What type of variable is smoke100?
# categorical (not ordinal)

mean(cdc$weight)
var(cdc$weight)
median(cdc$weight)
# The function summary() returns a numerical summary: minimum, first quartile, median, mean, third quartile, and maximum.
summary(cdc$weight)

# Another type of data you can analyze is categorical data. For this type of variable it makes more sense to look at absolute or relative frequency.
# The function table() counts the number of times each kind of category occurs in a variable. For example, to see the number of people who have smoked at least 100 cigarettes in their lifetime, try table(cdc$smoke100) in the console.
# You can also get the relative frequencies by dividing the table by the amount of observations in your data frame.

# Use the table() function to create the frequency table for genhlth.
table(cdc$genhlth)

# Now create the relative frequency table for the same variable.
table(cdc$genhlth)/nrow(cdc)
# excellent very good      good      fair      poor 
# 0.23285   0.34860   0.28375   0.10095   0.03385 

# Now that you have calculated the relevant frequencies in the previous exercise, you can represent them graphically. A barplot is a very appropriate type of graph for this task.

# Draw the barplot with the table with the categorical data of smoke100 as input.
barplot(table(cdc$smoke100))

# Create a numerical summary for gender.
summary(cdc$gender)
#  m     f 
# 9569 10431 

# Compute the relative frequency distribution of genhlth. What proportion of the sample reports being in excellent health?
table(cdc$genhlth)/nrow(cdc)
# excellent very good      good      fair      poor 
#  0.23285   0.34860   0.28375   0.10095   0.03385 
table(cdc$genhlth == "excellent")/nrow(cdc)
#  FALSE    TRUE 
# 0.76715 0.23285 

# The table command can be used to tabulate any number of variables that you provide. This means you can investigate how different categories relate to each other. For example, you can see how many people have smoked at least 100 cigarettes in the different general health groups by executing
table(cdc$genhlth, cdc$smoke100)

# To have a nice graphical representation of this distribution you can use the mosaicplot() command.

# Use the table() function to see how many participants have smoked across each gender.
gender_smokers <- table(cdc$gender, cdc$smoke100)
gender_smokers
#      0    1
# m 4547 5022
# f 6012 4419

# Plot the mosaicplot:
mosaicplot(gender_smokers)

# Row-and-column notation: to see the sixth variable (which happens to be weight) of the 567th respondent, use the format cdc[567, 6].
# Create the subsets:
height_1337 <- cdc$height[1337]
weight_111 <- cdc$weight[111]

# Print the results:
height_1337
weight_111

# R doesn't just allow you to select on one index. You can also subset using an index range. For example, to see the weights for the first 10 respondents you can type cdc[1:10, 6].
# cdc[5:16, 1:3] allows you to retrieve the first 3 variables for respondents 5 through 16.

names(cdc)
# [1] "genhlth"  "exerany"  "hlthplan" "smoke100" "height"   "weight"   "wtdesire" "age"     
# [9] "gender" 

# Assign the variables between and including hlthplan and height for the first 8 respondents to first8.
first8 <- cdc[1:8, 3:5]
# Assign the variables between and including weight to gender for respondents 10 to 20 to wt_gen_10_20.
wt_gen_10_20 <- cdc[10:20, 6:9]

# Print the subsets:
first8
wt_gen_10_20

# Assign all variables for the 205th respondent to resp205
resp205 <- cdc[205,]
# Assign the variables height and weight for all respondents to ht_wt.
ht_wt <- cdc[, 5:6]

# Print the subsets:
resp205
head(ht_wt)

# You can see the weight for the 567th respondent by typing cdc$weight[567]. Since it's a single vector, you can subset it with just a single index inside square brackets. Similarly, for the first 10 respondents: cdc$weight[1:10].
# The command above returns the same result as the cdc[1:10,6] command. Both row-and-column notation and dollar-sign notation are widely used. 

# Assign the smoking status (smoke100) of the 1000th respondent to resp1000_smk.
resp1000_smk <- cdc$smoke100[1000]

# Assign the data containing the height of the first 30 respondents to first30_ht.
first30_ht <- cdc$height[1:30]

# Print the subsets:
resp1000_smk
first30_ht

# Suppose now you want to extract just the data for the men in the sample, or just for those over 30. You can simply use subset to do that. For example, the command
subset(cdc, cdc$gender == "m")
# will return a data frame that only contains the men from the cdc data frame.

# Use the subset() function to assign the subset of people in very good general health to very_good.
very_good <- subset(cdc, cdc$genhlth == "very good")
# Assign the subset of people aged over 50 (excluding 50) to age_gt50.
age_gt50 <- subset(cdc, cdc$age > 50)

# Print the subsets:
head(very_good)
head(age_gt50)

# Create a new object called under23_and_smoke that contains all observations of respondents under the age of 23 that have smoked at least 100 cigarettes in their lifetime.
under23_and_smoke <- subset(cdc, cdc$age < 23 & cdc$smoke100)

# Print the top six rows of the subset:
head(under23_and_smoke, 6)

# Draw a box plot of height using the boxplot() function
boxplot(cdc$height)

# Use the summary() function to also get a numerical summary of the variable.
summary(cdc$height)
# As you can see, the median and upper and lower quartiles reported in the numerical summary match those in the graph.

# The purpose of a box plot is to provide a thumbnail sketch of a variable for the purpose of comparing across several categories. So you can, for example, compare the heights of men and women with boxplot(cdc$height ~ cdc$gender).

# Use the ~ notation to box plot the weight of respondents as a function of whether or not they smoke (smoke100).
boxplot(cdc$weight ~ cdc$smoke100)

# You can also calculate new variables that don't directly show up in your data frame. Say for example you want to create a box plot of the sum of weight and height versus gender. This is of course nonsense, but it can be done like this:
w_height <- cdc$weight + cdc$height
boxplot(w_height ~ cdc$gender)

# Calculate the BMI for each respondent and assign the result to bmi.
bmi <- (cdc$weight/cdc$height^2) * 703

# DDraw a box plot of the BMI versus the general health of the respondents.
boxplot(bmi ~ cdc$genhlth)

# Some observation:
# The median BMI is roughly 25 for all general health categories, and there is a slight increase in median BMI as general health status declines (from excellent to poor).
# The IQR increases slightly as general health status declines (from excellent to poor).
# Among people with excellent health, there are some with unusually low BMIs compared to the rest of the group.

# Histograms are generally a very good way to see the shape of a single distribution, but that shape can change depending on how the data is split between the different bins.

# Draw a histogram of bmi:
hist(bmi)
# And one with breaks set to 50:
hist(bmi, breaks=50)
# And one with breaks set to 100:
hist(bmi, breaks=100)

# In the previous lab, when exploring how percentages of boys and girls born vary over time (two numerical variables) we used a scatterplot. Now let's use the same tools to compare people's actual weight against their desired weight.

# Use the plot() function to make a scatterplot of the weight variable versus the wtdesire variable. 
plot(cdc$weight, cdc$wtdesire)

# Based on the plot, the relationship between weight and desired weight?
# moderately strong positive linear association


