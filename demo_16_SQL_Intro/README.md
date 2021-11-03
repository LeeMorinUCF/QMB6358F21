# Interacting with Databases Using SQL Scripts

In this section, we will learn how information can be stored, 
retrieved and organized using databases. 
Businesses and other organizations rely heavily on databases to keep track of information 
for many accounting and payroll functions.
Your very own information is stored in many databases.
For example, the IRS keeps a record of your tax information by 
recording amounts in the fields of your tax return, 
your vital statistics, and the primary key is your social security number. 
If you have a driver's license, the DMV keeps a record of your vehicles, 
any tickets you may have received, your vital statistics, 
and these are indexed by your driver's license number as the primary key. 
The same is true for any online purchases you make: 
your order details, your address and your purchase history 
are all stored in a database with some form of customer id number and order number. 
The primary reason for a business analyst or data scientist to use databases
is to generate a dataset from the information stored in databases. 

The primary tool that we will use is the Python module ```sqlite3```. 
SQL is an acronym for *Structured Query Language*, 
which is either pronounced "S-Q-L" or "sequel". 
It is a language or, more precisely, a set of dialects that are used to 
execute commands called *queries* using *relational databases*. 
There exist many dialects of SQL and in fact, many other database structures
that do not fall under the SQL paradigm. 
However, SQL is ubiquitous in business and is a stepping stone to more advanced
methods of interacting with databases.
The dialect of SQL called ```sqlite3``` is a compact and versatile 
set of infrastructure for executing SQL queries and interacting with databases. 

SQL is a language in its own right, so it makes sense 
to write your queries in dedicated SQL scripts. 
This way, the same operations can be used on a number of different platforms:
you could run them in the GUI of a database manager, 
you could submit them through a terminal window,
you could run your queries in R using a package such as ```sqldf```,
and you can read the text of the SQL query in Python 
by using the ```sqlite3``` module.


## Basic SQL Example

We'll start with a simple example before we get too far. 

### Operations on a single table

First specify the *schema* of the first table.
The *schema* is the list of specifications for the table, 
including the names of *fields* and the data types of the variables
in each field. 

```
CREATE TABLE FirstTable(
KeyID          INTEGER NOT NULL ,
Date           TEXT NOT NULL ,
Name           TEXT NOT NULL ,
PRIMARY KEY    (KeyID)
);
```

This query is saved in the SQL script ```CreateFirstTable.sql```, 
which can be used to enter the information directly
into the SQLite3 interface. 
For now, we can run it by entering the SQL code at the ```sqlite3``` prompt. 

```
sqlite> CREATE TABLE FirstTable(
   ...> KeyID          INTEGER NOT NULL ,
   ...> Date           TEXT NOT NULL ,
   ...> Name           TEXT NOT NULL ,
   ...> PRIMARY KEY    (KeyID)
   ...> );
```


To verify that the schema for the table was created, 
you can output the schema by using the command 

```
sqlite> .schema
```

It outputs the following:
```
CREATE TABLE FirstTable(
KeyID          INTEGER NOT NULL ,
Date           TEXT NOT NULL ,
Name           TEXT NOT NULL ,
PRIMARY KEY    (KeyID)
);
sqlite> 
```
The most important parameters at this stage are the names of the fields 
and the data types. 
Aside from checking for mistakes made on input, this is especially useful for understanding a database created by someone else. 

The last line is the ```sqlite3``` prompt awaiting another command. 
You can then populate ```FirstTable``` with a few entries as follows

```
INSERT INTO FirstTable(KeyID, Date, Name)
VALUES(1, "20131204", "Harry J. Paarsch");
INSERT INTO FirstTable(KeyID, Date, Name)
VALUES(2, "20131204", "Konstantin Golyaev");
INSERT INTO FirstTable(KeyID, Date, Name)
VALUES(3, "20131204", "Alberto M. Segre");
```

This information is recorded in the SQL script ```PopulateFirstTable.sql```
but we can run the commands at the ```sqlite3``` command prompt.



To see the table entered above, you can execute the simplest SQL query
```
SELECT * FROM FirstTable;
```
which will return the entire table. 
```
sqlite> SELECT * FROM FirstTable;
1|20131204|Harry J. Paarsch
2|20131204|Konstantin Golyaev
3|20131204|Alberto M. Segre
sqlite> 

```


