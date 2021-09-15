#!/bin/bash

# Demonstration of for loop to produce files.

NUMS="1 2 3 4 5 6 7"

for NUM in $NUMS
do
   Q=`expr $NUM % 2` # Evaluates an expression: remainder from division by 2.
   if [ $Q -eq 0 ]
   then
      echo "The number $NUM is an even number." > "file_$NUM.txt"
   else
      echo "The number $NUM is an odd number." > "file_$NUM.txt"
   fi
done


# Running this script will produce separate files,
# each of which contain the following output:
#
# The number 1 is an odd number.
# The number 2 is an even number.
# The number 3 is an odd number.
# The number 4 is an even number.
# The number 5 is an odd number.
# The number 6 is an even number.
# The number 7 is an odd number.
#
# Clean up the mess afterward by removing these files with:
# rm file_*.csv

