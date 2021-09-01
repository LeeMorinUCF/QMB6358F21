
################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Testing a Library of R Functions
#
# Name:
# College of Business
# University of Central Florida
#
# Date:
#
################################################################################
#
# This program tests a library of R functions.
#
#
#
################################################################################



################################################################################
# Load Packages
################################################################################

# Load any packages that are needed for these functions.
# library(package_name_goes_here)

# You would typically install the package first,
# instead of within the library.
# install.packages("package_name_goes_here")

# Set working directory, if calling from another location.
# wd_path <- '~/path/to/your/repo/assignment_02'
# setwd(wd_path)


# Load your source code for the library of functions.
source("Q1_functions.R")
# Be sure that this library is located in the working directory.
# Otherwise, you can include the path.


################################################################################
# Testing Functions
################################################################################

#--------------------------------------------------------------------------------
# Part a) Variance of one variable
#--------------------------------------------------------------------------------

print("Testing function var_x:")

# Check values that are output.
print(var_x(x = c(0, 0, 0)))
# Test output against expected answer.
print(var_x(x = c(0, 0, 0)) == 0)

# Add three more examples.







#--------------------------------------------------------------------------------
# Part b) Covariance between two variables
#--------------------------------------------------------------------------------

print("Testing function covar_y_x:")

# Check values that are output.
print(covar_y_x(y = c(0, 0, 0), x = c(0, 0, 0)))
# Test output against expected answer.
print(covar_y_x(y = c(0, 0, 0), x = c(0, 0, 0)) == 0)

# Add three more examples.






#--------------------------------------------------------------------------------
# Part c) OLS slope coefficient
#--------------------------------------------------------------------------------

print("Testing function slope_y_x:")

# Check values that are output.
print(slope_y_x(y = c(0, 0, 0), x = c(0, 0, 0)))
# Test output against expected answer.
print(slope_y_x(y = c(0, 0, 0), x = c(0, 0, 0)) == 0)

# Add three more examples.




#--------------------------------------------------------------------------------
# Part d) Sum of squared residuals
#--------------------------------------------------------------------------------

print("Testing function sum_sq_resid:")

# Check values that are output.
print(sum_sq_resid(y = c(0, 0, 0), x = c(0, 0, 0),
                   beta_0 = 0, beta_1 = 0))
# Test output against expected answer.
print(sum_sq_resid(y = c(0, 0, 0), x = c(0, 0, 0),
                   beta_0 = 0, beta_1 = 0) == 0)

# Add three more examples.







print("Q1 library testing complete.")



################################################################################
# End
################################################################################


