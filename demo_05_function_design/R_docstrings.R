
################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Docstrings to Document R Functions
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
# This program provides examples of R code that demonstrate how to
# define functions in a way to automatically produce documentation.
#
#
#
################################################################################



################################################################################
# Load Packages
################################################################################

# Install the docstring package to produce documentation for functions
# from comments called docstrings within functions.
# install.packages("docstring")
library(docstring)


################################################################################
# Functions
################################################################################


# Define a function.

addTwoNumbers <- function(first_number, second_number) {

  total <- first_number + second_number

  return(total)
}


addTwoNumbers(3,4)


# Search for documentation, as you would for any other function.
?addTwoNumbers
# There's nothing there yet.

# You could print the entire function object but that
# is not very convenient.
addTwoNumbers


# Instead, add documentation to the function in a docstring.


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

# Now test the documentation by calling for help:

?addTwoNumbers

# or

help(addTwoNumbers)

# and you should see the documentation appear in the "Help" window.




################################################################################
# End
################################################################################


