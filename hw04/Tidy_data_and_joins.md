Tidy data and joins
================
Jason Sun
2017-10-08

Intro
-----

Today we will try to explore Tidy data and joins

This page will be divided into the following aspects: - Make you own cheatsheet similar to Tyler Rinker's minimal guide to tidyr

-   Make a tibble with one row per year and columns for life expectancy for two or more countries.

-   Compute some measure of life expectancy (mean? median? min? max?) for all possible combinations of continent and year. Reshape that to have one row per year and one variable for each continent. Or the other way around: one row per continent and one variable per year.

-   In Window functions, we formed a tibble with 24 rows: 2 per year, giving the country with both the lowest and highest life expectancy (in Asia). Take that table (or a similar one for all continents) and reshape it so you have one row per year or per year \* continent combination.

-   Previous TA Andrew MacDonald has a nice data manipulation sampler. Make up a similar set of exercises for yourself, in the abstract or (even better) using Gapminder or other data, and solve them.

-   Create a second data frame, complementary to Gapminder. Join this with (part of) Gapminder using a dplyr join function and make some observations about the process and result. Explore the different types of joins.

-   Create your own cheatsheet patterned after mine but focused on something you care about more than comics!

-   Explore the base function merge(), which also does joins. Compare and contrast with dplyr joins.

-   Explore the base function match(), which is related to joins and merges, but is really more of a table lookup. Compare and contrast with a true join/merge.

Initial Setup
-------------

We need to load the Gapminder first

``` r
suppressPackageStartupMessages(library(gapminder))
suppressPackageStartupMessages(library(tidyverse))
```

    ## Warning: package 'dplyr' was built under R version 3.4.2

``` r
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(reshape))
suppressPackageStartupMessages(library(tidyr))
library(gapminder)
library(tidyverse)
library(ggplot2)
library(knitr)
library(ggthemes)
library(reshape)
library(tidyr)
library(geonames)
```

    ## No geonamesUsername set. See http://geonames.wordpress.com/2010/03/16/ddos-part-ii/ and set one with options(geonamesUsername="foo") for some services to work

``` r
knitr::opts_chunk$set(fig.width=8, fig.height=5)
```

Let's do some work buddy!
-------------------------

### Question 1: Make you own cheatsheet similar to Tyler Rinker???s minimal guide to tidyr

OK. I have created another page for this task.

