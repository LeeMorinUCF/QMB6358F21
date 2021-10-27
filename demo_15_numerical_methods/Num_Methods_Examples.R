
################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Examples of Numerical Methods in R
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# October 29, 2020
#
################################################################################
#
# This program provides introductory examples of numerical methods
# including solving systems of equations, root finding and optimization.
#
#
#
################################################################################

# Clear workspace.
# The remove function removes everything in the workspace when the list is all.
rm(list=ls(all=TRUE))

# Load library of functions.
# source('MyRcode1.R')

# Load packages.
# library(name_of_R_package_goes_here)


# Set working directory.
# wd_path <- '/path/to/your/folder'
# Not required, since this program does not interact with other files.
# setwd(wd_path)



################################################################################
# Solving systems of linear equations
################################################################################

#--------------------------------------------------
# 2-dimensional system of equations.
#--------------------------------------------------

# Create a matrix and a vector.
A <- matrix(c(2, 2, 5, 10),
            nrow = 2,
            ncol = 2)
x <- matrix(c(1, 2),
            nrow = 2,
            ncol = 1)

A
x

# Matrix multiplication is denoted by the %*% operator.
b <- A %*% x

b

# Calculate the inverse of A.
A_inv <- solve(A)

# Compare with A:
A
A_inv

# Multiply them together to show that it is an inverse:
A_inv %*% A
A %*% A_inv


# Compare the inverse with the determinant of A:
A_inv
# The determinant is in the denominator of the elements of the inverse.
det(A)
# A solution exists if and only if this determinant is nonzero.

# Solve by multiplying b with the inverse.
x_soln_inv <- A_inv %*% b
x_soln_inv

# Now use the solve function to solve for x.
x_soln <- solve(A, b)
# Example: In OLS beta_hat <- solve(A, b)


# Compare with the original x:
x
x_soln


#--------------------------------------------------
# 3-dimensional system of equations.
#--------------------------------------------------

# State the matrix and vector
# in the linear system to solve.
A_1 <- matrix(c(120, 300, 240,  # First column
                 60, 240, 120,  # Second column
                120, 360,  60), # Third column
              nrow = 3,
              ncol = 3)
b_1 <- matrix(c(80, 245, 115),
              nrow = 3,
              ncol = 1)

# Now use the solve function to solve for x.
x_1_soln <- solve(A_1, b_1)

# Verify the solution.
A_1 %*% x_1_soln # Matches b_1


# A less efficient way is to calculate the inverse first.
# Then multiply to solve.
A_1_inv <- solve(A_1)
x_1_soln_w_inv <- A_1_inv %*% b_1


################################################################################
# Solving Nonlinear equations
################################################################################

#--------------------------------------------------
# Single variable equations
#--------------------------------------------------

# Define the function.
# Goal: Find the root of this function.
f <- function(x) log(x) - exp(-x)
# That is, find the x at which this function is zero.

x_grid <- seq(0.1, 2.0, by = 0.01)
plot(x_grid, f(x_grid),
     main = 'Finding a Root',
     xlab = 'x', ylab = 'f(x)',
     col = 'blue', type = 'l')
abline(h = 0)


# Solution:
f_soln <- uniroot(f, c(0, 2), tol = 0.0001)
f_soln


# How to deal with an additional parameter.
f_with_a <- function (x, a) {x - a}
f_with_a_soln <- uniroot(f_with_a, c(0, 1), tol = 0.0001, a = 1/3)
f_with_a_soln

# Plot.
x_grid <- seq(0.0, 1.0, by = 0.01)
plot(x_grid, f_with_a(x = x_grid, a = 1/3),
     main = 'Roots and fixed points of f(x) = x - a',
     xlab = 'x',
     ylab = 'f(x) = x - a',
     ylim = c(-1, 2),
     type = 'l', lwd = 2, col = 'red')
lines(x_grid, rep(0, length(x_grid)), lwd = 1, col = 'black')
lines(rep(f_with_a_soln$root, length(x_grid)),
      seq(-1, 2, length.out = length(x_grid)),
      lwd = 2, col = 'black')


# Illustration of effect of tolerance level.

# Handheld calculator example: fixed point of cos(.):
uniroot(function(x) {cos(x) - x}, lower = -pi, upper = pi, tol = 1e-9)$root
# Compare with fewer decimal points of accuracy.
uniroot(function(x) {cos(x) - x}, lower = -pi, upper = pi, tol = 0.001)$root



