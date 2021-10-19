##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# OLS Regression Demo
# Regression with Data from Spreadsheet
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# October 17, 2020
#
##################################################
#
# House_Price_Reg gives an example of OLS regression
#   using data imported from a spreadsheet.
#   It automatically generates figures and tables for a
#   pdf document built with LaTeX.
#
# Dependencies:
#   The xtable library to create tex scripts for tables.
#   The texreg library to create tex scripts for tables from
#   regression models.
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
# wd_path <- '/path/to/your/folder'
# wd_path <- 'C:/Users/le279259/Teaching/QMB6358_Fall_2020/GitRepos/QMB6358F20/demo_14_R_file_IO/LaTeX_from_R'
# setwd(wd_path)


# It's not necessary to set the directory, since we are working in the
# main directory already: that's where the shell script is running.


# Set data directory.
data_dir <- 'Data'

# Set directory for storing figures.
fig_dir <- 'Figures'

# Set directory for storing tables.
tab_dir <- 'Tables'

# Set directory for storing text.
text_dir <- 'Text'


# Load libraries.

# The xtable library creates tex scripts for tables.
# install.packages("xtable")
library(xtable)
# The texreg library creates tex scripts for tables from
# regression models.
# install.packages("texreg")
library(texreg)


##################################################
# Load Data
##################################################

# Read the newly saved dataset.
data_file_path <- sprintf('%s/housing_data.csv', data_dir)
housing_data <- read.csv(file = data_file_path)

# Inspect the data.
summary(housing_data)


##################################################
# Create Tables
##################################################


#--------------------------------------------------
# Summarize numeric variables.
#--------------------------------------------------

# Summarize numeric variables over the entire sample.
num_var_list <- colnames(housing_data)[lapply(housing_data, class) == 'numeric']
summary(housing_data[, num_var_list])


out_tab <- data.frame(matrix(nrow = 4, ncol = length(num_var_list) + 1))
colnames(out_tab) <- c('Statistic', num_var_list)
out_tab[, 'Statistic'] <- c('Min.', 'Mean', 'S.D.', 'Max.')
for (col_name in num_var_list) {
   out_tab[1, col_name] <- min(housing_data[, col_name])
   out_tab[2, col_name] <- mean(housing_data[, col_name])
   out_tab[3, col_name] <- sd(housing_data[, col_name])
   out_tab[4, col_name] <- max(housing_data[, col_name])
}


# Convert the table to a LaTex table.
out_xtable <- xtable(out_tab[, ],
                     digits = 2, label = 'tab:summary',
                     caption = 'Summary of Numeric Variables')

# Output to TeX file.
tab_file_name <- sprintf('%s/summary.tex', tab_dir)
cat(print(out_xtable), file = tab_file_name, append = FALSE)

#--------------------------------------------------
# Summarize categorical variables
#--------------------------------------------------




# Check that earthquakes occurred only in California:
table(housing_data[, 'in_cali'])
table(housing_data[, 'in_cali'], housing_data[, 'earthquake'])


# Create a table of counts of variables by state and earthquake incidence.
out_tab <- table(housing_data[, 'in_cali'], housing_data[, 'earthquake'])


# Add some column names.
rownames(out_tab) <- c('Other', 'California')
colnames(out_tab) <- c('None', 'Earthquake')



# Convert the table to a LaTex table.
out_xtable <- xtable(out_tab[, ],
                     digits = 2, label = 'tab:earthquakes',
                     caption = 'Earthquake Incidence by State')

# Output to TeX file.
tab_file_name <- sprintf('%s/earthquakes.tex', tab_dir)
cat(print(out_xtable), file = tab_file_name, append = FALSE)



#--------------------------------------------------
# Create table with correlation matrix
#--------------------------------------------------

# Calculate a correlation matrix for selected variables.
corr_var_names <- c('house_price', 'income', 'in_cali', 'earthquake')
corr_matrix <- cor(housing_data[, corr_var_names])
print(round(corr_matrix, 3))


# Convert the table to a LaTex table.
out_xtable <- xtable(corr_matrix[, ],
                     digits = 3, label = 'tab:corr',
                     caption = 'Correlation Matrix')

