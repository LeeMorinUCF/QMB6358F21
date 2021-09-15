# Data in R

## Sample Datasets

Many packages make reference to classic sample datasets to highlight their usage. 
Two of these are the ```cars``` dataset and the ```iris``` dataset. 
The ```cars``` dataset has two variables: ```speed``` in mph and ```dist```ance is the stopping distance in feet, appearing in a statistics book by M. Ezekiel in 1930. 
The ```iris``` dataset has a variety of measurements of samples of three species of flowers from a daset analyzed by R.A. Fisher and E. Anderson in the 1930's. 
Authors of packages use these datasets since the contents are 
well-known and users can focus on the contents of the software package. 
We will use them to demonstrate the basic features of data manipulation in ```R```.


## Writing and Reading Datasets

### Writing and reading to ```txt``` files

Load the ```cars``` dataset and inspect its contents.
```
data(cars)
summary(cars)
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

To write this dataset to a text file in your working directory, 
use the ```write.table``` function.
```
write.table(cars, file = 'cars.txt')
```

To read in your copy into another data frame, use the ```read.table``` function.
```
cars_df <- read.table(file = 'cars.txt')
```

### Writing and reading to ```csv``` files

Load the ```iris``` dataset.
```
data(iris)
```

Write this to your folder in ```csv``` format using the ```write.csv``` function.
```
write.csv(iris, file = 'iris.csv')
```

Read in the ```csv``` to a data frame with the ```read.csv``` function.
```
iris_df <- read.csv(file = 'iris.csv')
```

### Initial inspection

Using ```read.table``` above, the cars dataset is read in as a data frame. The ```class``` function works just as it does for atomic or vector objects.

```
class(cars_df)
[1] "data.frame"
```

Use the ```summary``` function to summarize the data.
```
summary(cars_df)
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

Determine the dimensions of a dataset as a vector or one dimension at a time. 

```
dim(cars_df)
[1] 50  2
nrow(cars_df)
[1] 50
ncol(cars_df)
[1] 2
```

Show the first few rows of the dataset with the ```head``` function.
```
head(cars_df)
  speed dist
1     4    2
2     4   10
3     7    4
4     7   22
5     8   16
6     9   10
```
Just as with UNIX, the ```tails``` funtion works similarly. 


Show the column names of the data.
```
colnames(cars_df)
[1] "speed" "dist" 
```
It returns a vector of character strings of length```ncol(cars_df)```. 

### Subsetting data frames

You can select a subset using numeric indices.
```
cars_df[2:5, 2]
[1] 10  4 22 16
```
Notice which observations were selected in the results of the ```head(cars_df)``` command.


For variables that have column names, it is more clear to the user if you select a variable using variable names.
One way selects the columns by specifying the variable name in the second dimension of the ```[]``` operator. 
```
cars_df[2:5,'dist']
[1] 10  4 22 16
```
You can also select the rows of a one-dimensional object ```cars_df$dist``` representing the single variable ```dist```.
```
summary(cars_df$dist)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   2.00   26.00   36.00   42.98   56.00  120.00 
```
Select elements 2, 3, 4 and 5:
```
cars_df$dist[2:5]
[1] 10  4 22 16
```

You can also select using logical arguments.
```
colnames(cars_df) == 'dist'
[1] FALSE  TRUE
```
Now use this logical vector to select columns.
```
cars_df[2:5, colnames(cars_df) == 'dist']
[1] 10  4 22 16
```

There are many possible ways to select observations. 
As another approach, select columns by the name of variables (those beginning with "d").
```
sel_cols <- substring(colnames(cars_df), 1, 1) == 'd'
cars_df[2:5, sel_cols]
[1] 10  4 22 16
```

You can also select rows based on the values of variables.
```
summary(cars_df$speed)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    4.0    12.0    15.0    15.4    19.0    25.0 
```

Select the rows in which the ```speed``` is faster than average. 
```
sel_rows <- cars_df$speed > mean(cars_df$speed)
cars_df[sel_rows, ]
   speed dist
27    16   32
28    16   40
...
48    24   93
49    24  120
50    25   85
```
Note that the empty second argument in ```[,]``` means to select all elements.


A data frame is essentially a list of objects.
This particular column is an integer vector:
```
class(cars_df$dist)
[1] "integer"
```
So you can use the columns in calculations just as you would with other vectors of objects. 


### Exercise:
1. List the 5 fastest cars.
2. List the 4 cars with the shortest stopping distance.


### A dataset with categorical variables.

The ```iris``` dataset has categorical variables.

This is also a data frame:
```
class(iris_df)
[1] "data.frame"
```