# Two additional parameters.
f2_with_ab <- function (x, a, b) {(x - a)^2 - b}
f2_with_ab_soln <- uniroot(f2_with_ab, interval = c(-100, 4), tol = 0.0001,
                           a = 3, b = 4)
f2_with_ab_soln


# Giving it other directions.
f2_with_ab_other_soln <- uniroot(f2_with_ab, interval = c(3, 10), tol = 0.0001,
                                 a = 3, b = 4)
f2_with_ab_other_soln

# Giving it the wrong directions.
f2_with_ab_wrong_soln <- uniroot(f2_with_ab, interval = c(6, 10), tol = 0.0001,
                                 a = 3, b = 4)
f2_with_ab_wrong_soln


# Giving it the wrong directions.
f2_with_ab_multiple_soln <- uniroot(f2_with_ab, interval = c(0, 10), tol = 0.0001,
                                 a = 3, b = 4)
f2_with_ab_multiple_soln


# Plot.
x_grid <- seq(0.0, 6.0, by = 0.01)
plot(x_grid, f2_with_ab(x = x_grid, a = 3, b = 4),
     main = 'Roots and fixed points of f(x) = (x - a)^2 - b',
     xlab = 'x',
     ylab = 'f(x) = (x - a)^2 - b',
     # ylim = c(-1, 2),
     type = 'l', lwd = 2, col = 'red')
lines(x_grid, rep(0, length(x_grid)), lwd = 1, col = 'black')
lines(rep(f2_with_ab_soln$root, length(x_grid)),
      seq(-4.0, 5.0, length.out = length(x_grid)),
      lwd = 2, col = 'black')



#--------------------------------------------------
# Multiple variable equations
#--------------------------------------------------

# install.packages('rootSolve')
library(rootSolve)

# =======================================================================
# Example 1
# 2 simultaneous equations
# =======================================================================

# Define a multivariate function.
model_2 <- function(x) {

  F1 <- x[1]^2+ x[2]^2 -1
  F2 <- x[1]^2- x[2]^2 +0.5

  return(c(F1 = F1, F2 = F2))
}

# Test it at some values of x.
model_2(x = c(1, 2))
model_2(x = c(1, 1))
# Use this to get an idea of where to start.

# Obtain the root with multiroot.
soln_2 <- multiroot(f = model_2, start = c(1, 1))

# Verify that the solution is a root.
model_2(x = soln_2$root)
# Close to zero (numerically).


# =======================================================================
# example 2
# 3 equations, two solutions
# =======================================================================

model_32 <- function(x) c(F1 = x[1] + x[2] + x[3]^2 - 12,
                       F2 = x[1]^2 - x[2] + x[3] - 2,
                       F3 = 2 * x[1] - x[2]^2 + x[3] - 1 )

model_32(c(1, 1, 1))
model_32(c(0, 0, 0))
model_32(c(1, 2, 3))

# first solution
soln_32 <- multiroot(model_32, c(1, 1, 1), useFortran = FALSE)
soln_32 <- multiroot(f = model_32, start = c(1, 1, 1))

# second solution; use different start values
soln_32 <- multiroot(model_32, c(0, 0, 0))
model_32(soln_32$root)


# =======================================================================
# example 2b: same, but with parameters
# 3 equations, two solutions
# =======================================================================

model_2b <- function(x, parms)
  c(F1 = x[1] + x[2] + x[3]^2 - parms[1],
    F2 = x[1]^2 - x[2] + x[3] - parms[2],
    F3 = 2 * x[1] - x[2]^2 + x[3] - parms[3])

# Set parameter values.
parms <- c(12, 2, 1)

# Test values.
model_2b(c(1, 1, 1), parms)


# Sole the system.
multiroot(model_2b, c(1, 1, 1), parms = parms)



# Try another problem with different parameter values
# (and different starting values).
model_2b(c(0, 0, 0), parms*2)
multiroot(model_2b, c(0, 0, 0), parms = parms*2)



# =======================================================================
# example 3: find a matrix
# =======================================================================

# Find a matrix X such that X^3 = A
# where A = matrix(nrow = 5, data = 1:25, byrow = TRUE)
# This is a cubic polynomial in 25 variables.

f2 <- function(x)   {
  X <- matrix(nrow = 5, x)
  X %*% X %*% X - matrix(nrow = 5, data = 1:25, byrow = TRUE)
}
x <- multiroot(f2, start = 1:25 )$root # One long vector.
X <- matrix(nrow = 5, x) # Convert it to a matrix.