# Output to TeX file.
tab_file_name <- sprintf('%s/correlation.tex', tab_dir)
cat(print(out_xtable), file = tab_file_name, append = FALSE)




##################################################
# Plot Figures
##################################################


# Plot a scattergraph of income and housing prices.
plot(housing_data[, 'income'],
     housing_data[, 'house_price'],
     main = c('House Prices vs. Income', '(all figures in millions)'),
     xlab = 'Income',
     ylab = 'House Prices',
     col = 'blue')
# Not very exciting.
# Maybe another plot will look better.





##################################################
# Estimating the Regression Model
# Model 1: All Variables Included
##################################################

# Note the formula object:
# Y ~ X_1 + X_2 + X_3


# Estimate a regression model.
lm_full_model <- lm(data = housing_data,
                    formula = house_price ~ income + in_cali + earthquake)

# Output the results to screen.
summary(lm_full_model)


##################################################
# Output table with regression estimates.
##################################################

# The texreg package makes a LaTeX table from the regression results.

# Print the output to a LaTeX file.
tab_file_name <- 'lm_model_1.tex'
out_file_name <- sprintf('%s/%s', tab_dir, tab_file_name)
texreg(lm_full_model,
       digits = 3,
       file = out_file_name,
       label = 'tab:lm_model_1',
       caption = "Regression Model 1")




##################################################
# Output text describing regression model.
##################################################

# See what's inside the lm_full_model object:
class(lm_full_model)
attributes(lm_full_model)

lm_full_model$coefficients
lm_full_model$coefficients['income']
lm_full_model$coefficients[2]

coef(lm_full_model)



# Model predictions:
summary(predict(lm_full_model))
housing_data[, 'predictions'] <- predict(lm_full_model)

# Other statistics are stored in the model.
attributes(summary(lm_full_model))

# The summary also returns statistics, such as R-squared.
lm_full_model_summ <- summary(lm_full_model)
lm_full_model_summ$adj.r.squared


# Create a script for a write-up about the parameters and statistics
# in the model.
# (I admit that this level of automation is a bit much
# but it highlights the possibilities.)

text_file_name <- 'regression.tex'
out_file_name <- sprintf('%s/%s', text_dir, text_file_name)
# Start a new file with append = FALSE.
cat('\n%% Regression model description:\n\n',
    file = out_file_name, append = FALSE)

# Append new lines of text with append = TRUE.
cat('\n\nThe regression model predicts housing prices as follows \n',
    file = out_file_name, append = TRUE)
cat('(all figures in millions).\n',
    file = out_file_name, append = TRUE)
cat('For every one dollar increase in average income, housing prices are expected \n',
    file = out_file_name, append = TRUE)
cat(sprintf('to rise by %1.3f. \n', lm_full_model$coefficients['income']),
    file = out_file_name, append = TRUE)
cat('If the home is located in California, housing prices are expected \n',
    file = out_file_name, append = TRUE)
cat(sprintf('to be %1.3f higher. \n', lm_full_model$coefficients['in_cali']),
    file = out_file_name, append = TRUE)
cat('If there was an earthquake in the zip code, housing prices are expected \n',
    file = out_file_name, append = TRUE)
cat(sprintf('to be %1.3f lower. \n', lm_full_model$coefficients['earthquake']),
    file = out_file_name, append = TRUE)

# Include a summary of the quality of fit of the model.
cat('Overall, this model provides a fairly good description ',
    file = out_file_name, append = TRUE)
cat(sprintf('with an $R^2$ of %1.3f.\n\n', lm_full_model_summ$adj.r.squared),
    file = out_file_name, append = TRUE)


##################################################
# Plot regression results for selected model.
##################################################


# Calculate the predictions from the fitted model.
housing_data[, 'predictions'] <- predict(lm_full_model,
                                         newdata = housing_data)

summary(housing_data[, c('house_price', 'predictions')])

plot(housing_data[, c('house_price', 'predictions')],
     main = 'Regression Model Predictions',
     xlab = 'House Price',
     ylab = 'Prediction')


