# -*- coding: utf-8 -*-
"""
##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# Generating TeX Scripts for Building pdf Documents with Python
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# October 22, 2020
#
# This script first runs a regression model with artificial dataself.
# Then, it generates a tex script that generates a pdf document of the results.
#
##################################################
"""



##################################################
# Import Modules.
##################################################


# Import packages or modules.
import os
import numpy as np
from scipy import linalg
import matplotlib.pyplot as plt


##################################################
# Set Working Directory.
##################################################


# Find out the current directory.
os.getcwd()
# Change to a new directory.
# Directory on my (physical) machine. 
# os.chdir('C:\\Users\\le279259\\Documents\\Teaching\\QMB6358_Fall_2020\\GitRepos\\QMB6358F20\\demo_14_creating_documents\\LaTeX_from_python')
# Directory on my virtual machine. 
os.chdir("/home/pgbook/Documents/QMB6358_test/QMB6358F20/demo_14_creating_documents/LaTeX_from_python")
# Check that the change was successful.
os.getcwd()




##################################################
# Set parameters
##################################################

# Output tex file name.
tex_file_name = 'Paper.tex'
tex_file_path = 'Paper/' + tex_file_name

# Inputs for data generated for regression model.
N = 100
K = 2
beta_0 = np.zeros(K)
sigma = 1.0


##################################################
# Generating Artificial Data
##################################################

# Create the dataset.
ones = np.ones(N)
X = np.random.normal(0., 1., [N, K-1])
X = np.column_stack((ones, X))
y = np.dot(X, beta_0) + sigma*np.random.normal(0., 1., N )


##################################################
# Building a Model
##################################################

# Run the regression.
beta_hat, resid, rank, sigma_hat = linalg.lstsq(X, y)

# Plot a scattergraph.
x_grid = np.arange(-30,30)*0.1
y_grid = beta_hat[0] + beta_hat[1]*x_grid
plt.plot(X[:,1], y, 'x', x_grid, y_grid)
plt.xlabel('$x_i$')
plt.ylabel('$y_i$')
plt.title('Regression of $y$ on $X$')
plt.savefig('Figures/regression_plot.eps')


##################################################
# Generating the TeX script for the Document
##################################################


# Generate the tex file and build the pdf.
open_file = open(tex_file_path, 'w')

# Write the preamble.
open_file.write('\n\\documentclass{paper}\n')
open_file.write('\n\\usepackage{amsmath}\n')
open_file.write('\n\\usepackage{graphicx}\n')
open_file.write('\n\\usepackage{epstopdf}\n')
open_file.write('\n\\epstopdfsetup{suffix=}\n')
open_file.write('\n\\begin{document}\n')


open_file.write('\n\nThank you for reading my regression paper.\n\n')

open_file.write('\nThis is my regression equation:\n')
open_file.write('\n\\begin{equation}\n%')
open_file.write('\n\tY = X\\beta + \\epsilon\n')
open_file.write('%\n\\end{equation}\n')
open_file.write('\nNow we will estimate the model.\n')

# Output regression results.
open_file.write('\n\n')
open_file.write('\n$\\dots$\n')
open_file.write('\n\n')

open_file.write('\nThese are the regression coefficients:\n')
open_file.write('\n\\begin{align}\n%')
open_file.write('\n\t\\hat{\\beta}_0 & = & %10.4f \\\\ \n%%' % beta_hat[0])
open_file.write('\n\t\\hat{\\beta}_1 & = & %10.4f \n%%' % beta_hat[1])
open_file.write('\n\\end{align}\n')


# Insert the figure of the scattergraph.
open_file.write('\n\\pagebreak\n')
open_file.write('\nThis is a scattergraph of the regression results:\n')
open_file.write('\n\\begin{figure}\n%')
open_file.write('\n\t\\includegraphics[scale = 0.5]{../Figures/regression_plot.eps}\n')
open_file.write('%\n\\end{figure}\n')
open_file.write('\nThis concludes my paper.\n')




# Closing arguments.
open_file.write('\\end{document}')
open_file.close()


# Change to the Paper directory to build the document.
# Directory on my (physical) machine. 
# os.chdir('C:\\Users\\le279259\\Documents\\Teaching\\QMB6358_Fall_2020\\GitRepos\\QMB6358F20\\demo_14_creating_documents\\LaTeX_from_python\\Paper')

os.chdir("/home/pgbook/Documents/QMB6358_test/QMB6358F20/demo_14_creating_documents/LaTeX_from_python/Paper")

# Build the document from within the Paper folder.
# The default version needs no options. 
# os.system('pdflatex %s' % tex_file_name)
# Need extra permission in the VirtualBox machine.
os.system('pdflatex -shell-escape  %s' % tex_file_name)
# Run it twice to obtain references in document. 
os.system('pdflatex -shell-escape  %s' % tex_file_name)


##################################################
# End.
##################################################
