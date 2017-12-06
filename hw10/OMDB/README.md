Homework 10: OMDBDataset Exploration
=====================

## About this folder
Hi Everyone!

This is the folder for STAT545 Homework 10 : OMDBDataset Exploration

For the homework: Make API queries “by hand” using httr
![Direct Link to the File](https://github.com/arthursunbao/STAT545-Homework/blob/master/hw10/OMDB/omdb_dataset_download_show.md "Direct Link to the File")

## Work That I have Done
My work contains three part: Fetch Data, Plot and Save and finally show the result here.

I used the rquired httr package to download the data via OMDBApi and automate the whole process using Makefile.

I created a function called get_movie_rating(name), which can get the rating of a specific movie with input name and the rating contains IMDB, RottonTomato and Met.

After calling the function, data will be saved as CSV file to local disk and during the plot process, we will do various filtering and take out the top 5 score of IMDB, RT and Met for Star Trek and Transformer as example and show as table as well as bar chart for the result to give the user an overview of what is the best movie in the series of Transformer and Star Trek.

The whole process is like the following: 

Fectch Data with OMDBApi and httr ----> Parse, Filter and Plot Graph ----> Show The Result


## Report My Process

It does take a lot of time to work on cleaning the data and getting familiar with the data structure of OMDB dataset as it is in JSON format as raw data. However, with the help of the httr, it really helps a lot to solve parsing the data as it is more like a tree strucutre and all I need to do is to traverse like a tree data structure.

## Dataset Source

Thanks for the help to OMDBApi as well as its database for movie. I am able to work out this project with abundant movie information, mostly for Star Trek and Transformers Movie Series IMDB, Met and RT rating and original movie information