# So far the plot has printed to screen.
# Now use the setEPS and postscript functions to save the figure to a file.

fig_file_name <- 'predictions.eps'
out_file_name <- sprintf('%s/%s', fig_dir, fig_file_name)
setEPS()
postscript(out_file_name)

# Plot the actual house prices against the regression model predictions.
plot(housing_data[, 'house_price'], housing_data[, 'predictions'],
     main = 'Regression Model Predictions',
     xlab = 'House Price',
     ylab = 'Prediction', pch = 16)
points(housing_data[housing_data[, 'in_cali'] == 1, 'house_price'],
       housing_data[housing_data[, 'in_cali'] == 1, 'predictions'],
       col = 'green', pch = 16)
points(housing_data[housing_data[, 'earthquake'] == 1, 'house_price'],
       housing_data[housing_data[, 'earthquake'] == 1, 'predictions'],
       col = 'red', pch = 16)

dev.off()


##################################################
# Add some regression lines to compare
# the predictions to the actual observations.
##################################################

# Plot the actual house prices against the regression model predictions.
plot(housing_data[, 'income'], housing_data[, 'house_price'],
     main = 'Regression Model Predictions',
     xlab = 'Income',
     ylab = 'House Price', pch = 16)
points(housing_data[housing_data[, 'in_cali'] == 1, 'income'],
       housing_data[housing_data[, 'in_cali'] == 1, 'house_price'],
       col = 'green', pch = 16)
points(housing_data[housing_data[, 'earthquake'] == 1, 'income'],
       housing_data[housing_data[, 'earthquake'] == 1, 'house_price'],
       col = 'red', pch = 16)



# Use the lines() command to append to the above figure.
# You will need to create a vector of values on the line
# using the regression coefficients from the estimated model.

summary(lm_full_model)

coef(lm_full_model)
beta_0_hat <- coef(lm_full_model)['(Intercept)']
beta_income_hat <- coef(lm_full_model)['income']
beta_cali_hat <- coef(lm_full_model)['in_cali']
beta_earthquake_hat <- coef(lm_full_model)['earthquake']

# Draw a line for zip codes outside California.
income_grid <- seq(0.07, 0.13, by = 0.01)
reg_line_not_cali <- beta_0_hat + beta_income_hat*income_grid

lines(income_grid, reg_line_not_cali,
      lwd = 3, col = 'black')


# Repeat for California without earthquakes (green)
reg_line_in_cali <- beta_0_hat +
   beta_income_hat*income_grid +
   beta_cali_hat

lines(income_grid, reg_line_in_cali,
      lwd = 3, col = 'green')


# Repeat for California with earthquakes (red).
reg_line_earthquake <- beta_0_hat +
   beta_income_hat*income_grid +
   beta_cali_hat + beta_earthquake_hat

lines(income_grid, reg_line_earthquake,
      lwd = 3, col = 'red')


# Again, so far the plot has printed to screen.
# Now use the setEPS and postscript functions to save the figure to a file.

fig_file_name <- 'regression.eps'
out_file_name <- sprintf('%s/%s', fig_dir, fig_file_name)
setEPS()
postscript(out_file_name)

plot(housing_data[, 'income'], housing_data[, 'house_price'],
     main = 'Regression Model Predictions',
     xlab = 'Income',
     ylab = 'House Price', pch = 16)
points(housing_data[housing_data[, 'in_cali'] == 1, 'income'],
       housing_data[housing_data[, 'in_cali'] == 1, 'house_price'],
       col = 'green', pch = 16)
points(housing_data[housing_data[, 'earthquake'] == 1, 'income'],
       housing_data[housing_data[, 'earthquake'] == 1, 'house_price'],
       col = 'red', pch = 16)
# Plot regression lines.
lines(income_grid, reg_line_not_cali,
      lwd = 3, col = 'black')
lines(income_grid, reg_line_in_cali,
      lwd = 3, col = 'green')
lines(income_grid, reg_line_earthquake,
      lwd = 3, col = 'red')
# The dev.off() closes the file for the plot.
dev.off()


##################################################
# End
##################################################

