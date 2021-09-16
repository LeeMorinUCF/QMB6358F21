
################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Testing a Library of R Functions
#
# Name: April Henry
# College of Business
# University of Central Florida
#
# Date: 09/14/2021
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
# wd_path <- '~/GitHub/AHenry-QMB6358-21/assignment_02/Q1_functions.R'
# setwd(wd_path)


# Load your source code for the library of functions.
# source("Q1_functions.R")
# Changed in this example:
source("Q1_functions_example.R")
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

# Additional examples:
# 1) Check values that are output.
print(var_x(x = c(1:10)))
# Test output against expected answer.
print(abs(var_x(x = c(1:10)) - (9.166667)) < 10^(-6))

# 2) Check values that are output.
print(var_x(x = c(2, 4, 6, 8, 10)))
# Test output against expected answer.
print(var_x(x = c(2, 4, 6, 8, 10)) == 10)

# 3) Check values that are output.
print(var_x(x = c(3, 6, 9, 12, 15)))
# Test output against expected answer.
print(var_x(x = c(3, 6, 9, 12, 15)) == 22.5)


#--------------------------------------------------------------------------------
# Part b) Covariance between two variables
#--------------------------------------------------------------------------------

print("Testing function covar_y_x:")

# Check values that are output.
print(covar_y_x(y = c(0, 0, 0), x = c(0, 0, 0)))
# Test output against expected answer.
print(covar_y_x(y = c(0, 0, 0), x = c(0, 0, 0)) == 0)

# Additional examples:
# 1) Check values that are output.
print(covar_y_x(y = c(1:10), x = c(20:29)))
# Test output against expected answer.
print(abs(covar_y_x(y = c(1:10), x = c(20:29)) - (9.166667)) < 10^(-6))

# 2) Check values that are output.
print(covar_y_x(y = c(35, 46, 28, 90, 12), x = c(25, 63, 87, 35, 29)))
# Test output against expected answer.
print(abs(covar_y_x(y = c(35, 46, 28, 90, 12), x = c(25, 63, 87, 35, 29)) - (-94.7))
      < 10^(-6))

# 3) Check values that are output.
print(covar_y_x(y = c(23, 14, 16, 18, 11), x = c(31, 61, 29, 12, 15)))
# Test output against expected answer.
print(abs(covar_y_x(y = c(23, 14, 16, 18, 11), x = c(31, 61, 29, 12, 15)) - (-3.8))
      < 10^(-6))


#--------------------------------------------------------------------------------
# Part c) OLS slope coefficient
#--------------------------------------------------------------------------------

print("Testing function slope_y_x:")

# Check values that are output.
print(slope_y_x(y = c(0, 0, 0), x = c(0, 0, 0)))
# Test output against expected answer.
print(slope_y_x(y = c(0, 0, 0), x = c(0, 0, 0)) == 0)

# Add three more examples.

# Additional examples:
# 1) Check values that are output.
print(slope_y_x(y = c(20:29), x = c(1:10)))
# Test output against expected answer.
print(abs(slope_y_x(y = c(20:29), x = c(1:10)) - (1)) < 10^(-6))

# 2) Check values that are output.
print(slope_y_x(y = c(35, 46, 28, 90, 12), x = c(25, 63, 87, 35, 29)))
# Test output against expected answer.
print(abs(slope_y_x(y = c(35, 46, 28, 90, 12), x = c(25, 63, 87, 35, 29)) -
            (-0.1350542)) < 10^(-6))

# 3) Check values that are output.
print(slope_y_x(y = c(23, 14, 16, 18, 11), x = c(31, 61, 29, 12, 15)))
# Test output against expected answer.
print(abs(slope_y_x(y = c(23, 14, 16, 18, 11), x = c(31, 61, 29, 12, 15)) -
            (-0.01005823)) < 10^(-6))


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

# Additional examples:
# 1) Check values that are output.
# Check values that are output.
print(sum_sq_resid(y = c(20:29), x = c(1:10),
                   beta_0 = 2, beta_1 = 13))
# Test output against expected answer.
print(sum_sq_resid(y = c(20:29), x = c(1:10),
                   beta_0 = 2, beta_1 = 13) == 35890)

# 2) Check values that are output.
# Check values that are output.
print(sum_sq_resid(y = c(35, 46, 28, 90, 12), x = c(25, 63, 87, 35, 29),
                   beta_0 = 42, beta_1 = 5))
# Test output against expected answer.
print(sum_sq_resid(y = c(35, 46, 28, 90, 12), x = c(25, 63, 87, 35, 29),
                   beta_0 = 42, beta_1 = 5) == 362500)

# 3) Check values that are output.
# Check values that are output.
print(sum_sq_resid(y = c(23, 14, 16, 18, 11), x = c(31, 61, 29, 12, 15),
                   beta_0 = 9, beta_1 = 10))
# Test output against expected answer.
print(sum_sq_resid(y = c(23, 14, 16, 18, 11), x = c(31, 61, 29, 12, 15),
                   beta_0 = 9, beta_1 = 10) == 567955)


print("Q1 library testing complete.")



################################################################################
# End
################################################################################

