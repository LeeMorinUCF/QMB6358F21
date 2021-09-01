# Introduction to the R Workspace


The script ```R_workspace.R``` provides introductory examples of R code that demonstrate
data types and conditional logic.


## Comments

The ```#``` declares the entire line as a comment. ```R``` ignores these lines.

```R
# Use comments often:
# Be a good citizen and include comments, whenever they are helpful.
# Your users will appreciate them. 
```

Keep in mind that your user may be "future you" and you might not remember as much as you think you will.  


## Running Blocks of Code

In RStudio, pressing ctrl + Enter will run the block of code that is selected. It can also be done by clicking the button above marked "Run" with the green arrow. 
To run the blocks of code, select them with your mouse (or using arrows while holding the shift key) before pressing Run (or ctrl + Enter). 
As you gain skill, you will find that you use your mouse less and less and prefer the shift + arrows and ctrl + enter. 


## Getting Help

If you know the name of a function, such as ```lm```, you can type either 
```'?'(lm)``` or ```help(lm)``` in the console. 
You can also type keywords in the help window in RStudio. 
If you don't know the keywords, you will often find what you need by searching online with a query like "r linear regression" and you should find that the ```lm``` function is recommended. 
You should know that solutions provided on online fora tend to escalate to the most concise or 'elegant' solution, which may not make sense to a new user.
Sometimes you want the solution that is most clear.


## Managing your Workspace

It is a good practice to clear the workspace before each session. 
There may be variables left over from the previous session that will interfere with your current project. 
Furthermore, if you repeatedly run you program from top to bottom while you make edits, you will be sure to produce a script that produces the same results each time. 

```R
# Clear workspace.
rm(list=ls(all=TRUE))
```

The ```rm``` function removes everything in the workspace when the list is set to ```all```.
You can also remove specific variables, which might be useful if they are large items that take a lot of memory and you no longer need those items. 

### Setting the Working Directory

You should deliberately set the directory in which you will run your scripts. 
This is the default location for any input and output. 
The ```setwd()``` function takes a string as the path to your directory. 
Note that the slashes in the path are forward slashes because that character is used for something else. 

```R
wd_path <- 'C:/Users/username/Documents/QMB6358-Fall2020/QMB6358F20/demo_05_R_intro'
setwd(wd_path)
```

You can check you working directory by entering ```getwd()```.

### Saving your Workspace

You can save some or all variables in the current workspace for later.
Use the ```ls()``` command to list all variables in the workspace, so that you know what we are saving.

```R
# Save current workspace image.
workspace_file_name <- 'myWorkspace1.RData'
save.image(workspace_file_name)
```

### Loading a Workspace

You can load a workspace image saved from a previous session and continue where you left off. 

```R
# Load existing workspace image.
workspace_file_name <- 'myWorkspace1.RData'
load(workspace_file_name)
```

With good programming practices, you do not have to use this functionality because your script should be written in a way that produces the current state of the workspace by running it from the top. 


## Data Types

Last week, we saw that there are several *classes* of data in ```R```. 

<img src="Images/Rvariablesdata.jpg" width="500"/>


### Strings

The variables in our workspace above are character strings.

```R
class(workspace_file_name)
"character"
```

You can combine strings with the sprintf() function handed down from C.
(Many C and FORTRAN programs are used in the background in R.)

```R
string1 <- 'first string'
string2 <- 'second string'
full_string <- sprintf('Put the %s before the %s.', string1, string2)
```

The '%s' is called an 'escape sequence'.
It tells the sprintf() function to look for the next argument (which should be a string)
And insert it in the place of the '%s' and outputs the full string.
```R
class(full_string)
```

### Integer variables

Most characters can be used in variable names.
```R
some_numbers.integers <- 1:10
class(some_numbers.integers)
```

### Numeric variables

Numeric is a broader class of, well, numeric variables.
```R
value_of_pi <- pi
class(value_of_pi)
```
### Logical variables

Logical values denote true or false conditions.
```R
true_statement1 <- value_of_pi == pi
class(true_statement1)
false_statement1 <- value_of_pi == pi + 2
class(false_statement1)
```

### Combining variables

Adding numeric variables can change the type.
```R
pi_plus <- some_numbers.integers + value_of_pi
```

Did you notice anything unusual?



The concatenation function ```c()``` is used to form lists or vectors of objects.
```R
more_integers <- c(some_numbers.integers, 11:15)
```

Create a vector of important numbers.
```R
value_of_e <- exp(1)
important_numbers <- c(value_of_pi, value_of_e)
```

Now try adding these to the integers.
```R
important_numbers_plus <- some_numbers.integers + important_numbers
```

What happened this time?

Recycling might save the planet, but it might ruin your code.
This is specific to ```R``` and is often used as a shortcut. 
Use with caution!

