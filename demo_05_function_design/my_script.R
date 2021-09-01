
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

# Set working directory, if calling from another location.
# wd_path <- '~/Teaching/QMB6358_Fall_2020/GitRepos/QMB6358F20/demo_06_function_design'
# setwd(wd_path)


# Load your source code for the library of functions.
source("my_library.R")
# Be sure that this library is located in the working directory.
# Otherwise, you can include the path.


################################################################################
# Testing Functions
################################################################################


print("Testing function addTwoNumbers:")

print(addTwoNumbers(3,4))
print(addTwoNumbers(3,4) == 7)

print(addTwoNumbers(0,4))
print(addTwoNumbers(0,4) == 4)

print(addTwoNumbers(-3,3))
print(addTwoNumbers(-3,3) == 0)



print("Testing function addThreeNumbers:")

print(addThreeNumbers(3,4,2))
print(addThreeNumbers(3,4,2) == 9)

print(addThreeNumbers(0,4,8))
print(addThreeNumbers(0,4,8) == 12)

print(addThreeNumbers(-6,3,3))
print(addThreeNumbers(-6,3,3) == 0)



print("my_script complete.")



################################################################################
# End
################################################################################


