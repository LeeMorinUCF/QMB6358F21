# Introduction to Python

## Comments

In python, there are two ways to write comments: the 
```#``` symbol or triple quotes:


```
'''
This is a comment.
Be a good citizen and inform your users.
'''
# This is another comment.

```
The first is often used for larger blocks of comments, 
such as a description of your script. 



## Data types and operators

Operators are very similar to those in other languages.

```
2+2
```

Some notable differences from ```R``` is the assignment operator ```=``` and the exponent symbol (```**```):

```
x = 2

x**2
```

Python is dynamically typed, meaing that the same variable can be 
replaced multiple times and take on a different type, as needed. 

```
x = 3

x = 'string'

print(x)
```

As in many other languages, python is case-sensitive:
```
print(X)
```

In the above, ```x``` was last set as type ```string```

### Selecting elements of objects

You can select elements of strings as follows

```
x[2]

x[0]
```

Note that the first element has index number zero.
You can also use negative values.
```
x[-3]
x[-1]
```

Note that strings are immutable: they are defined as a fixed value and individual elements cannot be altered. 
```
x[2] = 'x'
```
If you want to do such a thing, there is always a work-around:
```
x = x[0:2] + 'x' + x[3:7]
print(x)
```
This was done by taking the two substrings on each side of element two and forming a new string by concatenating them with a one-letter string in the middle. 

Be careful with the index numbers. You have to keep track of the number of elements. 
```
x[3:20]
```


### Logical variables and operators

In python, the single ```=``` sign is the assignment operator 
(there is no ```<-``` as with ```R```) 
but the logical test operator for equality is the double equal sign ```==```, just as with ```R```. 

```
boolean_ind = x == 5

```

The exclamation point is also used to test if two values are not equal. 
```
other_boolean_ind = x != 5
```
Python also has a more versatile set of commands that work like they do in the English language.
```
yet_another_boolean_ind = not x == 5
```

### Determining the type of a variable

There are some differences between python versions 2 and 3:
What happens when you run these commands?
```
z = 3/5

type(x)

type(z)

z

type(3)

type(3.0)
```
The ```type``` function is used to check the type of a variable. 
It can be used to veryfy that inputs to a function are the correct type.
```
type(2) == int
```

Python also coerces variables to have a compatible type within calculations.
```
z2 = 3.0/5

type(z2)
```


### Arrays and lists

Python has notation to keep arrays of variables. 
A two-dimensional array is like a matrix, except it is really an array of arays. 

```
a = [[1, 2, 3], [4, 5, 6]]
# a = [[1, 2, 3], [4, 5, 'a']]
```
For some arrays, used later, the second command throws an error.
This is because some kinds of arrays only accepts elements of the same type. 
This also offers a computational advantage. 
For now, the above are acceptable because ```a``` is technically a ```list```, which, unlike ```str```ings, are mutable. 

Once an array is in memory, you can extract subsets of the data by using the 2-dimensional notation. 
```
print(a)

print(a[0])
print(a[1])
print(a[0][1])
print(a[1][2])
```
There are special values in python but it requires special notation compared to ```R```.

```
a[1][2] = float('nan')
```

### Determining whether specific elements in a list.

The ```in``` operator is a logical operator for lists. 
You have to be careful about what exactly you are comparing. 

```
10 in a

10 in [10, 3, 5]

6 in a


[1,2,3] in a

6 in a[1]

```

This type of logical value can be used in an ```if``` statement. 

## Conditional logic

Python has simple syntax that requires less typing.
This can be confusing at first because there is limited use of brackets and punctuation. 
The most common (and invisible) type of syntax is whitespace!

Consider this ```if``` statement:

```
age = 17

if age > 17:
   print("can see a rated R movie")
elif age <= 17 and age > 12:
   print("can see a rated PG-13 movie")
else:
   print("can only see rated PG movies")
```

Colons ```:``` denote the end of ```if``` or ```elif``` or ```else``` statements. 
The code in the blocks is denoted by the indeting of the lines of code within the block (not the commands like ```if``` or ```else```).

As before, the ```else``` statement is optional. 

```
age = 1

if age > 17:
    print("can see a rated R movie")
elif age <= 17 and age > 12:
    print("can see a rated PG-13 movie")
```
The default is "else, no action", as with ```R```.




## Repetition


Python is very flexible with looping over objects.
As with ```if``` statements, use a colon ```:``` and indent properly to denote the code block in the ```for``` loop. 
```
words = ['cat', 'window', 'defenestrate']
for w in words:
    print(w, len(w))
```

Compare with this:
```
for w in 'words':
    print(w)
```

While loops work just as they do in other languages. 
```
i = 5
while i > 0:
  i -= 1
  print('i = %d' % i)
  print("Inside the loop")
```

While loops can be interrupted with a ```break``` statement: 
```
i = 5
while i > 0:
  i -= 1
  print('i = %d' % i)
  if i == 3:
      break
  print("Inside the loop")
```




## Using modules.

Python is very parsimonious in its use of memory. 
Many basic mathematical functions -besides operators- have to be imported from ```modules```
```
import math

math.e

math.pi



math.log(math.e)

math.e(math.log(0))


math.e**math.log(7)


must_be_true = math.e**math.log(7) == 7

must_be_true = (math.e**math.log(7) - 7) < 0.0000001

```
When you import a module, you can use any object in the module by using the module name and dot before the object (usually a function or a constant).


You can choose your own abbreviations for modules

```
import math as m1

m1.e


m1.e == math.e
```


Some packages are a mouthful. Choose an appropriate abbreviation. 
```
import super_long_package_name as s

s.function(whatever)
```
There is such a thing as being too concise.

But there is also such a thing as being too verbose.
```
import math as super_long_package_name

super_long_package_name.e
```
It makes sense to make your abbreviations informative.
```
import math as x

x.e
```

Some modules have standard abbreviations; go with convention.
```
import numpy as np

import pandas as pd
```
... and for a real script (not a demo) declare your modules
at the top of the script.