You can execute a query with a restriction by adding a ```WHERE``` clause



```
SELECT * FROM FirstTable WHERE KeyID > 1;
```
And it outputs only the records with ```KeyID > 1```:

```
sqlite> SELECT * FROM FirstTable WHERE KeyID > 1;
SELECT * FROM FirstTable WHERE KeyID > 1;
2|20131204|Konstantin Golyaev
3|20131204|Alberto M. Segre
sqlite> 
```



Alternatively, you can execute a query with a projection by specifying the fields
```
SELECT Name, Date FROM FirstTable;
```

The output is

```
sqlite> SELECT Name, Date FROM FirstTable;
Harry J. Paarsch|20131204
Konstantin Golyaev|20131204
Alberto M. Segre|20131204
sqlite> 
```

If you prefer variables that are functions of the fields in the table, you can specify them with additional functions.

```
SELECT 
    Name ,
    SUBSTR(Date, 1, 4) as Year 
FROM FirstTable;
```
The function ```SUBSTR``` takes a substring 
from the characters in a field of type ```TEXT```:

```
sqlite> SELECT 
   ...>     Name ,
   ...>     SUBSTR(Date, 1, 4) as Year 
   ...> FROM FirstTable;
Harry J. Paarsch|2013
Konstantin Golyaev|2013
Alberto M. Segre|2013
sqlite> 
```


Finally, you can combine these operations in a more complex query

```
SELECT 
    Name ,
    SUBSTR(Date, 1, 4) as Year 
FROM 
    FirstTable
WHERE KeyID > 1;
```
And when you run this command, 
it performs both operations:


```
sqlite> SELECT 
   ...>     Name ,
   ...>     SUBSTR(Date, 1, 4) as Year 
   ...> FROM 
   ...>     FirstTable
   ...> WHERE KeyID > 1;
Konstantin Golyaev|2013
Alberto M. Segre|2013
sqlite> 
```


### Combining more than one table

To add another table, 
first specify the schema of this table

```
CREATE TABLE SecondTable(
KeyID          INTEGER PRIMARY KEY ,
OtherID        INTEGER,
Name           TEXT NOT NULL ,
FOREIGN KEY    (OtherID) REFERENCES FirstTable (KeyID)
);
```


Next populate ```SecondTable``` with a few entries as follows

```
INSERT INTO SecondTable(KeyID, OtherID, Name)
VALUES(101, 1, "Harry J. Paarsch");
INSERT INTO SecondTable(KeyID, OtherID, Name)
VALUES(102, 2, "Konstantin Golyaev");
```

Now you can verify the contents of the database with ```.tables``` and ```.schema```:

```
sqlite> .tables
FirstTable   SecondTable
sqlite> .schema
CREATE TABLE FirstTable(
KeyID          INTEGER NOT NULL ,
Date           TEXT NOT NULL ,
Name           TEXT NOT NULL ,
PRIMARY KEY    (KeyID)
);
CREATE TABLE SecondTable(
KeyID          INTEGER PRIMARY KEY ,
OtherID        INTEGER,
Name           TEXT NOT NULL ,
FOREIGN KEY    (OtherID) REFERENCES FirstTable (KeyID)
);
sqlite> 
```



In addition, for a small example like this, you can output the tables to screen

```
sqlite> SELECT * FROM FirstTable;
SELECT * FROM FirstTable;
1|20131204|Harry J. Paarsch
2|20131204|Konstantin Golyaev
3|20131204|Alberto M. Segre
sqlite> SELECT * FROM SecondTable;
101|1|Harry J. Paarsch
102|2|Konstantin Golyaev
sqlite> 

```


With two tables, you can implement what is sometimes called a *theta join*. 
Theta is the Greek letter that is sometimes used to denote the operation
of combining tables. 

```
SELECT 
    FirstTable.KeyID ,
    SecondTable.KeyID ,
    FirstTable.Name
FROM
    FirstTable ,
    SecondTable
WHERE 
    (FirstTable.Name = SecondTable.Name)
AND
    (FirstTable.KeyID = SecondTable.OtherID)
;
```

### Using Command Files

One of the benefits of writing your queries in separate files is *portability*: 
SQL is a language in its own right, so you can run scripts with SQL queries
on a number of different platforms. 

