Homework 10: Data from the Web
=====================

## About this folder
Hi Everyone!

This is the folder for STAT545 Homework 10 : Data from the Web

I will continue working with the **Make API queries “by hand” using httr** and **Scrape the web** as the latter one was the work we had during the course, which will be easier to pickup.

For the homework: Make API queries “by hand” using httr
![Direct Link to the File](https://github.com/arthursunbao/STAT545-Homework/tree/master/hw10/OMDB "Direct Link to the File")

For the homework: Scrape the web
![Direct Link to the File](https://github.com/arthursunbao/STAT545-Homework/tree/master/hw10/scrape_data "Direct Link to the File")


## Requirement For The Work

### Make API queries “by hand” using httr
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

For **Make API queries “by hand” using httr**

My work contains three part: Fetch Data, Plot and Save and finally show the result here.

I used the rquired httr package to download the data via OMDBApi and automate the whole process using Makefile.

I created a function called get_movie_rating(name), which can get the rating of a specific movie with input name and the rating contains IMDB, RottonTomato and Met.

After calling the function, data will be saved as CSV file to local disk and during the plot process, we will do various filtering and take out the top 5 score of IMDB, RT and Met for Star Trek and Transformer as example and show as table as well as bar chart for the result to give the user an overview of what is the best movie in the series of Transformer and Star Trek.

The whole process is like the following: 

Fectch Data with OMDBApi and httr ----> Parse, Filter and Plot Graph ----> Show The Result

For **Scrape the web**

I have continued with the slide's requirement in bestplace.com to dig information with rvest and I 

choose to find some crime information in Missouri and its counties. I firstly find out all the counties in Missouri and its respecitve crime link in the website and then saved as a dataframe for the next step's exploration. Then I choose a random county to download the detailed crime information of the county and showed as text.

The whole process is like this: scrape_data ----> scrape_download_show

You can use Makefile to automate the whole process.

During the process, I have learned a lot about HTML, CSS as I am not very familiar with those two tags and languages. The difficult lies in how to understand the API function of rvest in response to the tag in CSS and HTML. It does take time to understand but after some research, all problems are solved. 

## Dataset Source

For **Make API queries “by hand” using httr**

Thanks for the help to OMDBApi as well as its database for movie. I am able to work out this project with abundant movie information, mostly for Star Trek and Transformers Movie Series IMDB, Met and RT rating and original movie information

For **Scrape the web**

Thanks for the data provided by bestplace.com. I was able to dig a bit deeper for the crime information in the US. 

## Some technical Reference that I referred to

Offical Httr Website: https://cran.r-project.org/web/packages/httr/index.html

pandoc version 1.12.3 or higher is required and was not found (R shiny) :https://stackoverflow.com/questions/28432607/pandoc-version-1-12-3-or-higher-is-required-and-was-not-found-r-shiny/29710643#29710643

rvest: easy web scraping with R: https://blog.rstudio.com/2014/11/24/rvest-easy-web-scraping-with-r/

rvest: Easily Harvest (Scrape) Web Pages: https://cran.r-project.org/web/packages/rvest/index.html



