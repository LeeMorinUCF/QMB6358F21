##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# OLS Regression Demo
# Regression with Data Entered Directly into the Script
#
# Name:
# College of Business Administration
# University of Central Florida
#
# Date:
#
##################################################
#
# regression_calculation gives an example of OLS regression
#   using data entered within this script.
#   It includes exercises to calculate the OLS
#   estimates from direct calculation and optimization.
#
# Dependencies:
#   None.
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
# wd_path <- '/path/to/your/folder'
# Not required, since this program does not interact with other files.

# setwd(wd_path)

# No libraries required.
# Otherwise would have a command like the following.
# library(name_of_R_package)


##################################################
# Enter the dataset and run regression
##################################################

# Enter the numbers in the dataset.
income_data  <- c(14, 18, 18, 16, 16, 26, 20, 18, 20, 22)
agg_pct_data <- c(9, 10, 8, 7, 10, 4, 5, 5, 6, 7)
agg_data <- data.frame(income = income_data,
                       agg_pct = agg_pct_data)

# Inspect the data.
summary(agg_data)

# Plot a scattergraph of income and housing prices.
plot(agg_data[, 'income'],
     agg_data[, 'agg_pct'],
     main = 'Aggregate Income vs. Pct. in Agriculture',
     xlab = 'Income',
     ylab = 'Pct. in Agriculture',
     col = 'blue',
     pch = 16)



# Estimate a regression model.
lm_model <- lm(data = agg_data,
               formula = income ~ agg_pct)

# Output the results to screen.
summary(lm_model)

# My answers:
# lm(formula = income ~ agg_pct, data = agg_data)
#
# Residuals:
#   Min      1Q  Median      3Q     Max
# -3.1002 -2.3142  0.0905  1.8765  3.8044
#
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)
# (Intercept)  26.5770     3.0685   8.661 2.45e-05 ***
#   agg_pct      -1.0954     0.4156  -2.635   0.0299 *
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#
# Residual standard error: 2.658 on 8 degrees of freedom
# Multiple R-squared:  0.4647,	Adjusted R-squared:  0.3978
# F-statistic: 6.945 on 1 and 8 DF,  p-value: 0.02993
#
# >
# beta_0 is 26.5770
# beta_1 is -1.0954

# Store the estimated coefficients.
# Available here:
beta_hat_lm <- summary(lm_model)$coefficients[, 'Estimate']
# Or here:
beta_hat_lm <- coef(lm_model)

print(beta_hat_lm)


##################################################
# Estimating beta from direct calculation
##################################################

# Calculate the estimate of the coefficients above.

# Define the variables y and x.
y <- agg_data[, 'income']
x <- agg_data[, 'agg_pct']


# Calculate the slope coefficient from the formula:
beta_1_hat_calc <- NA


# Calculate the intercept from the formula:
beta_0_hat_calc <- NA





# Compare with the output above.
beta_hat_calc <- c(beta_0_hat_calc, beta_1_hat_calc)
print(beta_hat_calc)



##################################################
# Estimating beta from solving equations
##################################################

# Part i: Define matrices for normal equations.

A = NA
b = NA


# Part ii: Solve the equations for beta.

beta_hat_norm <- NA



# Compare with the output above.
print(beta_hat_norm)


##################################################
# Estimating beta from optimization
##################################################

# Part i: Sum of Squared residuals.

# Note that beta is a vector of two coefficients.

# Notation to match f(x, a, b) in demo.
# where f() -> ssr(), x -> beta, a -> y, b -> x




# Test the function to math the regression summary.
beta_test_ssr <- c(coef(lm_model)['(Intercept)'],
                   coef(lm_model)['agg_pct'])
sqrt(ssr(beta_test_ssr, y, x)/8)
# Should get:
# Residual standard error: 2.658





# Part ii: Optimize the SSR function w.r.t. beta.

beta_hat_opt <- NA


# Extract the parameter estimates.
beta_hat_opt <- beta_hat_opt$par

# Compare with the output above.
print(beta_hat_opt)


##################################################
# End
##################################################
