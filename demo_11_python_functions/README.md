
# Creating Functions in Python

Functions are defined with the ```def:``` operator.
Consider this first attempt:
```
# Defining a function.
def FeetToMetres(feet):
centi = 2.54
inches = 12
return feet*inches*centi/100
```
Python will complain. In other languages, indenting is a matter of style and readability.
In python, whitespace (tabs and spaces) is part of the syntax:

```
# Defining a function.
def FeetToMetres(feet):
    centi = 2.54
    inches = 12
    return feet*inches*centi/100
```

Python also uses the return statement to break and return.
```
def FeetToMetres(feet):
    centi = 2.54
    inches = 12
    return feet*inches*centi/100
    print("Calculation complete")
```
Indenting usually indicates when the function block is over but, just like with ```R```, the ```return``` statement ends the execution of the function.
```
FeetToMetres(9.5)
```
Notice that it did not print ```"Calculation complete"``` after the calculation was complete.

Let's reset the function definition to the original.
```
def FeetToMetres2(feet):
    centi = 2.54
    inches = 12
return feet*inches*centi/100
```

Once the next line is not indeneted, python knows that the function definition is over;
there is no need for braces ```{}```.

```
def FeetToMetres(feet):
    centi = 2.54
    inches = 12
    return feet*inches*centi/100
print("x")
```

Consider this example. What if I make a mistake in spelling a variable?
```
def FeetToMetres2(feet):
    centi = 2.54
    inches = 12
    return feet*inches*cen/100
```

```
FeetToMetres2(10)
```
Can you find the mistake?


Now consider if I had such a variable in memory.
```
cen = 7
FeetToMetres(10)
FeetToMetres2(10)
```
Are you surprised?
What's going on?
Some bugs are difficult to troubleshoot.

### Example: Odd or Even Number?


Determine whether a number is odd or even.
```
def OddOrEven(number):
    if number % 2 == 0:
        print('even')
    else:
        print('odd')
```
Now test it with some examples.
```
OddOrEven(7)

OddOrEven(100)

# Try this:
OddOrEven(math.pi)
# What's going on?

math.pi % 2

46 % 5
```

Now revise the definition for the extra cases.
```
def OddOrEven_2(number):
    if type(number) == int:
        r = number % 2
        if r == 0:
            print('even')
        else:
            print('odd')
    else:
        print('Input number not an int')
```

Test it to see that the function works.
```
OddOrEven_2(math.pi)

OddOrEven_2('math.pi')
```

### Example: Compute the Factorial

Write a function that calculates the factorial of an integer n.

First use a for loop.
```
def factorial(n):
    product = 1
    for i in range(1,n+1):
        product = product*i

    print( "I'm not finished yet")
    return product
    print("I'm finished")
```

Now test it.
```
print(factorial(5))


print(factorial(math.pi))
```

Trim the extra messages now that we know what it is doing.
```
def factorial_2(n):
    product = 1
    i = 1
    while i <= n:
        product = product*i
        i = i + 1
    return product
```
Now test this version. Get creative with test cases.
```
print(factorial_2(3))
print(factorial_2(math.pi))
print(factorial_2(3.99999))

print(factorial_2(1))
print(factorial_2(2))
print(factorial_2(3))
print(factorial_2(4))
```


Next use the recursive approach, as in P&G p.167.
```
def factorial_3(n):
    if n == 1:
        product = 1
    else:
        product = n*factorial_3(n - 1)

    return product
```
Test this version
```
print(factorial_3(1))
print(factorial_3(2))
print(factorial_3(3))
print(factorial_3(4))
```
Now try to push the envelope.
```
print(factorial_3(975))
print(factorial_3(980))
print(factorial_3(1000))
```
What happened?

### Example: Fibonacci sequence.

The Fibonacci sequence is made by taking the sum of the last two elements to make the next element in the sequence. The first two elements are the number one.

```
1, 1, 2, 3, 5, 8, 13
```
Let's design a function to calculate it.
```
def Fibonacci(n):
    fib_list = []
    for i in range(n):
        if i in [0,1]:
            next_fib = 1
        else:
            next_fib = sum(fib_list[(len(fib_list) - 2) : len(fib_list)])

        fib_list.append(next_fib)

    print(fib_list)
```

Now let's take a closer look at some of the ingredients.

First, the ```range()``` function generates a range of values.
```
range(5) + 1
```


Now investigate the parts of the recurrence equation, using a simpler example.
```
fib_list = [1,2,3,4]
fib_list[(len(fib_list) -2) : len(fib_list)]
```


Test the function with some examples.
```
Fibonacci(5)

Fibonacci(20)
```