```R
three_important_numbers <- c(important_numbers, sqrt(pi))
three_important_numbers_plus <- some_numbers.integers + three_important_numbers
```

What if we concatenate variables of different types?
```R
mystery <- c(some_numbers.integers, 'This is a string')
```
R 'coerces' variables to the more general type.
```R
class(mystery)
```

Similarly for numeric types.
```R
mixed_numbers <- c(some_numbers.integers, value_of_pi)
class(mixed_numbers)
```

You can coerce the types of variables yourself.
```R
num_string <- as.character(some_numbers.integers)
as.numeric(num_string)
```

### Lists

You can assemble several variables into a list (preserving individual types).
```R
list_of_stuff <- list(thing1 = some_numbers.integers,
                      thing2 = value_of_pi)

other_list <- list(item1 = x1 <- 2, item2 = 'string')
x1
```

A better way:
```R
x2 <- 2
yet_another_list <- list(item1 = x2, item2 = 'string')
```

Print it to screen.
```R
list_of_stuff
class(list_of_stuff)
```

There are a number of ways to select an element of a list.
```R
list_of_stuff$thing1
list_of_stuff['thing1']
list_of_stuff[2]
list_of_stuff[[1]]
```

List objects are also endowed with a list of names of the elements in the list.
```R
names(list_of_stuff)
```

Within a ```for``` lop, you can perform operations using the ```names``` as an iterator. 
```R
for (name in names(list_of_stuff)) {

  print(name)

  print(mean(list_of_stuff[[name]]))

}
```

Equivalently, you can iterate on an integer and pick out the names individually. 
```R
for (name_num in 1:length(names(list_of_stuff))) {

  print(name_num)

  name <- names(list_of_stuff)[name_num]

  print(name)

  print(mean(list_of_stuff[[name]]))

}
```

You can keep combining these data types as it suits your business problem. 

```R
bigger_list <- list(first_list = list_of_stuff, next_list = seq(5))
bigger_list$first_list$thing1
```


### Data frames


Data frames behave similarly (because a data frame IS a list).
```R
df1 <- data.frame(var1 = 1:10, var2 = sprintf('row%d', 1:10))
```

Note ```%d``` is the escape sequence for integers.
It inserts an integer in the string at the location of ```%d```.

There are several wats to extract a subset of a data frame, using the ```[]``` operator. 
The first is to extract a single variable by passing a single string matching a columne name. 

```R
df1['var1']
```

You can use the first argument to select a range of row numbers. 

```R
df1[2:7, 'var1']

df1[2:7, ]
```

### Formula objects

Many statistical functions use a formula object
to specify variables to be analyzed within a data frame.
This is a data type specific to ```R```.

```R
my_fmla <- as.formula(Y ~ x1 + x2 + x3)
```

We will use formula object when we build statistical models later on in the course. 

### Commands spanning multiple lines.

A specific endpoint has to be chosen for a command that is continued on the next line.
There is no terminal symbol in ```R``` (like the semicolon in ```C``` or ```MATLAB```).
```R``` will determine that a command is unfinished and wait for more.

Now complete the command by running this line:

```R
df2 <- data.frame(var1 = 11:20,
+ 
```

The ```+``` prompt indicates that ```R``` is waiting for the rest of an unfinished command.
A common error is the unexpected ```+``` sign, which often ocurrs when you have run a partial block of code or have coded incomplete syntax. 

Now run this:
```R
+ var2 = sprintf('row%d', 11:20))
```

Everything worked out. The two lines together form a complete command. 

Multi-line commands must end with a symbol that indicates that a command is incomplete.
An open bracket after a comma will work:

Run both of these lines together:
```R
df3 <- data.frame(var1 = 21:30,
                  var2 = sprintf('row%d', 21:30))
```

### Matrices

Matrices offer a powerful set of tools for efficient calculation using matrix algebra. 


Create a matrix with the...```matrix``` function.
```R
A <- matrix(c(2, 4, 3, 1, 5, 7),
            nrow = 2,
            ncol = 3)
x <- matrix(c(1, 0, 2),
            nrow = 3,
            ncol = 1)

A
x
```

There is a specific operator ```%*%``` for matrix multiplication
```R
b <- A %*% x

b
```

### Factors

Categorical variables are called ```factor```s in ```R```.
These are used in regression models when a variable can take on only a finite set of values. 
```R
df4 <- data.frame(var1 = 21:30,
                  var2 = as.factor(sprintf('Group %d', rep(1:2,5))))

df4$var2
is.factor(df4$var2)
is.character(df4$var2)
```

As a word of advice, be careful with ambiguous operators:
```R
value1 <- 7
value2 <- 10
total = value1
  + value2

print(total)
```

Was that the value you expected in ```total```?

