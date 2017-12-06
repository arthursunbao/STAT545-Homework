Homework 10: Data from the Web
=====================

## About this folder
Hi Everyone!

This is the folder for STAT545 Homework 10 : Data from the Web

For the homework: Make API queries “by hand” using httr
![Direct Link to the File](https://github.com/arthursunbao/foofactors "Direct Link to the File")

I will continue working with the **Make API queries “by hand” using httr** and **Scrape the web** as the latter one was the work we had during the course, which will be easier to pickup.

## Requirement For The Work

###Make API queries “by hand” using httr
Create a dataset with multiple records by requesting data from an API using the httr package.

GET() data from the API and convert it into a clean and tidy data frame. Store that as a file ready for (hypothetical!) downstream analysis. Do just enough basic exploration of the resulting data, possibly including some plots, that you and a reader are convinced you’ve successfully downloaded and cleaned it.

Take as many of these opportunities as you can justify to make your task more interesting and realistic, to use techniques from elsewhere in the course (esp. nested list processing with purrr), and to gain experience with more sophisticated usage of httr.

Get multiple items via the API (i.e. an endpoint that returns multiple items at once) vs. use an iterative framework in R.
Traverse pages.

Send an authorization token. The GitHub API is definitely good one to practice with here.

Use httr’s facilities to modify the URL and your request, e.g., query parameters, path modification, custom headers.

### Scrape data

Work through the final set of slides from the rOpenSci UseR! 2016 workshop. This will give you basic orientation, skills, and pointers on the rvest package.

Scrape a multi-record dataset off the web! Convert it into a clean and tidy data frame. Store that as a file ready for (hypothetical!) downstream analysis. Do just enough basic exploration of the resulting data, possibly including some plots, that you and a reader are convinced you’ve successfully downloaded and cleaned it.

I think it’s dubious to scrape data that is available through a proper API, so if you do that anyway … perhaps you should get the data both ways and reflect on the comparison. Also, make sure you not violating a site’s terms of service or your own ethical standards with your webscraping. Just because you can, it doesn’t mean you should!

## Report My Process

It does take a lot of time to work on cleaning the data and getting familiar with the data structure of OMDB dataset as it is in JSON format as raw data. However, with the help of the httr, it really helps a lot to solve parsing the data as it is more like a tree strucutre and all I need to do is to traverse like a tree data structure.

## Dataset Source

Thanks for the help to OMDBApi as well as its database for movie. I am able to work out this project with abundant movie information, mostly for Star Trek and Transformers Movie Series IMDB, Met and RT rating and original movie information

## Some technical Reference that I referred to

![httr Offical Website:](https://cran.r-project.org/web/packages/httr/index.html)


