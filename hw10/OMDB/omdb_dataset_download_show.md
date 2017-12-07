omdb\_dataset\_download\_show
================
Jason Sun
12/5/2017

Let's load some library first
-----------------------------

``` r
library(purrr)
```

    ## Warning: package 'purrr' was built under R version 3.4.2

``` r
library(ggplot2)
library(reshape)
library(stringr)
library(tidyverse)
```

    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: dplyr

    ## Warning: package 'dplyr' was built under R version 3.4.2

    ## Conflicts with tidy packages ----------------------------------------------

    ## expand(): tidyr, reshape
    ## filter(): dplyr, stats
    ## lag():    dplyr, stats
    ## rename(): dplyr, reshape

``` r
library(glue)
```

    ## Warning: package 'glue' was built under R version 3.4.2

    ## 
    ## Attaching package: 'glue'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     collapse

``` r
library(plyr)
```

    ## -------------------------------------------------------------------------

    ## You have loaded plyr after dplyr - this is likely to cause problems.
    ## If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
    ## library(plyr); library(dplyr)

    ## -------------------------------------------------------------------------

    ## 
    ## Attaching package: 'plyr'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     arrange, count, desc, failwith, id, mutate, rename, summarise,
    ##     summarize

    ## The following objects are masked from 'package:reshape':
    ## 
    ##     rename, round_any

    ## The following object is masked from 'package:purrr':
    ## 
    ##     compact

Let's see the requirement for this work
---------------------------------------

Create a dataset with multiple records by requesting data from an API using the httr package.

GET() data from the API and convert it into a clean and tidy data frame. Store that as a file ready for (hypothetical!) downstream analysis. Do just enough basic exploration of the resulting data, possibly including some plots, that you and a reader are convinced you’ve successfully downloaded and cleaned it.

Take as many of these opportunities as you can justify to make your task more interesting and realistic, to use techniques from elsewhere in the course (esp. nested list processing with purrr), and to gain experience with more sophisticated usage of httr.

Get multiple items via the API (i.e. an endpoint that returns multiple items at once) vs. use an iterative framework in R. Traverse pages.

Send an authorization token. The GitHub API is definitely good one to practice with here.

Use httr’s facilities to modify the URL and your request, e.g., query parameters, path modification, custom headers.

Work That I have Done
---------------------

My work contains three part: Fetch Data, Plot and Save and finally show the result here.

I used the rquired httr package to download the data via OMDBApi and automate the whole process using Makefile.

I created a function called get\_movie\_rating(name), which can get the rating of a specific movie with input name and the rating contains IMDB, RottonTomato and Met.

After calling the function, data will be saved as CSV file to local disk and during the plot process, we will do various filtering and take out the top 5 score of IMDB, RT and Met for Star Trek and Transformer as example and show as table as well as bar chart for the result to give the user an overview of what is the best movie in the series of Transformer and Star Trek.

The whole process is like the following:

Fectch Data with OMDBApi and httr ----&gt; Parse, Filter and Plot Graph ----&gt; Show The Result

Let's do some work
------------------

You can also embed plots, for example:

``` r
#Get the data from the csv
movie_rating_transformers <-read_csv("./transformers_rating.csv")
movie_rating_startrek <- read_csv("./star_trek_rating.csv")
```

Let's get a brief overview of the current dataset we have for transformers

``` r
knitr::kable(movie_rating_transformers)
```

| movie\_title                        | Year      |  imdb|   RT|  Met|
|:------------------------------------|:----------|-----:|----:|----:|
| Transformers                        | 2007      |   7.1|  5.7|  6.1|
| Transformers: Dark of the Moon      | 2011      |   6.3|  3.5|  4.2|
| Transformers: Revenge of the Fallen | 2009      |   6.0|  1.9|  3.5|
| Transformers: Age of Extinction     | 2014      |   5.7|  1.8|  3.2|
| Transformers: The Last Knight       | 2017      |   5.2|  1.5|  2.8|
| The Transformers: The Movie         | 1986      |   7.3|  5.5|   NA|
| The Transformers                    | 1984–1987 |   8.0|   NA|   NA|
| Beast Wars: Transformers            | 1996–1999 |   8.2|   NA|   NA|
| Transformers Prime                  | 2010–2013 |   7.9|   NA|   NA|
| Beast Machines: Transformers        | 1999–2001 |   6.9|   NA|   NA|

Let's get a brief overview of the current dataset we have for star trek

``` r
knitr::kable(movie_rating_startrek)
```

| movie\_title                        | Year      |  imdb|   RT|  Met|
|:------------------------------------|:----------|-----:|----:|----:|
| Star Trek                           | 2009      |   8.0|  9.4|  8.2|
| Star Trek: Into Darkness            | 2013      |   7.8|  8.6|  7.2|
| Star Trek: Beyond                   | 2016      |   7.1|  8.4|  6.8|
| Star Trek II: The Wrath of Khan     | 1982      |   7.7|  8.8|  7.1|
| Star Trek: The Next Generation      | 1987–1994 |   8.6|   NA|   NA|
| Star Trek: The Motion Picture       | 1979      |   6.4|  4.4|  4.8|
| Star Trek IV: The Voyage Home       | 1986      |   7.3|  8.5|  6.7|
| Star Trek: Generations              | 1994      |   6.6|  4.8|  5.5|
| Star Trek III: The Search for Spock | 1984      |   6.7|  7.9|  5.5|
| Star Trek: Nemesis                  | 2002      |   6.4|  3.8|  5.1|

