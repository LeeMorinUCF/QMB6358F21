
# Example of how to plot data after
# getting results from a logistic regression.
# Adapted from examples found here:
# https://www.dataanalytics.org.uk/plot-two-overlapping-histograms-on-one-chart-in-r/#:~:text=In%20order%20to%20plot%20two%20histograms%20on%20one,a%20named%20object%20you%20can%20plot%20it%20later.

# Build a sample dataset.
set.seed(42)
num_obs <- 1000
my_data <- data.frame(random = runif(num_obs))

# Generate a binary outcome.
my_data[, 'y'] <- my_data[, 'random'] > 0.5

# Generate a distribution for Y = 1 and Y = 0.
my_data[, 'x1'] <- NA
my_data[my_data[, 'y'] == 0, 'x1'] <- rnorm(n = sum(my_data[, 'y'] == 0),
                                            mean = 0)
my_data[my_data[, 'y'] == 1, 'x1'] <- rnorm(n = sum(my_data[, 'y'] == 1),
                                            mean = 2)
# Generate another variable with no predictive value.
my_data[, 'x2'] <- rnorm(n = num_obs, mean = 2)

summary(my_data)

# Run a regression (although I already know the answer).
my_logit <- glm(data = my_data, formula = y ~ x1 + x2,
                family = 'binomial')
summary(my_logit)
# Looks like x1 is the winner.

# Plot the result.

# First create the plot objects:
hist0 <- hist(my_data[my_data[, 'y'] == 0, 'x1'],
              breaks = seq(-4, 6, length.out = round(sqrt(num_obs))),
              plot = FALSE)
hist1 <- hist(my_data[my_data[, 'y'] == 1, 'x1'],
              breaks = seq(-4, 6, length.out = round(sqrt(num_obs))),
              plot = FALSE)

plot(hist0,
     col = 'blue',
     main = 'Distribution of my binary outcome by x1',
     xlab = 'x1',
     xlim = c(-5, 7),
     ylim = c(0, 100))
plot(hist1,
     col = 'red',
     add = TRUE)




