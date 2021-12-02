# -*- coding: utf-8 -*-
"""
##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# Sample Program for "Assignment 9"
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# December 1, 2021
#
##################################################
"""




##################################################
# Import Modules.
##################################################


import os # To set working directory
# import numpy as np # Not needed here but often useful
import pandas as pd # To read and inspect data
# from sklearn.linear_model import LinearRegression

import statsmodels.formula.api as sm # Another way to estimate linear regression



##################################################
# Set Working Directory.
##################################################



# Find out the current directory.
os.getcwd()
# Change to a new directory.
git_path = 'C:\\Users\\le279259\\OneDrive - University of Central Florida\\Documents\\Teaching\\QMB6358_Fall_2021\\GitRepo\\QMB6358F21\\'
os.chdir(git_path + 'demo_20_review')
# Check that the change was successful.
os.getcwd()



##################################################
# Load Data for Question 1.
##################################################


airplane_sales = pd.read_csv('airplane_sales.csv')


# Calculate summary statistics for your data.
airplane_sales.describe()



##################################################
# Linear Regression
##################################################



#--------------------------------------------------
# Fit the Regression Model (with statsmodels module instead).
#--------------------------------------------------

# Fit the regression model.
reg_model_full_sm = sm.ols(formula = "price ~ age", 
                           data = airplane_sales).fit()

# Display the parameters.
print(reg_model_full_sm.params)


# Display a summary table of regression results.
print(reg_model_full_sm.summary())



##################################################
# Load Data for Question 2.
##################################################


airplane_specs = pd.read_csv('airplane_specs.csv')


# Calculate summary statistics for your data.
airplane_specs.describe()


# Are the files in the same order?

airplane_sales.head()
airplane_specs.head()
airplane_sales.tail()
airplane_specs.tail()
# Not in same order.


# import sqlite3


# # Open the database from the previous session.
# con = sqlite3.connect('airplanes.db')
# # In this case, the database is already populated from the last demo.
# # Copy the file "population.db" to this folder to continue.

# # Create a cursor object from which to execute
# # SQL commands.
# cur = con.cursor()


# # Create another table to experiment with joins.
# cur.execute('''CREATE TABLE Sales(SaleID TEXT, Price REAL, Age REAL)''')
# # cur.execute('''DROP TABLE Sales''')


# airplane_sales_trim = pd.read_csv('airplane_sales_trim.csv')


# for row in airplane_sales_trim:
#  cur.execute('INSERT INTO Sales VALUES (?, ?, ?)', row)
# con.commit()



airplane_sales_sort = pd.read_csv('airplane_sales_sort.csv')
airplane_specs_sort = pd.read_csv('airplane_specs_sort.csv')




airplane_sales_specs = pd.concat([airplane_sales_sort, 
                                  airplane_specs_sort], 
                                 axis = 1)

airplane_sales_specs.describe()


airplane_sales_specs.rename(columns={'pass':'pass_2'}, 
                            inplace = True)


#--------------------------------------------------
# Fit the Regression Model (with statsmodels module instead).
#--------------------------------------------------

# Fit the regression model.
reg_model_full_sm = sm.ols(formula = "price ~ age + pass_2 + wtop + fixgear + tdrag", 
                           data = airplane_sales_specs).fit()

# Display the parameters.
print(reg_model_full_sm.params)


# Display a summary table of regression results.
print(reg_model_full_sm.summary())






##################################################
# Load Data for Question 3.
##################################################


airplane_perf_sort = pd.read_csv('airplane_perf_sort.csv')


# Calculate summary statistics for your data.
airplane_perf_sort.describe()




airplane_full = pd.concat([airplane_sales_specs, 
                           airplane_perf_sort], 
                          axis = 1)

airplane_full.describe()



#--------------------------------------------------
# Fit the Regression Model (with statsmodels module instead).
#--------------------------------------------------

# Fit the regression model.
reg_model_full_sm = sm.ols(formula = "price ~ age + pass_2 + wtop + fixgear + tdrag + horse + fuel + ceiling + cruise", 
                           data = airplane_full).fit()

# Display the parameters.
print(reg_model_full_sm.params)


# Display a summary table of regression results.
print(reg_model_full_sm.summary())




##################################################
# Optimize Function for Question 5.
##################################################


def ssr(beta, y, x1):
    return sum((y - beta[0] - beta[1]*x1)**2)


# Fit the regression model.
reg_model_full_sm = sm.ols(formula = "price ~ age", 
                           data = airplane_sales).fit()

# Display the parameters.
print(reg_model_full_sm.params)


# Display a summary table of regression results.
print(reg_model_full_sm.summary())




ssr(beta = reg_model_full_sm.params, 
    y = airplane_sales['price'], 
    x1 = airplane_sales['age'])

sum(reg_model_full_sm.resid**2)


import math
math.sqrt(ssr(beta = reg_model_full_sm.params, 
    y = airplane_sales['price'], 
    x1 = airplane_sales['age']))

y = airplane_sales['price']
x1 = airplane_sales['age']

import numpy as np
# Import scipy package for optimization
# from scipy import optimize
from scipy.optimize import minimize

beta_0 = np.zeros(len(reg_model_full_sm.params))
soln_bfgs = minimize(fun = ssr, x0 = beta_0, args = (y, x1), 
                     method = 'BFGS', 
                     options = {'xtol': 1e-8, 'maxiter': 1000, 'disp': True})


# The parameters:
print(soln_bfgs.x)
# Compare with the estimates from logit_model_fit_sm:
print(reg_model_full_sm.params)





