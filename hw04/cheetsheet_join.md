A cheetsheet for joining method
================
Jason Sun
2017-10-06

Intro
-----

This is the cheetsheet for joing method Check this out!~

Initial Setup
-------------

We need to load the library first

``` r
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(dplyr))
```

    ## Warning: package 'dplyr' was built under R version 3.4.2

``` r
suppressPackageStartupMessages(library(gapminder))
options(geonamesUsername="jasonsunbao")
library(geonames)
library(tidyr)
library(knitr)
library(dplyr)
library(gapminder)
library(reshape2)
```

    ## 
    ## Attaching package: 'reshape2'

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     smiths

Do some work
------------

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
