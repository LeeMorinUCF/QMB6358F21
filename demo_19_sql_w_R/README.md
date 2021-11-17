# SQL in R

In this demo, we will execute SQL queries 
to aggregate and join data in data frames
using the ```sqldf``` package in R.

The script ```SQL_in_R.R``` 
shows how to execute SQL queries
using tables read as data frames from csv files.
The SQL queries are used to aggregate and join data
and also output the resulting tables as new data frames.



First, load the ```sqldf``` package 
to use data frames with SQL queries.
You will need to install it the first time:

```R
install.packages('sqldf')
```

After the first time you install the package, 
you can attach it to your workspace.

```R
library(sqldf)
```

## Loading Tables 

Now read the raw data from the auction database.
Normally, you might use the command 
```
Auctions <- read.csv('AuctionsTable.csv')
```
but in this case, the files have no headers, 
so R will wrongly assume that the first row of observations
is the header with column names. 

Instead, we will pass an argument 
to indicate that the data do not have headers.

```
Auctions <- read.csv('AuctionsTable.csv', header = FALSE)
Bidders <- read.csv('BiddersTable.csv', header = FALSE)
Bids <- read.csv('BidsTable.csv', header = FALSE)
```


Now define the column names.
With ```sqldf```, 
the rest of the schema is inferred from the data,
just as with any other data frame.

```
colnames(Auctions) <- c('AuctionID', 'Volume', 'District', 'Date')
colnames(Bidders) <- c('BidderID', 'FirstName', 'LastName',
                       'Address1', 'Address2', 'Town', 'Province', 'PostalCode',
                       'Telephone', 'Email', 'Preferred')
colnames(Bids) <- c('BidID', 'AuctionID', 'BidderID', 'Bid')
```
Now that we have data frames loaded into memory, 
we can run SQL queries on the data. 


## Executing SQL Queries

For small examples, you can use the ```SELECT *```
query to display the entire contents of the tables.
On an industrial-strength platform, 
this might return a table large enough to reach memory limitations.

```
sqldf('SELECT * FROM Auctions;')
sqldf('SELECT * FROM Bidders;')
sqldf('SELECT * FROM Bids;')
```

## Outputting Tables


Before we get started, you can use any of the standard
functions for handling data frames with the 
tables output from ```sqldf```.

```
# Output the data frame, if necessary.
bid_df <- sqldf('SELECT * FROM Bids;')
write.csv(bid_df, file = 'copy_of_bids_table.csv')
```


### Aggregation

For more interesting examples, we can execute 
queries with aggregation.

```
sqldf('SELECT
        AVG(bids.Bid) AS AverageBid
      FROM
        Bids AS bids
      GROUP BY
        bids.BidderID
      ;')
```

```
sqldf('SELECT
        bids.BidderID,
        AVG(bids.Bid) AS AverageBid
      FROM
        Bids AS bids
      GROUP BY
        bids.BidderID
      ;')
```


## Joining Tables

Execute queries with joins.

```
sqldf('SELECT
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName,
        bids.Bid
      FROM
        Bids AS bids
      INNER JOIN
        Bidders AS bidders
      ON
        bids.BidderID = bidders.BidderID
      ;')
```



### Example of left join.

Use this nested query to use a subset
of the database on the right:

```
sqldf('SELECT * FROM Bidders WHERE BidderID < 6')
```

which is a subset of the full table:

```
sqldf('SELECT * FROM Bidders')
```


Now execute the left join.

```
sqldf('SELECT
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName,
        AVG(bids.Bid) AS AverageBid
      FROM
        Bids AS bids
      LEFT JOIN
        (SELECT * FROM Bidders WHERE BidderID < 6) AS bidders
      ON
        bids.BidderID = bidders.BidderID
      GROUP BY
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName
      ;')
```

Note that some bidder names were not included
when dropping ```BidderID >= 6```.
The joined ```AverageBid``` on the right 
is included anyway,
with bidder information left blank.

What if you didn't want the missing bidders?
Turn this query into an inner join.

