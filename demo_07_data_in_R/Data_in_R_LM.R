
################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Introductory Examples: Data Loading and Manipulation
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# September 9, 2020
#
################################################################################
#
# This program provides introductory examples of R code for loading
# and handling data.
#
#
#
################################################################################

# Clear workspace.
# The remove function removes everything in the workspace when the list is all.
rm(list=ls(all=TRUE))

# Load library of functions.
# source('my_R_code.R')

# Load packages.
# library(name_of_R_package_goes_here)


# Set working directory.
# The '<-' operator denotes right-to-left assignment.
# wd_path <- '/path/to/your/folder'
# "~/Teaching/QMB6358_Fall_2021/GitRepo/QMB6358F21/demo_07_data_in_R"

wd_path <- '~/Teaching/QMB6358_Fall_2021/GitRepo/QMB6358F21/demo_07_data_in_R'
setwd(wd_path)
getwd()

# Set paths to other folders.
# data_path <- sprintf('%s/data', wd_path)
# Optional: Organize data in a separate folder for larger projects.


################################################################################
# Reading and writing tables, csv files and data frames.
################################################################################


# Load some sample datasets and inspect their contents.
data(cars)

# Display the entire dataset (not for large files!).
cars

# Show a summary of the variables.
summary(cars)


# Write this dataset to a file in your working directory.
write.table(cars, file = 'cars.txt')

# Read in your copy into another data frame.
cars_df <- read.table(file = 'cars.txt')

# Reading a table creates a data frame:
class(cars_df)


# Should be the same.
summary(cars_df)



# Read in another sample dataset.
data(iris)

# Display the entire dataset (not for large files!).
iris


# Write this to your folder in csv format.
write.csv(iris, file = 'iris.csv')

# Read in your copy to a data frame.
iris_df <- read.csv(file = 'iris.csv')



################################################################################
# Load data and analyze
################################################################################

# Reload the datasets created earlier.

# The cars dataset.
cars_df <- read.table(file = 'cars.txt')


# This is a data frame:
class(cars_df)

# Summarize the data.
summary(cars_df)

# Get the dimensions of the data.
dim(cars_df)

# Get the numbers of rows and columns separately.
nrow(cars_df)
ncol(cars_df)

# Show the first few rows of the dataset.
head(cars_df)

# Show the column names of the data.
colnames(cars_df)


# Select a subset using numeric indices.
cars_df[2:5, 2]
# Notice which observations were selected.

# Select a variable using variable names.
cars_df[2:5,'dist']
cars_df$dist[2:5]


# The second approach is a compound statement,
# taking a subset of rows from a single column.
summary(cars_df$dist)


# You can also select using logical arguments.
colnames(cars_df) == 'dist'
cars_df[2:5, colnames(cars_df) == 'dist']

# Another approach.
# Select columns by name of variables (those beginning with "d").
sel_cols <- substring(colnames(cars_df), 1, 1) == 'd'
cars_df[2:5, sel_cols]


# Select based on values.
summary(cars_df$speed)
sel_rows <- cars_df$speed > mean(cars_df$speed)
cars_df[sel_rows, ]
# The empty argument in [,] select all elements.


sel_rows <- cars_df$speed == 24
cars_df[sel_rows, ]


# A data frame is essentially a list of objects.
class(cars_df$dist)

# Exercise:
# 1. List the 5 fastest cars.
# 2. List the 4 cars with the shortest stopping distance.



# Tables

table(cars_df[, 'speed'])

table(cars_df[, 'speed'],
      cars_df[, 'dist'])





# The iris dataset has categorical variables.
iris_df <- read.csv(file = 'iris.csv')


# This is also a data frame:
class(iris_df)

# Summarize the data.
summary(iris_df)

# Get the dimensions of the data.
dim(iris_df)

# Get the numbers of rows and columns separately.
nrow(iris_df)
ncol(iris_df)

# Show the first few rows of the dataset.
head(iris_df)

# Show the column names of the data.
colnames(iris_df)

# The last column can be designed as a factor.
class(iris_df$Species)
iris_df$Species <- factor(iris_df$Species) # If not a factor already.
class(iris_df$Species) # Check that it was changed to a factor.
levels(iris_df$Species)


# For factors, it is often useful to create a table.
# Create a table of counts of each level.
table(iris_df$Species)


# Could put two arguments for a two-dimensional table.
table(iris_df$Species, iris_df$Petal.Width)
# You can see that different species have different widths.



# Create new variables.
iris_df$Petal.Area <- iris_df$Petal.Width * iris_df$Petal.Length
summary(iris_df)

# Drop this variable and reorganize.
columns_to_keep <- c('Species', 'Petal.Length', 'Petal.Width', 'Sepal.Length', 'Sepal.Width')
iris_df <- iris_df[,columns_to_keep]
summary(iris_df)



# Create a new data frame with columns of your choice.
iris_area_df <- data.frame(Species = iris_df$Species,
                         Petal.Area = iris_df$Petal.Width * iris_df$Petal.Length)
summary(iris_area_df)



# Bind columns to the side of a data frame.
iris_wide_df <- cbind(iris_df, iris_area_df)
summary(iris_wide_df)



# Bind additional rows below.
iris_tall_df <- rbind(iris_df, iris_df)
summary(iris_tall_df)

# Note that there are twice as many rows.
nrow(iris_tall_df)




# Remove duplicates.
iris_df2 <- iris_df[!duplicated(iris_df$Species),]
iris_df2
# In this case, this selects one of each.



# Sort the data by one variable.
iris_df[order(iris_df$Petal.Length),]


iris_df[order(-iris_df$Petal.Length),]


# Exercise:
# 1. Calculate summary statistics for the three types
#   of flowers separately.
# 2. List the petal width for flowers of type setosa
#   with petal length larger than average.







################################################################################
# End
################################################################################



