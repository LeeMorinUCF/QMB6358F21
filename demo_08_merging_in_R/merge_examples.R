##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# Merging datasets
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# September 21, 2020
#
##################################################
#
# merge_examples gives examples of
#   joining data in the common types of joins.
#
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))


# Set path for working directory.
wd_path <- "~/Teaching/QMB6358_Fall_2021/GitRepo/QMB6358F21/demo_08_merging_in_R"
setwd(wd_path)



##################################################
# Loading Data
##################################################

# Read the tables.
Employees <- read.csv('Employees.csv')
Departments <- read.csv('Departments.csv')
# Departments <- read.csv('Departments_copy.csv')



##################################################
# Merging data sets
##################################################


# INNER JOIN

inner_merge <- merge(Employees, Departments)
inner_merge
# Take attendance and see who is missing.


# LEFT OUTER JOIN

left_outer_merge <- merge(Employees, Departments, all.x = TRUE)
left_outer_merge



# RIGHT OUTER JOIN

right_outer_merge <- merge(Employees, Departments, all.y = TRUE)
right_outer_merge



# FULL OUTER JOIN

full_outer_merge <- merge(Employees, Departments, all = TRUE)
full_outer_merge




##################################################
# End
##################################################
