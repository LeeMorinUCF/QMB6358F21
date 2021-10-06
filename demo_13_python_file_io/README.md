# File I/O

File I/O is the term for interacting with the file system on your computer. 
It is the processes surrounding the ```I```nput and ```O```utput of ```File```s. 


### Reading files

You can use the ```with``` command to interact with a file. 

Examples:

```python
with open('file_to_read.txt', 'r') as open_file:
  all_text = open_file.read()
```
The argument ```'r'``` specifies that you want to ```r```ead from the file. 
The above code block reads the entire contents of the file into one object ```all_text```. 
You can also read one or more lines at a time with the ```readline()``` method for files.

```python
with open('file_to_read.txt', 'r') as open_file:
	line = open_file.readline()
	while line:
  	print(line)
  	line = open_file.readline()
```

You can also think of the file as an object and assign the file to a variable name.
This is how it is done in a popular book on computing:

```python
inputFile = open('file_to_read.txt', 'r')
firstLine = inputFile.readline()
secondLine = inputFile.readline()
thirdLine = inputFile.readline()
```

Whatever style you choose, make sure that you produce something that is readable and is easily understood by a future user (who could be you).


### Writing to files

Similarly, there are two styles that achieve the same outcome.
One way is considered good programming practice by many, since it makes clear that the writing is happening in the indented code.
It also automatically closes the file when the indenting ends.

```python
with open('file_to_save.txt', 'w') as open_file:
  open_file.write('A string to write')
```
Some people will complain if you do it the next way but it gets the job done.
You might find this more clear about each operation but it also requires that you keep track of the currently open files (and be sure to close them!).

```python
open_file = open('file_to_save.txt', 'w')
open_file.write('A string to write')
open_file.close()
```
The second approach, however, lends itself more easily to printing output to file that takes place in several places throughout a more complex script.

## Exercise:

Write a program that takes in a matrix and outputs a csv file.


## Exercise:

Write a program that reads a csv file and outputs a matrix.


## Importing Modules and Packages

We have already seen the ```math``` module in action.
This provides access to standard mathematical functions in C.

```python
import math
math.pi
math.log(math.floor(math.pi))
```

### The ```os``` Module

Before we do any more file handling, we would be better off if we could navigate the operating system.
That is what the ```os``` module is for, which even adapts to your specific operating system.


```python
import os
# Find out the current directory.
os.getcwd()
# Change to a new directory.
# Notice the double backslashes. The first is the escape sequence to tell the interpreter to actually print the second backslash.
os.chdir('C:\\Users\\le279259\\Documents\\Teaching\\QMB6358_Fall_2020\\GitRepos\\QMB6358\\demo_13_python_file_io')
# Check that the change was successful.
os.getcwd()
```
You can also use a relative path to avoid having a string that is specific to your platform.
With this package you can code your program and make it platform independent.


### The ```csv``` Module

This allows you to read and write tabular data in csv format.





```python
import csv
with open('my_new_csv_file.csv', 'w') as csvfile:
    my_writer_object = csv.writer(csvfile, delimiter=',',
                            quotechar='"', quoting=csv.QUOTE_MINIMAL)
    my_writer_object.writerow([1,2,3,4,7])
    my_writer_object.writerow([21,22,33,34,37])
```

To read the rows from this file just created, 
```python
with open('my_new_csv_file.csv', 'r') as csvfile:
     my_reader_object = csv.reader(csvfile, delimiter=' ', quotechar='|')
     for row in my_reader_object:
         print(row)
         print(', '.join(row))
```
This uses a loop along the rows of the file.


Here is an example stolen right from the python documentation
(it's one of the silliest examples I've found on the internet). 

```python
import csv
with open('eggs.csv', 'w') as csvfile:
    spamwriter = csv.writer(csvfile, delimiter=' ',
                            quotechar='|', quoting=csv.QUOTE_MINIMAL)
    spamwriter.writerow(['Spam'] * 5 + ['Baked Beans'])
    spamwriter.writerow(['Spam', 'Lovely Spam', 'Wonderful Spam'])
```

Note that you can enter whatever you want as the delimiter.


Read the content as above...
```python
import csv
with open('eggs.csv', 'r') as csvfile:
     spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
     for row in spamreader:
         print ', '.join(row)
```
...and with the quotes and delimiters as specified, 
it extracts the separate elements from each line. 




### An aside about online help

Sometimes computing demos have strange naming conventions
but this tactic is often used to avoid any confusion about the notation.
For example, you would never expect that the word "Spam"
or "Lovely Spam" had any computational significance,
so it wouldn't be confused with generic notation.
You often see coding examples with names of objects such
"foo", "bar" and "baz" in explanations involving a generic object.

I often use the notation ```my_object```, ```my_file``` and ```my_regression_model``` for a similar reason. 
You can call these objects whatever you want and would normally choose a name for the object that makes sense to people using the application. 