# Verify the solution.
# 1. By direct computation
X%*%X%*%X
# 2. By evaluating the function.
f2(X)


################################################################################
# Optimization
################################################################################

#--------------------------------------------------
# Single variable equations
#--------------------------------------------------

f <- function (x, a) (x - a)^2
xmin <- optimize(f, c(0, 1), tol = 0.0001, a = 1/3)
xmin


# You can make your function print out a progress report to see the iterations.
# Get the function to print to see where the function is evaluated:
optimize(function(x) x^2*(print(x)-1), lower = 0, upper = 10)


# Now try a problem that is numerically challenging.
# "wrong" solution with unlucky interval and piecewise constant f():
f  <- function(x) ifelse(x > -1, ifelse(x < 4, exp(-1/abs(x - 1)), 10), 10)
fp <- function(x) { print(x); f(x) }

# Plot it to see what is going on.
plot(f, -2,5, ylim = 0:1, col = 'red', lwd = 2)
plot(f, xlim = c(-2,5), ylim = c(0,10), col = 'red', lwd = 2)
optimize(fp, c(-4, 20))   # doesn't see the minimum
optimize(fp, c(-7, 20))   # ok
# If you know the solution is in a particular range,
# the algorithm will work better:
optimize(fp, c(0, 2))
optimize(fp, c(0.9, 1.2))
# In some spots, it won't find the solution.
optimize(fp, c(5, 12))



#--------------------------------------------------
# Multiple variable equations
#--------------------------------------------------

# The Rosenbrock "Banana" function is a good example.
f_banana <- function(x) {
  x1 <- x[1]
  x2 <- x[2]
  100 * (x2 - x1 * x1)^2 + (1 - x1)^2
}
# Supply the calculation of the gradient to improve optimization.
# Gradient means a vector of first derivatives.
gr_banana <- function(x) { ## Gradient of 'fr'
  x1 <- x[1]
  x2 <- x[2]
  c(-400 * x1 * (x2 - x1 * x1) - 2 * (1 - x1), # Dx_1
    200 *      (x2 - x1 * x1))# Dx_2
}

# Optimize the function itself.
optim(c(-1.2,1), f_banana)

# Optimize with vector of derivatives (the BFGS algorithm is a quasi-Newton method).
soln_banana <- optim(c(-1.2,1), f_banana, gr_banana, method = "BFGS")


# There are many algorithms to perform the solution.
# In practice, you might try several, to make sure
# that your "solution" is in fact an optimum.
# Compare with other algorithms:
# This calculates the Hessian (second derivatives):
optimHess(soln_banana$par, f_banana, gr_banana)
# It is calculated with the hessian = TRUE argument.
optim(c(-1.2,1), f_banana, NULL, method = "BFGS", hessian = TRUE)


## These do not converge in the default number of steps
optim(c(-1.2,1), f_banana, gr_banana, method = "CG")
optim(c(-1.2,1), f_banana, gr_banana, method = "CG", control = list(type = 2))
optim(c(-1.2,1), f_banana, gr_banana, method = "L-BFGS-B")
# But most of them are close.


#--------------------------------------------------
# Multivariate optimization with constraints
#--------------------------------------------------

# Consider another function.
f_bound <- function(x) {
  p <- length(x); sum(c(1, rep(4, p-1)) * (x - c(1, x[-p])^2)^2)
}

# 25-dimensional box constrained
optim(rep(3, 25), f_bound, NULL, method = "L-BFGS-B",
      lower = rep(2, 25), upper = rep(4, 25)) # par[24] is *not* at boundary


# One more challenging function.
# "wild" function , global minimum at about -15.81515

f_wild <- function (x) {
  10*sin(0.3*x)*sin(1.3*x^2) + 0.00001*x^4 + 0.2*x+80
}
plot(f_wild, -50, 50, n = 1000, main = "optim() minimising 'wild function'")

soln_wild <- optim(50, f_wild, method = "SANN",
             control = list(maxit = 20000, temp = 20, parscale = 20))
soln_wild

# Now improve locally {typically only by a small bit}:
soln_wild_2 <- optim(soln_wild$par, f_wild, method = "BFGS")


# Plot the optimum over the plot of the function.
points(soln_wild_2$par,  soln_wild_2$value,  pch = 8, col = "red", cex = 2)



################################################################################
# End
################################################################################


