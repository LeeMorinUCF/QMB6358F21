# -*- coding: utf-8 -*-
"""
##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# Sample script for Assignment 6, Question 2
#
# Name: 
# College of Business Administration
# University of Central Florida
#
# Date:
#
#
##################################################
"""


##################################################
# Import Modules.
##################################################


import os # To set working directory
# import numpy as np # Not needed here but often useful
import pandas as pd # To read and inspect data
import statsmodels.formula.api as sm # Another way to estimate linear regression



##################################################
# Set Working Directory.
##################################################


# Find out the current directory.
os.getcwd()
# Change to a new directory.
os.chdir('C:\\Users\\le279259\\Documents\\Teaching\\QMB6358F21\\assignment_06')
# Check that the change was successful.
os.getcwd()



##################################################
# Get all observations from all 5 files
# by creating functions to read each file
# then read the data and collect in a 
# data frame called housing_full.
##################################################





# Replace this with the final dataset.
housing_full = pd.read_csv('housing_data/housing_data_1.csv')
# For now, this is just an example from Question 1
# to see what the result should look like. 






##################################################
# Inspect the final dataset
##################################################


# Calculate summary statistics for your data.
housing_full.describe()
# Use this to check whether your data handling is working correctly.


##################################################
# Fit the Regression Model
##################################################

# After the full dataset is obtained:

# Fit the regression model.
reg_model_full_sm = sm.ols(formula = "house_price ~ income + in_cali + earthquake", 
                           data = housing_full).fit()



# Display a summary table of regression results.
print(reg_model_full_sm.summary())





##################################################
# End
##################################################