If your commands are collected into ```.sql``` scripts 
then it would also serve as a form of documentation, 
enabling someone else to build upon your work in the future.

See the scripts ```FirstTable.sql```, ```SecondTable.sql``` and ```ExampleThetaJoin.sql``` above.


You can create the first table by running the command 

```
sqlite> .read FirstTable.sql
```
at the ```sqlite>``` prompt and likewise for the second table. 
Verify the result by entering 
```.tables``` (which lists the tables in the database) 
and ```.schema``` (which shows the fields and data types in each table), 
which are other sqlite3 commands that work at the command prompt.

Run the sample query by entering 
```
sqlite> .read ExampleThetaJoin.sql
```
at the ```sqlite>``` prompt.

To see the result, type ```cat ExampleThetaJoin.csv``` in a terminal window or open it in any text editor. 

This is just one more among many ways to submit SQL queries to a database. 


## Auctions Database

In this example, the procedure is made more scalable by reading the tables from ```.csv``` files.
The procedure is very similar, aside from the commands for reading in the data.


Open a database to create in sqlite3 from the terminal window
(before opening ```sqlite3```).
```
sqlite3 SampleDataBase.db
```

Now read in the schema for the two tables that will make up ```SampleDataBase.db```.

```
sqlite> .read FirstTable.sql
sqlite> .read SecondTable.sql
```

To verify the list of tables, you can enter ```.tables``` and the table names will be listed.
The command ```.schema``` will display the schema for the tables.
However, to display the contents themselves, you can enter the basic query

```
sqlite> SELECT * FROM FirstTable;
```
and likewise for ```SecondTable```.

To execute the SQL query coded into the script ```ExampleThetaJoin.sql```, use the command ```.read``` at the ```sqlite>``` prompt,
just as you did for the creation of the tables.

```
sqlite> .read ExampleThetaJoin.sql
```

Since the script ```ExampleThetaJoin.sql``` includes a statement to output to a specific file
(```.output OutFileName.csv``` and the associated options), the resulting table can be seen in the working directory and viewed with any text editor.



## Auctions Database

In this example, the procedure is made more scalable by reading the tables from ```.csv``` files.
The procedure is very similar, aside from the commands for reading in the data.

For this example, quit sqlite and open a new database
```
sqlite3 AuctionsDataBase.db
```

Next, read in the scripts ```CreateAuctionsTable.sql```, ```CreateBiddersTable.sql``` and ```CreateBidsTable.sql``` to create the tables, just as for the sample database.

As above, you can verify the entry by executing the ```.tables``` and ```.schema``` commands.

The next step is to populate the tables with the ```.csv``` files associated with each, using the ```.import``` command.
```
.separator ,
.import AuctionsTable.csv Auctions
.import BiddersTable.csv Bidders
.import BidsTable.csv Bids
```

You can still verify the contents of the tables with the query
```
SELECT * FROM Auctions;
```
and so on but we will move on to running the queries instead.
To view the products of the queries, you may want to keep open a terminal window to view the output of ```ls``` before and after the query to see the output file created.

As above, execute the queries using the ```.read``` command at the ```sqlite>``` prompt.

```
sqlite> .read ComputeBidSummariesByBidder.sql
```
which executes the following query.
```
SELECT 
    b.BidderID     AS BidderID , 
    MIN(b.Bid)     AS SmallestBid , 
    AVG(b.Bid)     AS AverageBid , 
    MAX(b.Bid)     AS LargestBid 
FROM 
    Bids AS b 
GROUP BY 
    b.BidderID 
;
```

Notice that we use the keyword ```AS``` for both the
variables and the tables:
Since we are calculating the variables, they do not have names.
For the table, we can abbreviate the name,
which is often useful in practice when the name of the table
might be uninformative or excessively long.


Now you can view the table ```ComputeBidSummariesByBidder.out``` as specified in the script.
The procedure is the same for the other queries.


The above query performs two main actions. 
First, it aggregates data by bidder. Second, it joins data from two different tables. 
Let's look at these two components separately. 







### Aggregation 

The aggregation step allows you to calculate functions of the data and tabulate them by different values of a particular variable. 

```
SELECT 
    AVG(bids.Bid) AS AverageBid
FROM
    Bids AS bids
GROUP BY
    bids.BidderID
;
```

