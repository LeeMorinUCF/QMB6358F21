
##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# Assignment 9
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business
# University of Central Florida
#
# December 1, 2021
#
##################################################



##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
# wd_path <- '/path/to/your/folder'
wd_path <- 'C:/Users/le279259/OneDrive - University of Central Florida/Documents/Teaching/QMB6358_Fall_2021/GitRepo/QMB6358F21/demo_20_review'

setwd(wd_path)

# Check folder:
getwd()



##################################################
# Read the dataset and run regression for Question 1
##################################################

# Read the newly saved dataset.
airplane_sales <- read.csv(file = 'airplane_sales.csv')

# Inspect the data.
summary(airplane_sales)


##################################################
# Estimating the Regression Model
# Model 1: All Variables Included
##################################################


# Estimate a regression model.
lm_model_1 <- lm(data = airplane_sales,
                    formula = price ~ age)

# Output the results to screen.
summary(lm_model_1)


##################################################
# Read the dataset and run regression for Question 2
##################################################

# Read the newly saved dataset.
airplane_specs <- read.csv(file = 'airplane_specs.csv')

# Inspect the data.
summary(airplane_specs)


airplane_sales_specs <- merge(x = airplane_sales,
                              y = airplane_specs,
                              by = 'X0Sale_ID')


summary(airplane_sales_specs)
colnames(airplane_sales_specs)

# Estimate a regression model.
lm_model_2 <- lm(data = airplane_sales_specs,
                 formula = price ~ age +
                 pass + wtop + fixgear + tdrag)

# Output the results to screen.
summary(lm_model_2)




##################################################
# Read the dataset and run regression for Question 3
##################################################

# Read the newly saved dataset.
airplane_perf <- read.csv(file = 'airplane_perf.csv')

# Inspect the data.
summary(airplane_perf)


airplane_full <- merge(x = airplane_sales_specs,
                       y = airplane_perf,
                       by = 'X0Sale_ID')


summary(airplane_full)

# Estimate a regression model.
lm_model_3 <- lm(data = airplane_full,
                 formula = price ~ age +
                   pass + wtop + fixgear + tdrag +
                   horse + fuel + ceiling + cruise )

# Output the results to screen.
summary(lm_model_3)



colnames(airplane_full)


log_list <- colnames(airplane_full)[c(3,2,8,9,10,11)]
for (var_name in log_list) {
  log_var_name <- sprintf('log_%s', var_name)
  airplane_full[, log_var_name] <- log(airplane_full[, var_name])
}

summary(airplane_full)



# Estimate a regression model.
lm_model_4 <- lm(data = airplane_full,
                 formula = log_price ~ log_age +
                   pass + wtop + fixgear + tdrag +
                   log_horse + log_fuel + log_ceiling + log_cruise)

# Output the results to screen.
summary(lm_model_4)



##################################################
# Question 5
##################################################

ssr <- function(beta, y, x) {
  return(sum((y - beta[1] - beta[2]*x)^2))
}



# Output the results to screen.
summary(lm_model_1)

sum(lm_model_1$residuals^2)

coef(lm_model_1)[1]
coef(lm_model_1)[2]

# Test the function to math the regression summary.
# beta_test_ssr <- c(coef(lm_model_1)['(Intercept)'],
#                    coef(lm_model_1)['age'])


sum(lm_model_1$residuals^2)

ssr(beta = coef(lm_model_1),
    y = airplane_full[, 'price'],
    x = airplane_full[, 'age'])

# Optimize the ssr function to obtain the estimates.
soln_ssr <- optim(c(0, 0), ssr,
                  y = airplane_full[, 'price'],
                  x = airplane_full[, 'age'])


print(soln_ssr)


# This is cheating:

# Optimize the ssr function to obtain the estimates.
soln_ssr <- optim(coef(lm_model_1), ssr,
                  y = airplane_full[, 'price'],
                  x = airplane_full[, 'age'])


print(soln_ssr)
# Closer but this is cheating by using the answer: coef(lm_model_1)

