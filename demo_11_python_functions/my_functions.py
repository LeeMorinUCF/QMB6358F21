#!/usr/bin/python
"""
##################################################
# 
# QMB 6358: Software Tools for Business Analytics
# 
# Sample program for writing and testing functions
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business
# University of Central Florida
# 
# September 29, 2021
# 
# This script is an example that defines a set of functions and 
# tests the functions with a number of test cases in the main function. 
# 
# It also tests the examples automatically using the 
# testmod() function in the doctest module. 
# 
##################################################
"""


##################################################
# Import Modules.
##################################################

# These are common modules that are often useful.
import numpy as np
import math


##################################################
# Functions.
##################################################


#--------------------------------------------------
# a) multiply_two
#--------------------------------------------------

def multiply_two(num_1, num_2):
    """
    Multiplies two numbers and returns the product.
    
    >>> multiply_two(5, 7)
    35
    >>> multiply_two(99, 1)
    99
    >>> multiply_two(120, 10)
    100
    >>> multiply_two(1, 1)
    1
    """
    
    product = num_1*num_2
    
    return product


#--------------------------------------------------
# b) is_it_5_or_6
#--------------------------------------------------

def is_it_5_or_6(num_in):
    """
    Determines whether the number entered is a 5 or a 6.
    
    >>> is_it_5_or_6(4)
    "The number is not 5 or 6."
    >>> is_it_5_or_6(5)
    "The number is a 5 or a 6."
    >>> is_it_5_or_6(6)
    "The number is a 5 or a 6."
    >>> is_it_5_or_6(100)
    "The number is not 5 or 6."
    
    """
    if num_in == 5 or num_in == 6:
        message_out = "The number is a 5 or a 6."
    else:
        message_out = "The number is not 5 or 6."
    
    return message_out




#--------------------------------------------------
# c) multiples_of_5
#--------------------------------------------------

def multiples_of_5(n):
    """
    Returns a list of the multiples of five up to a given number, 
    not including zero.
    
    >>> multiples_of_5(2)
    []
    >>> multiples_of_5(17)
    [5, 10, 15]
    >>> multiples_of_5(20)
    [5, 10, 15, 20]
    """
    
    list_of_fives = range(0, n+1, 5)
    
    return list_of_fives[1:]



#--------------------------------------------------
# d) count_even_numbers
#--------------------------------------------------

def count_even_numbers(end_num):
    """
    Counts the number of even numbers up to a given number, including zero.
    
    >>> count_even_numbers(10)
    6
    >>> count_even_numbers(100)
    51
    >>> count_even_numbers(0)
    1
    >>> count_even_numbers(22)
    12
    """
    
    count_of_evens = math.floor(end_num/2) + 1
    
    return count_of_evens


#--------------------------------------------------
# e) summarize_5_numbers
#--------------------------------------------------

def summarize_5_numbers(num_1, num_2, num_3, num_4, num_5):
    """
    Returns a list of the maximum, minimum and the average
    of five numbers entered.
    
    >>> summarize_5_numbers(1, 1, 1, 1, 1)
    [1, 1, 1]
    >>> summarize_5_numbers(1, 2, 3, 4, 5)
    [5, 1, 3]
    """
    list_of_nums = [num_1, num_2, num_3, num_4, num_5]
    max_5 = np.max(list_of_nums)
    min_5 = np.min(list_of_nums)
    avg_5 = np.mean(list_of_nums)
    
    return [max_5, min_5, avg_5]


##################################################
# Test Cases.
##################################################


def main():
    
    
    
    print("#" + 50*"-")
    print("# Testing with printed examples.")
    print("#" + 50*"-")
    
    
    #--------------------------------------------------
    # a) multiply_two
    #--------------------------------------------------

    print("#" + 50*"-")
    print("a) multiply_two")
    print("#" + 50*"-")

    print(multiply_two(5, 7))
    print(multiply_two(99, 1))
    print(multiply_two(10, 10))
    print(multiply_two(1, 1))
        
    #--------------------------------------------------
    # b) is_it_5_or_6
    #--------------------------------------------------
    
    print("#" + 50*"-")
    print("b) is_it_5_or_6")
    print("#" + 50*"-")

    print(is_it_5_or_6(4))
    print(is_it_5_or_6(5))
    print(is_it_5_or_6(6))
    print(is_it_5_or_6(100))
        
        
            
    #--------------------------------------------------
    # c) multiples_of_5
    #--------------------------------------------------
    
    print("#" + 50*"-")
    print("c) multiples_of_5")
    print("#" + 50*"-")

    print(multiples_of_5(2))
    print(multiples_of_5(17))
    print(multiples_of_5(20))
    
    #--------------------------------------------------
    # d) count_even_numbers
    #--------------------------------------------------
    
    print("#" + 50*"-")
    print("d) count_even_numbers")
    print("#" + 50*"-")

    print(count_even_numbers(10))
    print(count_even_numbers(100))
    print(count_even_numbers(0))
    print(count_even_numbers(22))
    
    #--------------------------------------------------
    # e) summarize_5_numbers
    #--------------------------------------------------
    
    print("#" + 50*"-")
    print("e) summarize_5_numbers")
    print("#" + 50*"-")

    print(summarize_5_numbers(1, 1, 1, 1, 1))
    print(summarize_5_numbers(1, 2, 3, 4, 5))
    
    print("#" + 50*"-")
    print("# Testing complete.")
    print("#" + 50*"-")
    
    

if __name__== '__main__':
    
    # Run the manual examples above whenever this script is run.
    main()
    
else:
    
    # Run doctest whenever the module is imported in another script.
    # That is, this section will be run whenever the module is imported
    # by typing "import my_functions" from this working directory. 
    
    
    print("#" + 50*"-")
    print("# Testing with doctest module")
    print("#" + 50*"-")
    
    # Test the examples with doctest.
    import doctest
    doctest.testmod()
    
    print("#" + 50*"-")
    print("# Tests complete")
    print("#" + 50*"-")

    

##################################################
# End.
##################################################
