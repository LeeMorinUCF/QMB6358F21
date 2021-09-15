#!/bin/bash

# Demonstration of for loop

NUMS="1 2 3 4 5 6 7"

for NUM in $NUMS
do
   Q=`expr $NUM % 2` # Evaluates an expression: remainder from division by 2.
   if [ $Q -eq 0 ]
   then
      echo "The number $NUM is an even number."
   else
      echo "The number $NUM is an odd number."
   fi
done


# Running this script will generate the following output:
#
# The number 1 is an odd number.
# The number 2 is an even number.
# The number 3 is an odd number.
# The number 4 is an even number.
# The number 5 is an odd number.
# The number 6 is an even number.
# The number 7 is an odd number.


