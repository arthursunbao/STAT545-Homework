A brief introduction into Gapminder Dataset
================
Jason Sun
2017-09-17

Intro
-----

This is an intro document for introducing the exploration of gapminder dataset, which is a very famous dataset in R package and data science. I will use some basic R commands to show you the overview of gapminder dataset and I found that the R commands are very much like the pandas dataframe in Python :)

Overview
--------

Gapminder is a dataset like this, we first need to install the dataset using library(gapminder)

### Brief View

All right, after that the gapminder dataset is already loaded into RAM and now we can take a look at the general structure of it. We can use head(gapminder), which will show the first several lines of gapminder dataset.

    ##       country continent year lifeExp      pop gdpPercap
    ## 1 Afghanistan      Asia 1952  28.801  8425333  779.4453
    ## 2 Afghanistan      Asia 1957  30.332  9240934  820.8530
    ## 3 Afghanistan      Asia 1962  31.997 10267083  853.1007
    ## 4 Afghanistan      Asia 1967  34.020 11537966  836.1971
    ## 5 Afghanistan      Asia 1972  36.088 13079460  739.9811
    ## 6 Afghanistan      Asia 1977  38.438 14880372  786.1134

### Full View

After that, if we want to see all the detail data of gapminder, then we can directly type into gapminder and it will show all the data afterwards. We will skip that part as the data will overwhelm the whole screen :)

### What is inside the datset ?

#### Attributes and Rows

Let's check out how many rows and columns of attributes do we have in total:

We can use dim(gapminder) to get the dimension of the dataset:

    ## [1] 1704    6

It is quite clear that the dataset contains 6 attributes: country, continent, year, lifeExp, pop, gdpPercap and we have 1704 rows in total.

All right. That is all for the entry intro to the dataset. Next time we will dig a little deeper into finding out the statistical facts of the dataset using some common R commands.
