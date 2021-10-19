#!/bin/bash

################################################################################
#
# QMB 6358: Software Tools for Business Analytics
# Shell Script for Sample Business Analytics Project
#
# Name:
# College of Business
# University of Central Florida
#
# Date:
#
################################################################################
#
# This shell script reads a dataset, summarizes the data, plots figures
#   and estimates a regression model. It creates files to collect these
#   results in a document built by LaTeX.
#
# Note: The top line tells where your bash program is located
#     and should match the result you get when you
#     type the command "which bash".
#     To run this script you have to navigate to this folder in
#     a terminal window, such as GitBash, and execute
#     ./my_shell_script.sh
#     where the name of the .sh file corresponds to the name of this file.
#
################################################################################

# Bash commands before running R
# e.g. making directory for output, etc.
echo "##################################################"
echo ""
echo "Running my Business Analytics Project..."
echo ""


################################################################################
# Assemble the data in UNIX
################################################################################

echo "#-------------------------------------------------"
echo ""
echo "Running data wrangling in UNIX..."
echo ""

# Comment out and replace with UNIX commands, as needed.
echo "No commands in UNIX."
# cd Data
# cat my_files_*.csv > my_full_file.csv
# paste -d, file_1.csv file_2.csv > my_full_file.csv
# join -t, file_1.csv file_2.csv > my_full_file.csv
# cd ..
# Don't forget to move back to the main folder after data handling is done.
echo ""

echo "Finished data wrangling in UNIX."
echo ""
echo "#-------------------------------------------------"
echo ""


################################################################################
# Perform data handling or modelling in Python
################################################################################

echo "#-------------------------------------------------"
echo ""
echo "Running data wrangling and modeling in Python..."
echo ""

# Comment out and replace with R commands, as needed.
echo "No commands in Python."
# python3 Code/my_data_script.py > Code/my_python_data_results.out
# python3 Code/my_regression_script.py > Code/my_python_regression_results.out
echo ""


echo "Finished data wrangling and modeling in Python."
echo ""
echo "#-------------------------------------------------"
echo ""



################################################################################
# Perform data handling or modelling in R
################################################################################

echo "#-------------------------------------------------"
echo ""
echo "Running data wrangling and modeling in R..."
echo ""

# Comment out and replace with R commands, as needed.
# echo "No commands in R."
# Rscript Code/my_data_script.R > Code/my_R_data_results.out
# Rscript Code/my_regression_script.R > Code/my_R_regression_results.out
Rscript Code/House_Price_Reg.R > Code/House_Price_Reg.out
echo ""

echo "Finished data wrangling and modeling in R."
echo ""
echo "#-------------------------------------------------"
echo ""


################################################################################
# Build the pdf Document with LaTeX
################################################################################

echo "#-------------------------------------------------"
echo ""
echo "Building the pdf Document with LaTeX..."
echo ""

cd Paper
# The default version needs no options.
# pdflatex Paper.tex
# Need extra permission in the VirtualBox machine.
pdflatex -shell-escape Paper.tex
# Run it twice to obtain references in document.
pdflatex -shell-escape Paper.tex
cd ..
echo ""

echo "Finished building the pdf document with LaTeX."
echo ""
echo "#-------------------------------------------------"
echo ""


################################################################################
# If you made it here without error, it worked.
################################################################################

echo "Finished my Business Analytics Project!"
echo ""
echo "##################################################"

################################################################################
# End
################################################################################
