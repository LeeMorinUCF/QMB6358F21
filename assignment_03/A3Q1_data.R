
################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Assignment 3: Data Handling
#
# Name:
# College of Business
# University of Central Florida
#
# Date:
#
################################################################################
#
# This program reads a collection of small datasets to practice handling data.
# It is a sample of the script for Assignment 3, Question 1.
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


# Set working directory to the path containing the csv files.
# wd_path <- "/path/to/your/data/folder
wd_path <- "~/Teaching/QMB6358_Fall_2021/Assignments/assignment_03"
setwd(wd_path)


# Set paths to other folders.
# data_path <- sprintf('%s/data', wd_path) # If data within same folder.
# Optional: Organize data in a separate folder for larger projects.
# Directory for separate data repository.
data_path <- '~/Teaching/QMB6358_Fall_2021/Assignments/assignment_03/QMB6358_car_auction_data'


################################################################################
# Reading data from csv files.
################################################################################



# Initialize with an empty object.
A3Q1_data <- NULL

# Read files over a loop.
for (iterator in list_of_iterators) {


    # Set the filename.

    # A3Q1a) Print filename.


    # Read this file to a temporary data frame.
    # A3Q1_data_sample <- some_command(...)

    # A3Q1b) Print table of counts of observations
    # for damage and accident status (to test file reading).
    # print(table(...))

    # A3Q1c) Append this file to the full dataset.
    # A3Q1_data <- other_command(...)

}




################################################################################
# Testing dataset from Question 1
################################################################################


print("Contents of Dataset for Question 1:")

# Print some statistics about the full dataset
# to verify the content.
print("Dimensions of dataset:")
print(dim(A3Q1_data))

print("Summary of variables:")
print(summary(A3Q1_data))

print("Counts by accident and damage status:")
print(table(A3Q1_data[, 'accident'],
            A3Q1_data[, 'damage'], useNA = 'ifany'))


################################################################################
# End
################################################################################