Try again:
```R
total = value1 +
  value2

print(total)
```

The first example saw the second line
```R
+ value2
```
as a second command, with the (positive) value of ```value2```.


## Mathematical Operations

Standard mathematical operators work as expected: *,/,+,-.
```R
some_numbers.integers * 2
```

Notice that the type changes to the more general numeric.
```R
some_numbers.integers * 2.5
```

There are many mathematical functions in base ```R```.
```R
max(c(1,2))
min(c(1,2))
log(c(1,2,7))
exp(c(1,2))
sum(some_numbers.integers)
cumsum(some_numbers.integers)
```

### Special Values

There are some special values to represent certain conditions.

```R
# Divide by zero.
7/0
-7/0

# Add them together.
7/0-7/0
7/0+7/0
-7/0-7/0
```

We saw the exponential function above, how far can we push it?
```R
exp(100)
exp(709)
exp(710)
```
This is the result of a numerical overflow.
It occurs when the number is too large to be represented by the binary digits allocated to it. 
Recall the format of the 32-bit numeric variables, with a set number of bits 
allocated to the sign, exponent and mantissa. 


There are other ways to generate some other special values.
```R
log(0:1)
```

### Boolean operators (for logicals).

Logical variables store the values ```TRUE``` or ```FALSE``` and can be created using logical operators applied to other variables in memory.
```R
5 == 3+3
5 == 3+2
```

A common logical variables is used to identify the ```class``` of a variable. 
```R
is.integer(some_numbers.integers)
is.numeric(some_numbers.integers)
is.character('this is a character string')
```

Try this logical operator:
```R
'R' == 'fun'
```

Should we even bother to continue?


Mathematical operations on logicals will produce ```integer``` or ```numeric``` values:

```R
T + T
T + F
T*T
T*F
class(T+T)
T*7
class(T*7)
```

```R``` coerces the logical value to integer 1 or 0 when combined with other numeric types.

Coercion works similarly for numeric variables.
```R
value_of_pi + TRUE
class(value_of_pi + TRUE)
```


Try comparing different data types:
```R
5 == 'five'
```

How about this?
```R
5 == '5'
```
Was that the result you expected?


## Conditional Logic

Logical variables must be defined before executing an ```if``` statement. 

```R
# Set parameters for conditions.
weather <- 'rainy'
# weather <- 'sunny'
```


Now the ```weather``` variable can be used in a single if statement.
```R
if (weather == 'rainy') {
  print('Bring an umbrella.')
}
```

Now change the value of the variable and execute a compound if statement.
```R
weather <- 'sunny'

if (weather == 'rainy') {
  print('Bring an umbrella.')
} else if (weather == 'sunny') {
  print('Bring sunglasses.')
}
```


The above format is easier for the user to read but statements can be written on a single line. 

```R
if (weather == 'rainy') {print(weather)}
if (weather == 'sunny') {print(weather)}
```

You can also test a condition first and input that condition into the if statement. 

```R
is_it_sunny <- weather == 'sunny'
is_it_rainy <- weather == 'rainy'

if (is_it_rainy) {
  print('Bring an umbrella.')
} else if (is_it_sunny) {
  print('Bring sunglasses.')
}
```


A compound ```if``` statement can handle multiple cases.
```R
weather <- 'tornado'

if (weather == 'rainy') {
  print('Bring an umbrella.')
} else if (weather == 'sunny') {
  print('Bring sunglasses.')
} else {
  print('Weather type not recognized.')
}
```


### ```for``` Loops

The notation for ```for``` loops in ```R``` is similar to that for ```if``` statements.
```R
total <- 0
for (i in 1:10) {

  # Do the computations here.
  total <- total + i

  # Print a progress report.
  print('Cumulative total is')
  print(total)
  print(sprintf('Completed iteration %d', i))
}

total
```

Likewise for a ```while``` loop.
```R
# Need to initialize the condition to enter the loop.
i <- 0
while(i < 10) {
  i <- i + 1
  print(sprintf('Completed iteration %d', i))
}
```

Be careful to avoid runaway ```while``` statements.

```R
i <- 0
while(i != 'rainy') {

  # This is running smoothly.
  i <- i + 1
  print(sprintf('Completed iteration %d', i))

  if (i > 100) {
    # This is getting out of control.
    # Stop it before the computer explodes!
    break
  }

}
```

The ```break``` command will make the program exit the loop. 


## Functions and Packages

### Built-in functions in base R.

Take a cumulative sum with an example from above.
```R
cumsum(some_numbers.integers)
```

You can also specify arguments by name (but you have to know the name of the argument; see help for details).
```R
cumsum(x = some_numbers.integers)
```

What happens if the argument contains missing values?

```R
contains_missing_values <- c(2,5,NA,7)
cumsum(contains_missing_values)
```

