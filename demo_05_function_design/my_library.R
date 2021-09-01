
################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Example of a Library of R Functions
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# August 29, 2020
#
################################################################################
#
# This program provides an example of a library of R functions.
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


################################################################################
# Functions
################################################################################




addTwoNumbers <- function(first_number, second_number) {

  #' Add Two Numbers
  #'
  #' \code{addTwoNumbers} adds two numbers together and returns the sum.
  #'
  #' @param first_number a number
  #' @param second_number another number
  #' @return a numeric sum of two numbers

  total <- first_number + second_number

  return(total)
}


addThreeNumbers <- function(first_number, second_number, third_number) {

  #' Add Three Numbers
  #'
  #' \code{addTwoNumbers} adds two numbers together and returns the sum.
  #'
  #' @param first_number a number
  #' @param second_number another number
  #' @param third_number yet another number
  #' @return a numeric sum of two numbers

  total <- first_number + second_number + third_number

  return(total)
}



################################################################################
# End
################################################################################