Summarize the data.
```
summary(iris_df)
       Species    Petal.Length    Petal.Width     Sepal.Length    Sepal.Width   
 setosa    :50   Min.   :1.000   Min.   :0.100   Min.   :4.300   Min.   :2.000  
 versicolor:50   1st Qu.:1.600   1st Qu.:0.300   1st Qu.:5.100   1st Qu.:2.800  
 virginica :50   Median :4.350   Median :1.300   Median :5.800   Median :3.000  
                 Mean   :3.758   Mean   :1.199   Mean   :5.843   Mean   :3.057  
                 3rd Qu.:5.100   3rd Qu.:1.800   3rd Qu.:6.400   3rd Qu.:3.300  
                 Max.   :6.900   Max.   :2.500   Max.   :7.900   Max.   :4.400 
```

Get the dimensions of the data, either as a vector or get the numbers of rows and columns separately.
```
dim(iris_df)
[1] 150   5
nrow(iris_df)
[1] 150
ncol(iris_df)
[1] 5

```
Show the first few rows of the dataset.
```
head(iris_df)
  Species Petal.Length Petal.Width Sepal.Length Sepal.Width
1  setosa          1.4         0.2          5.1         3.5
2  setosa          1.4         0.2          4.9         3.0
3  setosa          1.3         0.2          4.7         3.2
4  setosa          1.5         0.2          4.6         3.1
5  setosa          1.4         0.2          5.0         3.6
6  setosa          1.7         0.4          5.4         3.9
```

Obtain the column names of the data in a character vector.
```
colnames(iris_df)
[1] "Species"      "Petal.Length" "Petal.Width"  "Sepal.Length" "Sepal.Width" 
```

The last column is a factor.
```
class(iris_df$Species)
[1] "factor"
levels(iris_df$Species)
[1] "setosa"     "versicolor" "virginica" 
```
The ```levels``` are the separate categories. 

For factors, it is often useful to create a table of the counts of each level.
```
table(iris_df$Species)
    setosa versicolor  virginica 
        50         50         50 
```
An even 50 of each type. 

You can put two arguments for a two-dimensional ```table```:
```
table(iris_df$Species, iris_df$Petal.Width)
             0.1 0.2 0.3 0.4 0.5 0.6  1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9  2 2.1 2.2 2.3 2.4 2.5
  setosa       5  29   7   7   1   1  0   0   0   0   0   0   0   0   0   0  0   0   0   0   0   0
  versicolor   0   0   0   0   0   0  7   3   5  13   7  10   3   1   1   0  0   0   0   0   0   0
  virginica    0   0   0   0   0   0  0   0   0   0   1   2   1   1  11   5  6   6   3   8   3   3
```
You can see that different species have different widths.



Create new variables with the assignment operator just like any other variable.
```
iris_df$Petal.Area <- iris_df$Petal.Width * iris_df$Petal.Length
summary(iris_df)
       Species    Petal.Length    Petal.Width     Sepal.Length    Sepal.Width      Petal.Area    
 setosa    :50   Min.   :1.000   Min.   :0.100   Min.   :4.300   Min.   :2.000   Min.   : 0.110  
 versicolor:50   1st Qu.:1.600   1st Qu.:0.300   1st Qu.:5.100   1st Qu.:2.800   1st Qu.: 0.420  
 virginica :50   Median :4.350   Median :1.300   Median :5.800   Median :3.000   Median : 5.615  
                 Mean   :3.758   Mean   :1.199   Mean   :5.843   Mean   :3.057   Mean   : 5.794  
                 3rd Qu.:5.100   3rd Qu.:1.800   3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.: 9.690  
                 Max.   :6.900   Max.   :2.500   Max.   :7.900   Max.   :4.400   Max.   :15.870 
```

Drop this variable and reorganize by specifying a character vector of column names.
```
columns_to_keep <- c('Species', 'Petal.Length', 'Petal.Width', 'Sepal.Length', 'Sepal.Width')
iris_df <- iris_df[,columns_to_keep]
summary(iris_df)
       Species    Petal.Length    Petal.Width     Sepal.Length    Sepal.Width   
 setosa    :50   Min.   :1.000   Min.   :0.100   Min.   :4.300   Min.   :2.000  
 versicolor:50   1st Qu.:1.600   1st Qu.:0.300   1st Qu.:5.100   1st Qu.:2.800  
 virginica :50   Median :4.350   Median :1.300   Median :5.800   Median :3.000  
                 Mean   :3.758   Mean   :1.199   Mean   :5.843   Mean   :3.057  
                 3rd Qu.:5.100   3rd Qu.:1.800   3rd Qu.:6.400   3rd Qu.:3.300  
                 Max.   :6.900   Max.   :2.500   Max.   :7.900   Max.   :4.400 
```

### Defining new datasets

Create a new data frame with columns of your choice.
```
iris_area_df <- data.frame(Species_copy = iris_df$Species,
                         Petal.Area = iris_df$Petal.Width * iris_df$Petal.Length)
summary(iris_area_df)
    Species_copy   Petal.Area    
 setosa    :50    Min.   : 0.110  
 versicolor:50    1st Qu.: 0.420  
 virginica :50    Median : 5.615  
                  Mean   : 5.794  
                  3rd Qu.: 9.690  
                  Max.   :15.870  
```

