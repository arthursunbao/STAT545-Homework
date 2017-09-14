Exploration\_gapminder
================
Jason Sun
2017-09-14

Intro
-----

This is an intro document for introducing the exploration of gapminder dataset, which is a very famous dataset in R package and data science. I will use some basic R commands to show you the overview of gapminder dataset and I found that the R commands are very much like the pandas dataframe in Python :)

Overview
--------

Gapminder is a dataset like this, we first need to install the dataset using library(gapminder)

All right, after that the gapminder dataset is already loaded into RAM and now we can take a look at the general structure of it. We can use head(gapminder), which will show the first several lines of gapminder dataset.

'''R library(gapminder) head(gapminder) '''

    ##       country continent year lifeExp      pop gdpPercap
    ## 1 Afghanistan      Asia 1952  28.801  8425333  779.4453
    ## 2 Afghanistan      Asia 1957  30.332  9240934  820.8530
    ## 3 Afghanistan      Asia 1962  31.997 10267083  853.1007
    ## 4 Afghanistan      Asia 1967  34.020 11537966  836.1971
    ## 5 Afghanistan      Asia 1972  36.088 13079460  739.9811
    ## 6 Afghanistan      Asia 1977  38.438 14880372  786.1134
