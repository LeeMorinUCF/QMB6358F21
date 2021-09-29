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
# Please use exactly the same function names 
# and the same number and order of arguments. 
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
    
    
    product = num_1*num_2
    
    return product




#--------------------------------------------------
# b) is_it_5_or_6
#--------------------------------------------------

def is_it_5_or_6(num_in):
    if num_in == 5 or num_in == 6:
        message_out = "The number is a 5 or a 6"
    else:
        message_out = "The number is not 5 or 6"
    
    return message_out




#--------------------------------------------------
# c) color_by_number
#--------------------------------------------------

def color_by_number(num_in):
    
    name_of_output = float('NaN')
    
    return name_of_output




#--------------------------------------------------
# d) multiples_of_5
#--------------------------------------------------

def multiples_of_5(n):
    
    list_of_fives = range(0, n+1, 5)
    
    return list_of_fives[1:]




#--------------------------------------------------
# e) count_even_numbers
#--------------------------------------------------

def count_even_numbers(end_num):
    
    count_of_evens = math.floor(end_num/2)
    
    return count_of_evens




#--------------------------------------------------
# f) summarize_5_numbers
#--------------------------------------------------

def summarize_5_numbers(num_1, num_2, num_3, num_4, num_5):
    
    list_of_nums = [num_1, num_2, num_3, num_4, num_5]
    max = np.max(list_of_nums)
    min = np.min(list_of_nums)
    avg = np.mean(list_of_nums)
    
    return [max, min, avg]




##################################################
# Test Cases.
##################################################


def main():

    
    #--------------------------------------------------
    # a) multiply_two
    #--------------------------------------------------

    print(multiply_two(5, 7))
    print(multiply_two(99, 1))
    print(multiply_two(10, 10))
    print(multiply_two(1, 1))
        
    #--------------------------------------------------
    # b) is_it_5_or_6
    #--------------------------------------------------
    
    print(is_it_5_or_6(4))
    print(is_it_5_or_6(5))
    print(is_it_5_or_6(6))
    print(is_it_5_or_6(100))
        
        
    #--------------------------------------------------
    # c) color_by_number
    #--------------------------------------------------
    
    
    print(color_by_number(10))
    print(color_by_number(-3))
    print(color_by_number(25))
    print(color_by_number(29))
    
    #--------------------------------------------------
    # d) multiples_of_5
    #--------------------------------------------------
    
    print(multiples_of_5(2))
    print(multiples_of_5(17))
    print(multiples_of_5(20))
    
    #--------------------------------------------------
    # e) count_even_numbers
    #--------------------------------------------------
    
    print(count_even_numbers(10))
    print(count_even_numbers(100))
    print(count_even_numbers(0))
    print(count_even_numbers(22))
    
    #--------------------------------------------------
    # f) summarize_5_numbers
    #--------------------------------------------------
    
    print(summarize_5_numbers(1, 1, 1, 1, 1))
    print(summarize_5_numbers(1, 2, 3, 4, 5))
    
    
    
    
if __name__== '__main__':
    main()
  
  
  
##################################################
# End.
##################################################