### Joining datasets

Bind columns to the side of a data frame with the ```cbind``` function.
```
iris_wide_df <- cbind(iris_df, iris_area_df)
summary(iris_wide_df)
       Species    Petal.Length    Petal.Width     Sepal.Length    Sepal.Width        Species_copy   Petal.Area    
 setosa    :50   Min.   :1.000   Min.   :0.100   Min.   :4.300   Min.   :2.000   setosa    :50    Min.   : 0.110  
 versicolor:50   1st Qu.:1.600   1st Qu.:0.300   1st Qu.:5.100   1st Qu.:2.800   versicolor:50    1st Qu.: 0.420  
 virginica :50   Median :4.350   Median :1.300   Median :5.800   Median :3.000   virginica :50    Median : 5.615  
                 Mean   :3.758   Mean   :1.199   Mean   :5.843   Mean   :3.057                    Mean   : 5.794  
                 3rd Qu.:5.100   3rd Qu.:1.800   3rd Qu.:6.400   3rd Qu.:3.300                    3rd Qu.: 9.690  
                 Max.   :6.900   Max.   :2.500   Max.   :7.900   Max.   :4.400                    Max.   :15.870  
```

Bind additional rows below with the ```rbind``` function
```
iris_tall_df <- rbind(iris_df, iris_df)
summary(iris_tall_df)
       Species     Petal.Length    Petal.Width     Sepal.Length    Sepal.Width   
 setosa    :100   Min.   :1.000   Min.   :0.100   Min.   :4.300   Min.   :2.000  
 versicolor:100   1st Qu.:1.600   1st Qu.:0.300   1st Qu.:5.100   1st Qu.:2.800  
 virginica :100   Median :4.350   Median :1.300   Median :5.800   Median :3.000  
                  Mean   :3.758   Mean   :1.199   Mean   :5.843   Mean   :3.057  
                  3rd Qu.:5.100   3rd Qu.:1.800   3rd Qu.:6.400   3rd Qu.:3.300  
                  Max.   :6.900   Max.   :2.500   Max.   :7.900   Max.   :4.400  
```

Note that there are twice as many rows:
```
nrow(iris_tall_df)
[1] 300
```

### Binding several datasets in a loop

If you have data that are stored in several files, you can join them in a loop. 
You can initialize a dataset with ```NULL``` and keep appending new rows, as long as the columns are compatible.

```
iris_full_df <- NULL
for (file_num in 1:5) {
    
    # Get a new dataset from somewhere.
    next_df <- iris_df
    # You might use a read.csv() function with a particular filename.
    
    # Append it to the full dataset from somewhere.
    iris_full_df <- rbind(iris_full_df, next_df)
}
summary(iris_full_df)
       Species     Petal.Length    Petal.Width     Sepal.Length    Sepal.Width   
 setosa    :250   Min.   :1.000   Min.   :0.100   Min.   :4.300   Min.   :2.000  
 versicolor:250   1st Qu.:1.600   1st Qu.:0.300   1st Qu.:5.100   1st Qu.:2.800  
 virginica :250   Median :4.350   Median :1.300   Median :5.800   Median :3.000  
                  Mean   :3.758   Mean   :1.199   Mean   :5.843   Mean   :3.057  
                  3rd Qu.:5.100   3rd Qu.:1.800   3rd Qu.:6.400   3rd Qu.:3.300  
                  Max.   :6.900   Max.   :2.500   Max.   :7.900   Max.   :4.400  
nrow(iris_full_df)
[1] 750
```
This produces a dataset with five smaller datasets stacked on top of each other. 


### Sorting data

Sort the data by one or more variable by using the ```order``` function in the row argument.
```
head(iris_df)
  Species Petal.Length Petal.Width Sepal.Length Sepal.Width
1  setosa          1.4         0.2          5.1         3.5
2  setosa          1.4         0.2          4.9         3.0
3  setosa          1.3         0.2          4.7         3.2
4  setosa          1.5         0.2          4.6         3.1
5  setosa          1.4         0.2          5.0         3.6
6  setosa          1.7         0.4          5.4         3.9
head(iris_df[order(iris_df$Petal.Length),])
   Species Petal.Length Petal.Width Sepal.Length Sepal.Width
23  setosa          1.0         0.2          4.6         3.6
14  setosa          1.1         0.1          4.3         3.0
15  setosa          1.2         0.2          5.8         4.0
36  setosa          1.2         0.2          5.0         3.2
3   setosa          1.3         0.2          4.7         3.2
17  setosa          1.3         0.4          5.4         3.9
```

### Exercise:
1. Calculate summary statistics for the three types
  of flowers separately.
2. List the petal width for flowers of type setosa
  with petal length larger than average.


