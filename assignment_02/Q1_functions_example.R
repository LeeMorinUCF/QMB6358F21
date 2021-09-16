
################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Library of R Functions for Assignment 2
#
# Name: April Henry
# College of Business
# University of Central Florida
#
# Date: 09/14/2021
#
################################################################################
#
# This program is a library of R functions for Assignment 2.
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
# at the command line,
# instead of within the library.
# install.packages("package_name_goes_here")


################################################################################
# Functions
################################################################################

#--------------------------------------------------------------------------------
# Part a) Variance of one variable
#--------------------------------------------------------------------------------

# var_x is a function that sums the squared difference between each value of
# vector x and the mean of vector x and divides it by the number of values in
# vector x less 1 to adjust for the bias in sampling estimates.  This is called
# the sample variance.

var_x <- function(x) {
  (sum(((x - mean(x, trim = 0, na.rm = FALSE))^2),nar.rm = FALSE)) /
    (length(x) - 1 ) }


#--------------------------------------------------------------------------------
# Part b) Covariance between two variables
#--------------------------------------------------------------------------------

# The covariance function (covar_y_x) takes the differences between each of the
# vector y values and the vector y mean, and multiplies it by the difference
# between each corresponding vector x value and the vector x mean.
# Then the function sums the products and divides that total by the sample size
# of vector y (length) less one.  This function only works in cases where
# vector y and vector x are the same length.

covar_y_x <- function(y, x) {
  (sum((y - (mean(y, trim = 0, na.rm = FALSE))) *
         (x - (mean(x, trim = 0, na.rm = FALSE))),nar.rm = FALSE)) /
    (length(y) - 1 ) }


#--------------------------------------------------------------------------------
# Part c) OLS slope coefficient
#--------------------------------------------------------------------------------

# The Ordinary Least Squares slope_y_x function takes the differences between each
# vector y value and the vector y mean multiplied by the differences between each
# of the vector x values and the vector x mean and sums those products.
# Then the function divides that sum by sum of the squared difference between
# each value of vector x and the mean of vector x.

slope_y_x <- function(y, x) {
  ((sum((y - (mean(y, trim = 0, na.rm = FALSE))) *
     (x - (mean(x, trim = 0, na.rm = FALSE))),nar.rm = FALSE)) /
    (sum(((x - mean(x, trim = 0, na.rm = FALSE))^2),nar.rm = FALSE)))
  }


#--------------------------------------------------------------------------------
# Part d) Sum of squared residuals
#--------------------------------------------------------------------------------

# The residual sum of squares function (sum_sq_resid) calculates the squared
# difference between vector y values, beta_0, and the product of beta_1 and the
# x vector values.

sum_sq_resid <- function(x, y, beta_0, beta_1) {
  sum(((y - beta_0 - (beta_1 * x))^2),nar.rm = FALSE) }


################################################################################
# End
################################################################################
