# Joining Data Tables in R

## The ```merge``` Function


For the common types of joins, here is the corresponding ``merge()`` syntax.

INNER JOIN:
``merge(X, Y, all=FALSE)``

LEFT OUTER JOIN:
``merge(X, Y, all.x=TRUE)``

RIGHT OUTER JOIN:
``merge(X, Y, all.y=TRUE)``

FULL OUTER JOIN:
``merge(X, Y, all=TRUE)``


### Examples

```
# Read the tables.
Employees <- read.csv('Employees.csv')
Departments <- read.csv('Departments.csv')
```


#### INNER JOIN
```
inner_merge <- merge(Employees, Departments)
inner_merge
```
Take attendance and see who is missing.

#### LEFT OUTER JOIN
```
left_outer_merge <- merge(Employees, Departments, all.x = TRUE)
left_outer_merge
```


#### RIGHT OUTER JOIN
```
right_outer_merge <- merge(Employees, Departments, all.y = TRUE)
right_outer_merge
```


#### FULL OUTER JOIN
```
full_outer_merge <- merge(Employees, Departments, all = TRUE)
full_outer_merge
```