For some functions, you can tell ```R``` to remove missing values.

```R
sum(contains_missing_values)
sum(contains_missing_values, na.rm=TRUE)
```
Whether or not you think this is good might tell you about your preferred software.


You could find the locations of the missing values and remove them yourself.
```R
is.na(contains_missing_values)
without_missing_values <- contains_missing_values[!is.na(contains_missing_values)]
sum(without_missing_values)
```


When passing multiple arguments, you can specify the arguments in any order,
if you specify them by name.
```R
sum(x = contains_missing_values, na.rm=TRUE)
sum(na.rm=TRUE, x = contains_missing_values)
```

Notice that the ```sum()``` function has default value ```na.rm = FALSE```.
See the documentation by entering ```help(sum)```.


### Creating your own functions.

You can make your own functions, with the ```function()``` function.
```R
addTwoNumbers <- function(first_number, second_number) {

  total <- first_number + second_number

  # print(first_number)
  # print(second_number)

  return(total)
}
```

Call the function by passing the arguments.
```R
addTwoNumbers(3,4)

the_sum <- addTwoNumbers(3,4)
```

```R``` uses memory in a certain way that can be convenient but can also be confusing. 
```R
addThreeNumbers <- function(first_number, second_number) {

  third_number <- 200

  total <- first_number + second_number + third_number

  # print(first_number)
  # print(second_number)

  return(total)
}

addThreeNumbers(3,4)
```

Notice that ```third_number``` is defined in the function. 
Now redefine the function so that the ```third_number``` is commented out.
```R
addThreeNumbers <- function(first_number, second_number) {

  # third_number <- 200

  total <- first_number + second_number + third_number

  # print(first_number)
  # print(second_number)

  return(total)
}

addThreeNumbers(3,4)
```

Now try setting the variable at different values.

```R
third_number <- 100
addThreeNumbers(3,4)

third_number <- 101
addThreeNumbers(3,4)
```

Depending on your prefernces, this is either convenient, confusing or completely unacceptable. 

What happens if you pass too many arguments?
```R
addTwoNumbers(3,4,5)
```

Make a new function that allows for a flexible number of parameters.
```R
addSeveralNumbers <- function(...) {

  # Get arguments.
  list_of_numbers <- list(...)

  # Add numbers.
  total <- 0
  for (i in 1:length(list_of_numbers)) {

    total <- total + list_of_numbers[[i]]

  }

  return(total)
}

addSeveralNumbers(3,2,1)
addSeveralNumbers(3,2,1,0,-1)
```

What happens with a missing value?
```R
addSeveralNumbers(3,2,1,NA,-1)
```

Modify the function to remove missing values.
```R
addSeveralNumbers <- function(..., na.rm = FALSE) {

  # Get arguments.
  list_of_numbers <- list(...)

  # Add numbers.
  total <- 0
  for (i in 1:length(list_of_numbers)) {

    # Add if either na.rm = FALSE or the number is not missing
    # (or both, by definition of 'or').
    if (!na.rm | !is.na(list_of_numbers[[i]])) {

      total <- total + list_of_numbers[[i]]

    }
    # Adding skipped if both na.rm = TRUE and number is missing.

  }

  return(total)
}
```

Test the modified version.
```R
addSeveralNumbers(3,2,1,NA,-1, na.rm=TRUE)
```

Note that the original call is unchanged (good coding practice).
```R
addSeveralNumbers(3,2,1,NA,-1)
```

### Loading packages

There are many packages of functions available online.
You can import them automatically with the ```library``` function.

The syntax is:
```R
library(name_of_R_package_goes_here)
```
Note that there are no quotes: the package is an object, not a string.

If this package is not already installed, you have to install the package:
```R
install.packages('name_of_R_package_goes_here')
```
In the ```install.packages``` function, the argument is a string.


You can load many libraries for handling data.
Some packages are designed to interact with Microsoft Excel:

```R
# install.packages('XLConnect')
library(XLConnect)

# install.packages('xlsx')
library(xlsx)
```

Remove the commented line if the package is not yet installed. 

Some packages are designed for using data from other statistical software:

```R
# install.packages('foreign')
library(foreign)

# install.packages('haven')
library(haven)
```

Some packages have the functionality for handling larger data sets in a way that is efficient in terms of memory uses and computational complexity.

```R
# install.packages('data.table')
library(data.table)

# install.packages('dplyr')
library(dplyr)
```

These are just a few among many packages listed on, for example:

[Quick-list-of-useful-R-packages](https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages)

As always, Google is your best friend. 
Most functions you can think of have probably already been created by someone else.
The challenge is not about finding a package but of choosing one that suits your needs and ability level. 
It takes some practice and experience to think of an effective search query and to recognize that a package is suitable for you. 
