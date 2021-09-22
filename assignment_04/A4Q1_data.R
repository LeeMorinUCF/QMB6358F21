##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# Assignment 4: Joining Datasets
#
# Name:
# College of Business
# University of Central Florida
#
# Date:
#
##################################################
#
# A4Q1_data is an exercise in joining
# data sets with data on the sales of airplanes.
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# No libraries required.
# Otherwise would have a command like the following.
# library(name_of_R_package)


##################################################
# Setting the Parameters
##################################################


# Set path for working directory.
# wd_path <- "~/Teaching/QMB6358_Fall_2021/Assignments/assignment_04"
# Modify the above line according to the specific path on your computer,
# as in:
# wd_path <- 'C:/Users/name/of/your/path'

# Set the working directory to this path.
# setwd(wd_path)

# Verify that the path was assigned correctly.
# getwd()

# You might run this script from the command line,
# in which case no path is necessary,
# provided the data are stored in the same folder
# from which the script is run.

##################################################
# Q1 a) Loading the Data
##################################################

# Q1 a)

# Code goes here.




##################################################
# Estimating a Regression Model
# Model 0: Sale price on age only
##################################################

# Use all available variables from first dataset.
colnames(airplane_sales)

# Estimate a regression model.
lm_model_0 <- lm(data = airplane_sales,
                 formula = price ~ age)

# Output the results to screen.
summary(lm_model_0)


##################################################
# Q1 b) Loading another dataset
##################################################

# Q1 b)

# Code goes here.




##################################################
# Q1 c) Loading another dataset
##################################################

# Q1 c)

# Code goes here.







##################################################
# Q1 d) Joining the two datasets
##################################################

#-------------------------------------------------
# Q1 d)(i)
# Join the fist two datasets.
#-------------------------------------------------

# Code goes here.








##################################################
# Estimating a Regression Model
# Model 1: Sale price on age
# and performance variables
##################################################

# Use all available variables from full dataset.
colnames(airplane_full)

# Estimate a regression model.
lm_model_1 <- lm(data = airplane_full,
                 formula = price ~ age +
                   horse + fuel + ceiling + cruise)

# Output the results to screen.
print(summary(lm_model_1))


# This should be a better model.


#-------------------------------------------------
# Q1 d)(ii)
# Join the fist two datasets with the third.
#-------------------------------------------------

# Code goes here.









##################################################
# Estimating a Regression Model
# Full Model: Sale price on age,
# performance and other variables.
##################################################

# Use all available variables from full dataset.
colnames(airplane_full)

# Estimate a regression model.
lm_model_full <- lm(data = airplane_full,
                    formula = price ~ age +
                      horse + fuel + ceiling + cruise +
                      pass + wtop + fixgear + tdrag)

# Output the results to screen.
print(summary(lm_model_full))


# This should be an even better model.


##################################################
# End
##################################################
