# -*- coding: utf-8 -*-
"""
##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business
# University of Central Florida
#
# October 16, 2021
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
os.chdir('C:\\Users\\le279259\\OneDrive - University of Central Florida\\Documents\\Teaching\\QMB6358_Fall_2021\\GitRepo\\QMB6358F21\\demo_13_python_file_io')
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
    my_writer_object = csv.writer(csvfile, delimiter='#',
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
## Opening a File
##################################################


# First, let's create a simple file. 
# Create a folder called file_examples. 
# We created a file in a text editor with the following contents
# and save it as file_example.txt.


# First line of text.
# Second line of text.
# Third line of text.


# Now let's read this file. 


file = open('file_example.txt', 'r')
contents = file.read()
file.close()
print(contents)


# This code block makes a connection to the file file_example.txt
# and reads those contents in one string. 
# It closes the connection and prints those contents to screen. 


# First line of text.
# Second line of text.
# Third line of text.


#--------------------------------------------------
### The with Statement
#--------------------------------------------------

# The above method 
# file_1 = open('data/data1.txt', 'r') 
# works, most of the time, but when an error occurs, the program will not execute
# the file.close()command to release the file from memory. 
# If your program throws an error between the openand close
# statements, this file connection will remain in memory, 
# creating a drag on performance. 

# To avoid this problem, use the with statement. 


with open('file_example.txt', 'r') as file:
    contents = file.read()

print(contents)


# This has the format of any other kind of indented code block, 
# in which the relevant statements are indented beyond the withkeyword. 
# With this approach, if an error occurs, the block terminates and
# the file connection will automatically be released from memory.


##################################################
## Techniques for Reading Files
##################################################

# Once you have made a connection to a file, 
# there are a number of ways to read the contents. 

#--------------------------------------------------
### The read Technique
#--------------------------------------------------

# With the read technique, 
# you read the entire contents of the file into a single string. 

# We used this method above with 


with open('file_example.txt', 'r') as file:
    contents = file.read()

print(contents)


# Clearly, for very large files, this can consume a lot of memory. 
# It is often better to read the contents in smaller chunks. 
# If an integer is passed to read, 
# it will read that specified number of characters. 


with open('file_example.txt', 'r') as example_file:
    first_ten_chars = example_file.read(25)
    the_rest = example_file.read()

print("The first 10 characters:", first_ten_chars)
print("The rest of the file:", the_rest)



#--------------------------------------------------
### The readlines Technique
#--------------------------------------------------

# Instead of reading by the character, 
# which may not be a convenient unit to work with, 
# since you might not even know how many characters you need at a time, 
# you can get the contents of the file organized 
# into separate lines with the readlines function.


with open('file_example.txt', 'r') as example_file:
    lines = example_file.readlines()

print(lines)


# It gives a list of strings, each one containing a newline (\n) escape sequence. 

# Now consider the file planets.txt that contains the following text. 


# Mercury
# Venus
# Earth
# Mars

# This code block reads the file, 
# prints the contents in a list and then loops through that list 
# in reverse order using the built-in function reversed. 


with open('planets.txt', 'r') as planets_file:
    planets = planets_file.readlines()
planets



for planet in reversed(planets):
    print(planet.strip())



# You can perform other operations on this list, 
# such as sorting the lines first. 

with open('planets.txt', 'r') as planets_file:
    planets = planets_file.readlines()
planets



for planet in sorted(planets):
    print(planet.strip())



#--------------------------------------------------
### The for line in file Technique
#--------------------------------------------------

# Often, it is useful to process the contents of a file
# one line at a time. The for line in filetechnique
# lets you read a file with the functionality of a forloop
# and the efficiency of working with the contents one line at a time. 


with open('planets.txt', 'r') as data_file:
    for line in data_file:
        print(len(line))




# This allows you to perform arbitrary calculations using each line in sequence. 
# You can combine any other commands, potentially stripping away whitespace first. 


with open('planets.txt', 'r') as data_file:
    for line in data_file:
        print(len(line.strip()))



#--------------------------------------------------
### The readline Technique
#--------------------------------------------------

# Sometimes you want to perform different operations 
# depending on the characteristics of the file. 
# You could use a series of if and elif statements. 
# Instead, you can instruct the python interpreter to 
# read a single line of the file, without following a pattern, 
# using the readline technique. 

# For example, consider the following dataset, contained in
# the file hopedale.txt. 


# Coloured fox fur production, HOPEDALE, Labrador, 1834-1842
# #Source: C. Elton (1942) "Voles, Mice and Lemmings", Oxford Univ. Press
# #Table 17, p.265--266
#       22   
#       29   
#        2   
#       16   
#       12   
#       35   
#        8   
#       83   
#      166   


# Notice that the first line is a description:
# it is a record of the number of fur pelts harvested 
# in a region of Canada over a period of several years during the 1800's. 
# The next two are preceeded by a # character
# and the data begin on the fourth line.
# The following code block reads in the data
# and skips over the description in the header. 
# The following script calculates the total number of fur pelts. 


with open('hopedale.txt', 'r') as hopedale_file:

    # Read and skip the description line.
    hopedale_file.readline()

    # Keep reading and skipping comment lines until we read the first piece
    # of data.
    data = hopedale_file.readline().strip()
    while data.startswith('#'):
        data = hopedale_file.readline().strip()
        # Do nothing because these lines do not have data.

    # Now we have the first piece of data.  
    # Accumulate the total number of pelts.
    # Convert the string to an integer for the first value in the sum.
    total_pelts = int(data)

    # Read the rest of the data.
    for data in hopedale_file:
        total_pelts = total_pelts + int(data.strip())

print("Total number of pelts:", total_pelts)








# We could perform any other calculations with the lines of data, as follows.


with open('hopedale.txt', 'r') as hopedale_file:

    # Read and skip the description line.
    hopedale_file.readline()

    # Keep reading and skipping comment lines until we read the first piece
    # of data.
    data = hopedale_file.readline().rstrip()
    while data.startswith('#'):
        data = hopedale_file.readline().rstrip()

    # Now we have the first piece of data.
    print(data)

    # Read the rest of the data.
    for data in hopedale_file:
        print(data.rstrip())




# Notice the numbers are aligned
# because we stripped the whitespace only on the right side, 
# using the rstrip() function. 


##################################################
## Files Over the Internet
##################################################

# The above examples assume the file is located on our computer system. 
# You can read file located on any computer that is available on the Internet.

# The urllibmodule has tools for reading files with a given URL.
# Note that the file can be encoded in a number of ways. 
# This example shows how to read a file encoded in UTF-8. 
# This uses a function called decodeto decode the file content 
# in the form of bytes to obtain legible characters using UTF-8 encoding. 



import urllib.request
url = 'https://robjhyndman.com/tsdldata/ecology1/hopedale.dat'
with urllib.request.urlopen(url) as webpage:
    for line in webpage:
        line = line.strip()
        line = line.decode('utf-8')
        print(line)





##################################################
## Writing Files
##################################################

# The with statement can also be used for writing files. 
# Let's move to another directory for writing. 

os.chdir('C:\\Users\\le279259\\OneDrive - University of Central Florida\\Documents\\Teaching\\QMB6358_Fall_2021\\GitRepo\\QMB6358F21\\demo_13_python_file_io')
# Check that the change was successful.
os.getcwd()



with open('topics.txt', 'w') as output_file:
    output_file.write('Computer Science')

# In the above example, the file topics.txt need not exist:
# this file will be created if it does not exist
# and it will be overwritten if it does exist. 
# The distinction from reading files is shown by the second argument. 
# The 'w' denotes *writing*, while, in the earlier examples, 
# the argument 'r' indicated that the existing file
# would be open for *reading*. 

# If the file already exists and you want to write additional content, 
# you can pass the argument 'a' to *append*. 


with open('topics.txt', 'a') as output_file:
    output_file.write('Software Engineering')



with open('topics.txt', 'a') as output_file:
    output_file.write('\nBusiness Analytics')



# After running this, look at the contents of the new file:
# You should see

# Computer ScienceSoftware Engineering


# Note that a new line was not automatically added;
# you have to include it manually using \n. 


# The next example is more complex: it both reads from and writes to a file.
# It also uses the typing.TextIO type annotation for the file. 
# The acronym "IO" is short for "Input/Output"

# This script defines a function that reads two numbers from an input_file
# and writes those numbers, with their sum, in output_file. 


from typing import TextIO
# from io import StringIO

def sum_number_pairs(input_file: TextIO, output_file: TextIO) -> None:
    """Read the data from input_file, which contains two floats per line
    separated by a space. output_file for writing and, for each line in
    input_file, write a line to output_file that contains the two floats from
    the corresponding line of input_file plus a space and the sum of the two
    floats.
    """

    for number_pair in input_file:
        number_pair = number_pair.strip()
        operands = number_pair.split()
        total = float(operands[0]) + float(operands[1])
        new_line = '{0} {1}\n'.format(number_pair, total)
        output_file.write(new_line)



if __name__ == '__main__':
    with open('number_pairs.txt', 'r') as input_file, \
            open('number_pair_sums.txt', 'w') as output_file:
        sum_number_pairs(input_file, output_file)



# Notice that the files are already open in the main program. 
# This way, the open files are passed to the function 
# sum_number_pairs and are ready to read and write. 

# Also note that the first "line" of the __main__ program
# wraps into the second line, with two with statements.


# If the input_file called number_pairs.txt contains this content,

# 1.3 3.4
# 2 4.2
# -1 1


# then, after running sum_number_pairs,
# the output_file called number_pair_sums.txt will contain the following. 


# 1.3 3.4 4.7
# 2 4.2 6.2
# -1 1 0.0


##################################################
# End
##################################################