You can add unique variables aggregated by the grouping variable.

```
SELECT 
    bids.BidderID,
    AVG(bids.Bis) AS AverageBid
FROM
    Bids AS bids
GROUP BY
    bids.BidderID
;
```





### Joins

An intermediate step is to join together two tables by the join key ```BidderID```. 

```
SELECT 
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName,
    bids.Bid
FROM
    Bids AS bids
INNER JOIN Bidders AS bidders
    ON bids.BidderID = bidders.BidderID
;
```


The ```INNER JOIN``` is but one of several kinds of joins possible. 
Since a feature of this database is that every bid corresponds to one bidder in the bidder table, this example is not rich enough to demonstrate the various kinds of joins. 
As part of the following examples, the query is made more complex by introducing subqueries in the place of the joined tables, 
```WHERE``` the table on one side is missing some rows, 
to illustrate what happens when this is the case.

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
Examples of these joins are as follows. 


#### Left Join

The ```LEFT JOIN``` collects all of the entries that appear in the *first*, 
or ```LEFT``` table but are not necessarily in both tables.


```
SELECT 
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName,
    AVG(bids.Bid) AS AverageBid
FROM
    Bids AS bids
LEFT JOIN (SELECT * FROM Bidders WHERE BidderID < 6) AS bidders
    ON bids.BidderID = bidders.BidderID
GROUP BY 
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName
;
```

#### Right Join

The ```RIGHT JOIN``` collects all of the entries that appear in the *second*, 
or ```RIGHT``` table but are not necessarily in both tables.

```
SELECT 
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName,
    AVG(bids.Bid) AS AverageBid
FROM
    (SELECT * FROM Bids WHERE BidderID > 2) AS bids
RIGHT JOIN Bidders AS bidders
    ON bids.BidderID = bidders.BidderID
GROUP BY 
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName
;
```

Notice that sqlite3 will complain if you try to do a ```RIGHT JOIN```. 
That is part of what makes it "lite". 
It is not much of a loss, however, 
because a ```RIGHT JOIN``` can be done with a ```LEFT JOIN```, 
with the tables A and B switched. 

#### Inner Join

The ```INNER JOIN``` collects all of the entries that appear in *both* tables. 

```
SELECT 
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName,
    AVG(bids.Bid) AS AverageBid
FROM
    (SELECT * FROM Bids WHERE BidderID > 2) AS bids
INNER JOIN (SELECT * FROM Bidders WHERE BidderID < 6) AS bidders
    ON bids.BidderID = bidders.BidderID
GROUP BY 
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName
;
```

As with a ```RIGHT JOIN```, an ```INNER JOIN``` can be done 
with a ```LEFT JOIN```, 
with a ```WHERE``` clause to exclude missing values in table B. 


#### Outer Join

The ```OUTER JOIN``` collects all of the entries that appear in *any* of the tables. 

```
SELECT 
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName,
    AVG(bids.Bid) AS AverageBid
FROM
    (SELECT * FROM Bids WHERE BidderID > 2) AS bids
FULL OUTER JOIN (SELECT * FROM Bidders WHERE BidderID < 6) AS bidders
    ON bids.BidderID = bidders.BidderID
GROUP BY 
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName
;
```

As with ```RIGHT JOIN```s, sqlite3 does not have this functionality. 
It can, however, be accomplished with two queries with ```RIGHT``` and ```LEFT JOIN```s
that are stacked with a ```UNION``` clause 
and the ```DISTINCT``` qualifier to eliminate duplicate entries that appear in both tables. 

With this in mind, you can usually achieve anything you need to with a ```LEFT JOIN```, 
so sqlite3 is not as light as it may seem. 


### Filters


As in many of the examples we have studied use ```WHERE``` clause, 
one can select a subset of rows satisfying certain criteria. 
In the same sense that the ```SELECT``` keyword selects columns of data, the vertical dimension,
the ```WHERE``` keyword is used to select rows, the horizontal dimension. 

Run the script ```ComputeBidSummariesAndFilter.sql``` to see such an example using a ```WHERE``` clause. 
In the textbook, *A Gentle Introduction to Effective Computing in 
Quantitative Research* by Paarsch and Golyaev, 
you will find an alternative approach using a ```HAVING``` clause, 
which is another alternative. 