Let's see top 5 for IMDB for transformers

``` r
movie_rating_transformers_temp <- movie_rating_transformers  %>% select(movie_title, imdb)%>% filter(imdb > 0) %>% arrange(desc(imdb))
movie_rating_transformers_temp <- movie_rating_transformers_temp[0:5,]
knitr::kable(movie_rating_transformers_temp)
```

| movie\_title                |  imdb|
|:----------------------------|-----:|
| Beast Wars: Transformers    |   8.2|
| The Transformers            |   8.0|
| Transformers Prime          |   7.9|
| The Transformers: The Movie |   7.3|
| Transformers                |   7.1|

Let's see top 5 for RT Score for transformers

``` r
movie_rating_transformers_temp_rt <- movie_rating_transformers  %>% select(movie_title, RT)%>% filter(RT > 0) %>% arrange(desc(RT))#Let's choose top 5 for RT for transformers
movie_rating_transformers_temp_rt <- movie_rating_transformers_temp_rt[0:5,]
knitr::kable(movie_rating_transformers_temp_rt)
```

| movie\_title                        |   RT|
|:------------------------------------|----:|
| Transformers                        |  5.7|
| The Transformers: The Movie         |  5.5|
| Transformers: Dark of the Moon      |  3.5|
| Transformers: Revenge of the Fallen |  1.9|
| Transformers: Age of Extinction     |  1.8|

Let's see top 5 for Met Score for transformers

``` r
movie_rating_transformers_temp_met <- movie_rating_transformers  %>% select(movie_title, Met)%>% filter(Met > 0) %>% arrange(desc(Met))#Let's choose top 5 for RT for transformers
movie_rating_transformers_temp_met <- movie_rating_transformers_temp_met[0:5,]
knitr::kable(movie_rating_transformers_temp_met)
```

| movie\_title                        |  Met|
|:------------------------------------|----:|
| Transformers                        |  6.1|
| Transformers: Dark of the Moon      |  4.2|
| Transformers: Revenge of the Fallen |  3.5|
| Transformers: Age of Extinction     |  3.2|
| Transformers: The Last Knight       |  2.8|

Let's see top 5 for IMDB Scorefor Star Trek

``` r
movie_rating_star_trek_temp <- movie_rating_startrek  %>% select(movie_title, imdb)%>% filter(imdb > 0) %>% arrange(desc(imdb))
#Let's choose top 5 for IMDB for Star Trek
movie_rating_star_trek_temp <- movie_rating_star_trek_temp[0:5,]
knitr::kable(movie_rating_star_trek_temp)
```

| movie\_title                    |  imdb|
|:--------------------------------|-----:|
| Star Trek: The Next Generation  |   8.6|
| Star Trek                       |   8.0|
| Star Trek: Into Darkness        |   7.8|
| Star Trek II: The Wrath of Khan |   7.7|
| Star Trek IV: The Voyage Home   |   7.3|

Let's see top 5 for RT Score for Star Trek

``` r
movie_rating_star_trek_temp_rt <- movie_rating_startrek  %>% select(movie_title, RT)%>% filter(RT > 0) %>% arrange(desc(RT))
movie_rating_star_trek_temp_rt <- movie_rating_star_trek_temp_rt[0:5,]
#Then let's have an overview
knitr::kable(movie_rating_star_trek_temp_rt)
```

| movie\_title                    |   RT|
|:--------------------------------|----:|
| Star Trek                       |  9.4|
| Star Trek II: The Wrath of Khan |  8.8|
| Star Trek: Into Darkness        |  8.6|
| Star Trek IV: The Voyage Home   |  8.5|
| Star Trek: Beyond               |  8.4|

Let's see top 5 for Met Score for Star Trek

``` r
movie_rating_star_trek_temp_met <- movie_rating_startrek  %>% select(movie_title, Met)%>% filter(Met > 0) %>% arrange(desc(Met))
#Let's choose top 5 for Met
movie_rating_star_trek_temp_met <- movie_rating_star_trek_temp_met[0:5,]
#Then let's have an overview
knitr::kable(movie_rating_star_trek_temp_met)
```

| movie\_title                    |  Met|
|:--------------------------------|----:|
| Star Trek                       |  8.2|
| Star Trek: Into Darkness        |  7.2|
| Star Trek II: The Wrath of Khan |  7.1|
| Star Trek: Beyond               |  6.8|
| Star Trek IV: The Voyage Home   |  6.7|

Let's draw the graph for all of them

-   Let's see top 5 for IMDB for transformers ![Picture](https://github.com/arthursunbao/STAT545-Homework/blob/master/hw10/OMDB/imdb_transformer.png)

-   Let's see top 5 for RT Score for transformers ![Picture](https://github.com/arthursunbao/STAT545-Homework/blob/master/hw10/OMDB/rt_transformer.png)

-   Let's see top 5 for Met Score for transformers ![Picture](https://github.com/arthursunbao/STAT545-Homework/blob/master/hw10/OMDB/met_transformer.png)

-   Let's see top 5 for IMDB Scorefor Star Trek ![Picture](https://github.com/arthursunbao/STAT545-Homework/blob/master/hw10/OMDB/imdb_star_trek.png)

-   Let's see top 5 for RT Score for Star Trek ![Picture](https://github.com/arthursunbao/STAT545-Homework/blob/master/hw10/OMDB/rt_star_trek.png)

-   Let's see top 5 for Met Score for Star Trek ![Picture](https://github.com/arthursunbao/STAT545-Homework/blob/master/hw10/OMDB/met_star_trek.png)
