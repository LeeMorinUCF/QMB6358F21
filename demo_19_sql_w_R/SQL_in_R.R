##################################################
#
# QMB 6358: Software Tools for Business Analytics
#
# SQL in R
# Executing SQL queries to aggregate and join data in data frames.
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# November 19, 2020
#
##################################################
#
# SQL_in_R shows how to execute SQL queries
#   using tables read as dataframes from csv files.
#   The SQL queries are used to aggregate and join data
#   and output data frames.
#
# Dependencies:
#   library(sqldf)
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
# wd_path <- '/path/to/your/folder'
wd_path <- 'C:/Users/le279259/Documents/Teaching/QMB6358_Fall_2020/GitRepos/QMB6358F20/demo_18_sql_w_R'

setwd(wd_path)

# Load the sqldf package to use data frames with SQL queries.
# Need to install it the first time.
# install.packages('sqldf')
library(sqldf)


##################################################
# Load tables from auction database
##################################################

# Read the raw data.
# Auctions <- read.csv('AuctionsTable.csv', header = FALSE)
Auctions <- read.csv('AuctionsTable.csv')
Bidders <- read.csv('BiddersTable.csv')
Bids <- read.csv('BidsTable.csv')

# Define the column names.
# The rest of the schema is inferred from the data,
# just as with any other data frame.
colnames(Auctions) <- c('AuctionID', 'Volume', 'District', 'Date')
colnames(Bidders) <- c('BidderID', 'FirstName', 'LastName',
                       'Address1', 'Address2', 'Town', 'Province', 'PostalCode',
                       'Telephone', 'Email', 'Preferred')
colnames(Bids) <- c('BidID', 'AuctionID', 'BidderID', 'Bid')







##################################################
# Execute queries with these tables
##################################################

# Display the contents of the tables.
sqldf('SELECT * FROM Auctions;')
sqldf('SELECT * FROM Bidders;')
sqldf('SELECT * FROM Bids;')

# Output the data frame.
bid_df <- sqldf('SELECT * FROM Bids;')
write.csv(bid_df, file = 'copy_of_bids_table.csv')


# Execute queries with aggregation.
sqldf('SELECT
        AVG(bids.Bid) AS AverageBid
      FROM
        Bids AS bids
      GROUP BY
        bids.BidderID
      ;')


sqldf('SELECT
        bids.BidderID,
        AVG(bids.Bid) AS AverageBid
      FROM
        Bids AS bids
      GROUP BY
        bids.BidderID
      ;')


# Execute queries with joins.
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




#--------------------------------------------------
# Example of left join.
#--------------------------------------------------

# Use this nested query to use a subset
# of the database on the right:
sqldf('SELECT * FROM Bidders WHERE BidderID < 6')
# Which is a subset of:
sqldf('SELECT * FROM Bidders')


# Left join:
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
# Note that some bidder names were not included
# when dropping BidderID >= 6.
# The joined AverageBid on the right is include anyway,
# with bidder information left blank.

# What if you didn't want the missing bidders?
# Turn this into an inner join.
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



#--------------------------------------------------
# Inner join.
#--------------------------------------------------

# Use another nested query to use a subset
# of the database on the left:
sqldf('SELECT * FROM Bids WHERE BidderID > 2')
# Which is a subset of:
sqldf('SELECT * FROM Bids')

# Inner join:
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
# With an inner join, the dropped observations from either table
# are dropped from the joined table as well.



#--------------------------------------------------
# Outer join.
#--------------------------------------------------

# Combine both nested queries:
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
# FAIL: Not all pakages support outer joins.
# It is just a regular merge without much SQL machinery anyway.

# Most queries can be executed with left joins.
# It is a matter of choosing the table on the left.

#--------------------------------------------------
# Right join.
#--------------------------------------------------

# Same goes for right joins:
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

# How to fix this:
# Switch left and right tables.

# New left join:
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


##################################################
# Unions
##################################################

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



##################################################
# Reading in the Query from an SQL Script
##################################################

# Read the text from the SQL script.
query_1 <- readLines('ComputeBidSummariesByBidder.sql',
                     n = 21)
# See which lines contain the query.
query_1
# Select the lines containing the query.
query_1[11:20]

# Execute the query, after collapsing into a single line.
sqldf(paste(query_1[11:20], collapse = ' '))


# Read and execute the next query.
query_2 <- readLines('ComputeBidSummariesAndJoinNames.sql',
                     n = 27)
# See which lines contain the query.
query_2
# Select those lines.
query_2[12:26]


# Execute the query, after collapsing into a single line.
sqldf(paste(query_2[12:26], collapse = ' '))


# In practice, you might use an sql script
# that contains only the query for this purpose,
# rather than the script designed for outputting a file.
# But, then again, you might use this method to test
# the query on a small sample of data to get it working
# before you run it on the full database on another platform.


##################################################
# End
##################################################

