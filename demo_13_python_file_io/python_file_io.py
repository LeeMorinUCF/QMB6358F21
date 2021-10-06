# -*- coding: utf-8 -*-
"""
##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# October 15, 2020
#
##################################################
"""



##################################################
# Import Modules.
##################################################

import os
import csv


##################################################
# Interacting with the Operating System.
##################################################


# import os

# Find out the current directory.
os.getcwd()
# Change to a new directory.
# Notice the double backslashes. The first is the escape sequence to tell the interpreter to actually print the second backslash.
os.chdir('C:\\Users\\le279259\\Documents\\Teaching\\QMB6358_Fall_2020\\GitRepos\\QMB6358F20\\demo_13_python_file_io')
# Check that the change was successful.
os.getcwd()




##################################################
# Using 'with' to Interact with Files.
##################################################



with open('file_to_save.txt', 'w') as open_file:
    for i in range(5):
        open_file.write('A string to write on line %d.\n' % (i+1))


##################################################
# Creating a File Object to Interact with Files.
##################################################


open_file = open('another_file_to_save.txt', 'w')
open_file.write('A string to write on line 1\n')
open_file.write('A string to write on line 2\n')
open_file.write('A string to write on line 3\n')
open_file.close()




inputFile = open('another_file_to_save.txt', 'r')
firstLine = inputFile.readline()
secondLine = inputFile.readline()
thirdLine = inputFile.readline()

# Notice that each line contains the escape sequence \n
# for new line at the end of each line.



##################################################
# Read entire contents of file.
##################################################


with open('file_to_save.txt', 'r') as open_file:
  all_text = open_file.read()

print(all_text)

print(all_text[3])
print(all_text[27])
print(all_text[28])
print(all_text[29])



##################################################
# Interacting with csv Files.
##################################################


# import csv

# Open a csv file to write content.


with open('my_new_csv_file.csv', 'w') as csvfile:
    my_writer_object = csv.writer(csvfile, delimiter=',',
                            quotechar='"', quoting=csv.QUOTE_MINIMAL)
    my_writer_object.writerow([1,2,3,4,7])
    my_writer_object.writerow([21,22,33,34,37])


# Read content from an existing csv file.
# Use a loop along the rows of the file.
with open('my_new_csv_file.csv', 'r') as csvfile:
     my_reader_object = csv.reader(csvfile, delimiter=' ', quotechar='|')
     for row in my_reader_object:
         print(row)
         print(', '.join(row))




# You can enter whatever you want as the delimiter.
# One of the silliest examples I've found on the internet is:
with open('eggs.csv', 'w') as csvfile:
    my_writer_object = csv.writer(csvfile, delimiter=' ',
                            quotechar='|', quoting=csv.QUOTE_MINIMAL)
    my_writer_object.writerow(['Spam'] * 5 + ['Baked Beans'])
    my_writer_object.writerow(['Spam', 'Lovely Spam', 'Wonderful Spam'])




# Read the content as above.
with open('eggs.csv', 'r') as csvfile:
     my_reader_object = csv.reader(csvfile, delimiter=' ', quotechar='|')
     for row in my_reader_object:
         print(row)
         print(', '.join(row))
# And with the quotes and delimiters as specified, 
# it extracts the separate elements from each line. 


# Sometimes computing demos have strange naming conventions
# but this tactic is often used to avoid any confusion about the notation.
# For example, you would never expect that the word "Spam"
# or "Lovely Spam" had any computational significance, 
# so it wouldn't be confused with generic notation. 
# You often see coding examples with names of objects such
# "foo", "bar" and "baz" in explanations involving a generic object.


##################################################
# End
##################################################