![Check it out:](https://github.com/arthursunbao/STAT545-hw01--Bao-Sun/blob/master/Exploration_gapminder.md)

### Question 2: Make a tibble with one row per year and columns for life expectancy for two or more countries

Tibbles are a modern take on data frames. They keep the features that have stood the test of time, and drop the features that used to be convenient but are now frustrating (i.e. converting character vectors to factors)

So basically we fill first create a number sequence starting from 1900 to 2010 named year. Then we need to filter out the lifeExp of China and Japan and then do the full\_join one by one on the first number sequence. Then we filter out those without life expectency. Then done!

``` r
total<-tibble(year=1900:2010)
china <- gapminder%>%filter(country=="China")%>%select(year, lifeExp)
japan <- gapminder%>%filter(country=="Japan")%>%select(year, lifeExp)
left_china <- full_join(total, china)
```

    ## Joining, by = "year"

``` r
left_japan <- full_join(left_china, japan, by="year")
result <- left_japan %>% filter(lifeExp.x != "NA")
kable(result)
```

|  year|  lifeExp.x|  lifeExp.y|
|-----:|----------:|----------:|
|  1952|   44.00000|     63.030|
|  1957|   50.54896|     65.500|
|  1962|   44.50136|     68.730|
|  1967|   58.38112|     71.430|
|  1972|   63.11888|     73.420|
|  1977|   63.96736|     75.380|
|  1982|   65.52500|     77.110|
|  1987|   67.27400|     78.670|
|  1992|   68.69000|     79.360|
|  1997|   70.42600|     80.690|
|  2002|   72.02800|     82.000|
|  2007|   72.96100|     82.603|

### Question 3: Make a tibble with one row per year and columns for life expectancy for two or more countries

Let's first distract the mean lifeExp for each continents and then do full\_join() and then filter(), just like Question2

``` r
Asia<-gapminder%>%filter(continent=="Asia")%>%arrange(year)%>%select(year,lifeExp)%>%group_by(year)%>%summarize(avg_life=mean(lifeExp))

Europe<-gapminder%>%filter(continent=="Europe")%>%arrange(year)%>%select(year,lifeExp)%>%group_by(year)%>%summarize(avg_life=mean(lifeExp))

Africa<-gapminder%>%filter(continent=="Africa")%>%arrange(year)%>%select(year,lifeExp)%>%group_by(year)%>%summarize(avg_life=mean(lifeExp))

Americas<-gapminder%>%filter(continent=="Americas")%>%arrange(year)%>%select(year,lifeExp)%>%group_by(year)%>%summarize(avg_life=mean(lifeExp))

Oceania<-gapminder%>%filter(continent=="Oceania")%>%arrange(year)%>%select(year,lifeExp)%>%group_by(year)%>%summarize(avg_life=mean(lifeExp))

total<-tibble(year=1900:2010)

left_asia <- full_join(total, Asia)
```

    ## Joining, by = "year"

``` r
left_europe <- full_join(left_asia, Europe, by="year")

left_africa <- full_join(left_europe, Africa, by="year")

left_america <- full_join(left_africa, Americas, by="year")

left_all <- full_join(left_america, Oceania, by="year")

result <- left_all %>% filter(avg_life.x != "NA")

kable(result)
```

|  year|  avg\_life.x|  avg\_life.y|  avg\_life.x.x|  avg\_life.y.y|  avg\_life|
|-----:|------------:|------------:|--------------:|--------------:|----------:|
|  1952|     46.31439|     64.40850|       39.13550|       53.27984|    69.2550|
|  1957|     49.31854|     66.70307|       41.26635|       55.96028|    70.2950|
|  1962|     51.56322|     68.53923|       43.31944|       58.39876|    71.0850|
|  1967|     54.66364|     69.73760|       45.33454|       60.41092|    71.3100|
|  1972|     57.31927|     70.77503|       47.45094|       62.39492|    71.9100|
|  1977|     59.61056|     71.93777|       49.58042|       64.39156|    72.8550|
|  1982|     62.61794|     72.80640|       51.59287|       66.22884|    74.2900|
|  1987|     64.85118|     73.64217|       53.34479|       68.09072|    75.3200|
|  1992|     66.53721|     74.44010|       53.62958|       69.56836|    76.9450|
|  1997|     68.02052|     75.50517|       53.59827|       71.15048|    78.1900|
|  2002|     69.23388|     76.70060|       53.32523|       72.42204|    79.7400|
|  2007|     70.72848|     77.64860|       54.80604|       73.60812|    80.7195|

### Question 4: Make a tibble with one row per year and columns for life expectancy for two or more countries

In Window functions, we formed a tibble with 24 rows: 2 per year, giving the country with both the lowest and highest life expectancy (in Asia). Take that table (or a similar one for all continents) and reshape it so you have one row per year or per year \* continent combination

We first the the table from the window function stored as temp and then we do the transformation. The transformation is basically take the odd line and join the previous upper line, which is quite easy.

``` r
temp <- gapminder %>% filter(continent == "Asia") %>% select(year, country, lifeExp) %>% group_by(year) %>% filter(min_rank(desc(lifeExp)) < 2 | min_rank(lifeExp) < 2) %>% arrange(year) %>% print(n = Inf)
```

    ## # A tibble: 24 x 3
    ## # Groups:   year [12]
    ##     year     country lifeExp
    ##    <int>      <fctr>   <dbl>
    ##  1  1952 Afghanistan  28.801
    ##  2  1952      Israel  65.390
    ##  3  1957 Afghanistan  30.332
    ##  4  1957      Israel  67.840
    ##  5  1962 Afghanistan  31.997
    ##  6  1962      Israel  69.390
    ##  7  1967 Afghanistan  34.020
    ##  8  1967       Japan  71.430
    ##  9  1972 Afghanistan  36.088
    ## 10  1972       Japan  73.420
    ## 11  1977    Cambodia  31.220
    ## 12  1977       Japan  75.380
    ## 13  1982 Afghanistan  39.854
    ## 14  1982       Japan  77.110
    ## 15  1987 Afghanistan  40.822
    ## 16  1987       Japan  78.670
    ## 17  1992 Afghanistan  41.674
    ## 18  1992       Japan  79.360
    ## 19  1997 Afghanistan  41.763
    ## 20  1997       Japan  80.690
    ## 21  2002 Afghanistan  42.129
    ## 22  2002       Japan  82.000
    ## 23  2007 Afghanistan  43.828
    ## 24  2007       Japan  82.603

``` r
even_sequence=seq(2,24,2)

temp_even <- data.frame(x=temp[even_sequence, ])

result <- full_join(temp, temp_even, c("year" ="x.year"))

kable(result)
```

|  year| country     |  lifeExp| x.country |  x.lifeExp|
|-----:|:------------|--------:|:----------|----------:|
|  1952| Afghanistan |   28.801| Israel    |     65.390|
|  1952| Israel      |   65.390| Israel    |     65.390|
|  1957| Afghanistan |   30.332| Israel    |     67.840|
|  1957| Israel      |   67.840| Israel    |     67.840|
|  1962| Afghanistan |   31.997| Israel    |     69.390|
|  1962| Israel      |   69.390| Israel    |     69.390|
|  1967| Afghanistan |   34.020| Japan     |     71.430|
|  1967| Japan       |   71.430| Japan     |     71.430|
|  1972| Afghanistan |   36.088| Japan     |     73.420|
|  1972| Japan       |   73.420| Japan     |     73.420|
|  1977| Cambodia    |   31.220| Japan     |     75.380|
|  1977| Japan       |   75.380| Japan     |     75.380|
|  1982| Afghanistan |   39.854| Japan     |     77.110|
|  1982| Japan       |   77.110| Japan     |     77.110|
|  1987| Afghanistan |   40.822| Japan     |     78.670|
|  1987| Japan       |   78.670| Japan     |     78.670|
|  1992| Afghanistan |   41.674| Japan     |     79.360|
|  1992| Japan       |   79.360| Japan     |     79.360|
|  1997| Afghanistan |   41.763| Japan     |     80.690|
|  1997| Japan       |   80.690| Japan     |     80.690|
|  2002| Afghanistan |   42.129| Japan     |     82.000|
|  2002| Japan       |   82.000| Japan     |     82.000|
|  2007| Afghanistan |   43.828| Japan     |     82.603|
|  2007| Japan       |   82.603| Japan     |     82.603|

### Question 5: Create a second data frame, complementary to Gapminder. Join this with (part of) Gapminder using a dplyr join function and make some observations about the process and result. Explore the different types of joins

OK. We will then use the following join methods:

-   inner\_join(dataset1, dataset2)

-   semi\_join(dataset1, dataset2)

-   left\_join(dataset1, dataset2)

-   anti\_join(dataset1, dataset2)

-   inner\_join(dataset2, dataset1)

-   semi\_join(dataset2, dataset1)

-   left\_join(dataset2, dataset1)

-   anti\_join(dataset2, dataset1)

-   full\_join(dataset1, dataset2)

Well, the first dataset will be gapminder and the second dataset will be a manually created dataset with first column as country and second column as capital city.

``` r
options(geonamesUsername="jasonsunbao")
countryInfo <- GNcountryInfo()
dataset2 <- countryInfo%>%select(countryName, countryCode)
dataset1 <- gapminder
```

Let's try inner\_join(), it will get the intersection of the two datasets

``` r
inner_join(dataset1, dataset2, c("country" = "countryName")) %>% filter(year=="1952")
```

    ## Warning: Column `country`/`countryName` joining factor and character
    ## vector, coercing into character vector

    ## # A tibble: 29 x 7
    ##                     country continent  year lifeExp      pop  gdpPercap
    ##                       <chr>    <fctr> <int>   <dbl>    <int>      <dbl>
    ##  1               Bangladesh      Asia  1952  37.484 46886859   684.2442
    ##  2   Bosnia and Herzegovina    Europe  1952  53.820  2791000   973.5332
    ##  3             Burkina Faso    Africa  1952  31.975  4469979   543.2552
    ##  4                   Canada  Americas  1952  68.750 14785584 11367.1611
    ##  5 Central African Republic    Africa  1952  35.463  1291695  1071.3107
    ##  6           Czech Republic    Europe  1952  66.870  9125183  6876.1403
    ##  7       Dominican Republic  Americas  1952  45.928  2491346  1397.7171
    ##  8                   France    Europe  1952  67.410 42459667  7029.8093
    ##  9                   Gambia    Africa  1952  30.000   284320   485.2307
    ## 10                  Hungary    Europe  1952  64.030  9504000  5263.6738
    ## # ... with 19 more rows, and 1 more variables: countryCode <chr>

Then Semi\_join() will return all rows from x where there are matching values in y, keeping just columns from x

``` r
semi_join(dataset1, dataset2, c("country" = "countryName")) %>% filter(year=="1952")
```

    ## Warning: Column `country`/`countryName` joining factor and character
    ## vector, coercing into character vector

    ## # A tibble: 29 x 6
    ##                     country continent  year lifeExp      pop  gdpPercap
    ##                      <fctr>    <fctr> <int>   <dbl>    <int>      <dbl>
    ##  1               Bangladesh      Asia  1952  37.484 46886859   684.2442
    ##  2   Bosnia and Herzegovina    Europe  1952  53.820  2791000   973.5332
    ##  3             Burkina Faso    Africa  1952  31.975  4469979   543.2552
    ##  4                   Canada  Americas  1952  68.750 14785584 11367.1611
    ##  5 Central African Republic    Africa  1952  35.463  1291695  1071.3107
    ##  6           Czech Republic    Europe  1952  66.870  9125183  6876.1403
    ##  7       Dominican Republic  Americas  1952  45.928  2491346  1397.7171
    ##  8                   France    Europe  1952  67.410 42459667  7029.8093
    ##  9                   Gambia    Africa  1952  30.000   284320   485.2307
    ## 10                  Hungary    Europe  1952  64.030  9504000  5263.6738
    ## # ... with 19 more rows

Then left\_join(x, y) will return all rows from x, and all columns from x and y. If there are multiple matches between x and y, all combination of the matches are returned

``` r
left_join(dataset1, dataset2, c("country" = "countryName")) %>% filter(year=="1952")
```

    ## Warning: Column `country`/`countryName` joining factor and character
    ## vector, coercing into character vector

    ## # A tibble: 142 x 7
    ##        country continent  year lifeExp      pop  gdpPercap countryCode
    ##          <chr>    <fctr> <int>   <dbl>    <int>      <dbl>       <chr>
    ##  1 Afghanistan      Asia  1952  28.801  8425333   779.4453        <NA>
    ##  2     Albania    Europe  1952  55.230  1282697  1601.0561        <NA>
    ##  3     Algeria    Africa  1952  43.077  9279525  2449.0082        <NA>
    ##  4      Angola    Africa  1952  30.015  4232095  3520.6103        <NA>
    ##  5   Argentina  Americas  1952  62.485 17876956  5911.3151        <NA>
    ##  6   Australia   Oceania  1952  69.120  8691212 10039.5956        <NA>
    ##  7     Austria    Europe  1952  66.800  6927772  6137.0765        <NA>
    ##  8     Bahrain      Asia  1952  50.939   120447  9867.0848        <NA>
    ##  9  Bangladesh      Asia  1952  37.484 46886859   684.2442          BD
    ## 10     Belgium    Europe  1952  68.000  8730405  8343.1051        <NA>
    ## # ... with 132 more rows

After that is anti\_join(x, y) will eturn all rows from x where there are not matching values in y, keeping just columns from x, which is a filtering join

``` r
anti_join(dataset1, dataset2, c("country" = "countryName")) %>% filter(year=="1952")
```

    ## Warning: Column `country`/`countryName` joining factor and character
    ## vector, coercing into character vector

    ## # A tibble: 113 x 6
    ##        country continent  year lifeExp      pop  gdpPercap
    ##         <fctr>    <fctr> <int>   <dbl>    <int>      <dbl>
    ##  1 Afghanistan      Asia  1952  28.801  8425333   779.4453
    ##  2     Albania    Europe  1952  55.230  1282697  1601.0561
    ##  3     Algeria    Africa  1952  43.077  9279525  2449.0082
    ##  4      Angola    Africa  1952  30.015  4232095  3520.6103
    ##  5   Argentina  Americas  1952  62.485 17876956  5911.3151
    ##  6   Australia   Oceania  1952  69.120  8691212 10039.5956
    ##  7     Austria    Europe  1952  66.800  6927772  6137.0765
    ##  8     Bahrain      Asia  1952  50.939   120447  9867.0848
    ##  9     Belgium    Europe  1952  68.000  8730405  8343.1051
    ## 10       Benin    Africa  1952  38.223  1738315  1062.7522
    ## # ... with 103 more rows

Finally is full\_join(x, y) will return all rows and all columns from both x and y. Where there are not matching values, returns NA for the one missing, which is a mutating join

``` r
full_join(dataset1, dataset2, c("country" = "countryName")) %>% filter(year=="1952")
```

    ## Warning: Column `country`/`countryName` joining factor and character
    ## vector, coercing into character vector

    ## # A tibble: 142 x 7
    ##        country continent  year lifeExp      pop  gdpPercap countryCode
    ##          <chr>    <fctr> <int>   <dbl>    <int>      <dbl>       <chr>
    ##  1 Afghanistan      Asia  1952  28.801  8425333   779.4453        <NA>
    ##  2     Albania    Europe  1952  55.230  1282697  1601.0561        <NA>
    ##  3     Algeria    Africa  1952  43.077  9279525  2449.0082        <NA>
    ##  4      Angola    Africa  1952  30.015  4232095  3520.6103        <NA>
    ##  5   Argentina  Americas  1952  62.485 17876956  5911.3151        <NA>
    ##  6   Australia   Oceania  1952  69.120  8691212 10039.5956        <NA>
    ##  7     Austria    Europe  1952  66.800  6927772  6137.0765        <NA>
    ##  8     Bahrain      Asia  1952  50.939   120447  9867.0848        <NA>
    ##  9  Bangladesh      Asia  1952  37.484 46886859   684.2442          BD
    ## 10     Belgium    Europe  1952  68.000  8730405  8343.1051        <NA>
    ## # ... with 132 more rows

### Question 6: Create your own cheatsheet patterned after mine but focused on something you care about more than comics! Inspirational examples

![The cheetsheet is at here:](https://github.com/arthursunbao/STAT545-Homework/blob/master/hw04/cheetsheet_join.md)

Personal Thought
----------------

It is not so much harder than hw03 as there is not so many plotting in this homework. Basically is it all about all kinds of joining method and respecitve application, which is easy to understand but a little bit tricky to work in real world. Afterall it is a nice trial and learning for R in its in-depth application.
