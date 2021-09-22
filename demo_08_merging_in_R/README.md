# Joining Data Tables in R

In previous examples, we had joined tables by simply stacking them together,
with the rows and columns in the order they appear, 
using either the ```rbind()``` or the ```cbind()```
functions in R, 
which correcpond to the ```cat``` and ```paste``` commands in UNIX. 
When the data are not in order, or observations in the the rows do not match, 
you can *join* datasets so that the 
corresponding observations are linked together in order.
In order to achieve this, there must be a *key* with which to join the data.
That is, a variable that identifies the corresponding observations in
each entry the databases.
With this key, the ```merge()``` function in R can
properly organize the joined datasets with matching rows. 



There are four common types of joins, with the difference 
depending on what is done with the unmatched entries.  

In SQL, tables can be joined with four basic types of joins:
- The ```INNER JOIN``` collects all of the entries that appear in *both* tables. 
- The ```LEFT JOIN``` collects all of the entries that appear in the *first*, 
or ```LEFT``` table but are not necessarily in both tables.
- The ```RIGHT JOIN``` collects all of the entries that appear in the *second*, 
or ```RIGHT``` table but are not necessarily in both tables.
- The ```OUTER JOIN``` collects all of the entries that appear in *any* of the tables. 

It is customary to illustrate the entries included in each type of join, 
in which a set of entries are contained in any of two tables A and B. 


<img src="Images/join_diagram.jpg" width="500">

Perhaps a better way of representing the join is by
picturing two simple databases in the rectangular form of the data. 
Assume that the vertical position represents entries with the same key. 
Then the two databases will be joined in the following ways.

<img src="Images/join_tables.png" width="500">

Notice the blank spaces where there is no corresponding value
from one of the tables. 

There also exists a type of join called a cross-join. 
It has the following structure. 

<img src="Images/cross_join_tables.png" width="500">

This is not used as often but is also shown for completeness. 
Examples of these joins are shown below, 
using the ```merge()``` function in R.  


## The ```merge``` Function

For each of the four types of joins,
here is the corresponding ``merge()`` syntax.
In what follows, 
the arguments with the term ```all``` indicate the table(s)
from which the joined table will include all entries. 

To get started, read in the tables as data frames.

```
# Read the tables.
Employees <- read.csv('Employees.csv')
Departments <- read.csv('Departments.csv')
```


#### Inner Join

The ```INNER JOIN``` 
is the simplest join. 
It collects all of the entries that appear in *both* tables. 
It drops any entry in a table that does not have a matching row in the other table.

The syntax is
``merge(X, Y, all=FALSE)``


With the datasets above, the command is as follows.
```
inner_merge <- merge(Employees, Departments)
inner_merge
```
Take attendance to see who is missing.
This will verify the type of the join.


#### Left Join

The ```LEFT JOIN``` collects all of the entries that appear in the *first*, 
or ```LEFT``` table but are not necessarily in both tables.

This is the syntax:
``merge(X, Y, all.x=TRUE)``

Using the tables above, the commands are as follows:
```
left_outer_merge <- merge(Employees, Departments, all.x = TRUE)
left_outer_merge
```




#### Right Join

The ```RIGHT JOIN``` collects all of the entries that appear in the *second*, 
or ```RIGHT``` table but are not necessarily in both tables.

As above, the syntax only differs in the
name of the table from which all entries are joined.
``merge(X, Y, all.y=TRUE)``

For the above example, the command is:
```
right_outer_merge <- merge(Employees, Departments, all.y = TRUE)
right_outer_merge
```



Notice that some platforms will complain if you try to do a ```RIGHT JOIN```. 
It is not much of a loss, however, 
because a ```RIGHT JOIN``` can be done with a ```LEFT JOIN```, 
with the tables X and Y switched. 



#### Outer Join

The ```OUTER JOIN``` collects all of the entries that appear in *any* of the tables. 

For the full outer join, the argument ```all``` indicates that all 
entries are joined in from both tables.
``merge(X, Y, all=TRUE)``


For our example the command is:
```
full_outer_merge <- merge(Employees, Departments, all = TRUE)
full_outer_merge
```

Run the commands above to see how the output differs for each join. 