```
sqldf('SELECT
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName,
        AVG(bids.Bid) AS AverageBid
      FROM
        Bids AS bids
      LEFT JOIN
        (SELECT * FROM Bidders WHERE BidderID < 6) AS bidders
      ON
        bids.BidderID = bidders.BidderID
      WHERE
        bidders.BidderID IS NOT NULL
      GROUP BY
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName
      ;')
```


### Inner join.

Use another nested query to use a subset
of the database on the left:

```
sqldf('SELECT * FROM Bids WHERE BidderID > 2')
```

which is a subset of:

```
sqldf('SELECT * FROM Bids')
```


Now perform an inner join:

```
sqldf('SELECT
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName,
        AVG(bids.Bid) AS AverageBid
      FROM
        (SELECT * FROM Bids WHERE BidderID > 2) AS bids
      INNER JOIN
        (SELECT * FROM Bidders WHERE BidderID < 6) AS bidders
      ON
        bids.BidderID = bidders.BidderID
      GROUP BY
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName
      ;')
```

With an inner join, the dropped observations from either table
are dropped from the joined table as well.



### Outer join.

Combine both nested queries:

```
sqldf('SELECT
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
      ;')
```
      
Note that this time the query fails to execute: 
Not all packages support outer joins.
This task is simply a regular merge without much SQL machinery anyway.

Most queries can be executed with left joins.
It is a matter of choosing the table on the left.

### Right join.

The same goes for right joins:

```
sqldf('
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
')
```


To fix this: simply switch left and right tables.
Left and right joins are symmetric. 

The new left join is:

```
sqldf('
  SELECT
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName,
    AVG(bids.Bid) AS AverageBid
  FROM
    Bidders AS bidders
  LEFT JOIN (SELECT * FROM Bids WHERE BidderID > 2) AS bids
    ON bids.BidderID = bidders.BidderID
  GROUP BY
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName
  ;
')
```

### Unions

This operation could be used to recreate an outer join by
stacking the data from multiple tables.

A simple example stacking two identical tables
is as follows. 

```
sqldf('
  SELECT
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName,
    AVG(bids.Bid) AS AverageBid,
    1 AS TableNum
  FROM
    Bidders AS bidders
  LEFT JOIN (SELECT * FROM Bids WHERE BidderID > 2) AS bids
    ON bids.BidderID = bidders.BidderID
  GROUP BY
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName
  UNION ALL
  SELECT
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName,
    AVG(bids.Bid) AS AverageBid,
    2 AS TableNum
  FROM
    Bidders AS bidders
  LEFT JOIN (SELECT * FROM Bids WHERE BidderID > 2) AS bids
    ON bids.BidderID = bidders.BidderID
  GROUP BY
    bidders.BidderID,
    bidders.FirstName,
    bidders.LastName
  ;
')
```

You could add ```WHERE``` clauses or 
```DISTINCT``` qualifiers
to drop any unwanted observations. 


## Reading Queries from SQL Scripts

You can also read the text of a query 
from an SQL script using standard File IO commands.

```
query_1 <- readLines('ComputeBidSummariesByBidder.sql',
                     n = 21)
```

Inspect the text to determine 
which lines contain the query.

```
query_1
```

Now select the lines containing the query.

```
query_1[11:20]
```

Finally, execute the query, 
after collapsing the text of the query into a single line.

```
sqldf(paste(query_1[11:20], collapse = ' '))
```

Now read and execute the next query.


```
query_2 <- readLines('ComputeBidSummariesAndJoinNames.sql',
                     n = 27)
```


Again, determine which lines contain the query.

```
query_2
```

Select those lines to pass to the ```sqldf``` function.
```
query_2[12:26]
```

Execute the query, after collapsing into a single line.

```
sqldf(paste(query_2[12:26], collapse = ' '))
```

In practice, you might use an SQL script
that contains only the query for this purpose,
rather than the script designed for outputting a file.
But, then again, you might use this method to test
the query on a small sample of data to get it working
before you run it on the full database on another platform.

