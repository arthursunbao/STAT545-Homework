Tidyr\_Cheetsheet
================
Jason Sun
2017-10-06

Intro
-----

This is the cheat sheet for Tidyr. Check this out!~

Initial Setup
-------------

We need to load the library first

``` r
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(dplyr))
```

    ## Warning: package 'dplyr' was built under R version 3.4.2

``` r
library(tidyr)
library(dplyr)
```

Do some work
------------

Tidyr is new package that makes it make dataset clean and used to munge with dplyr, ggplot2 and further packages and it has two important properties:

Each column is a variable.

Each row is an observation.

And it has certain functions for usage:

-   gather(): gather() takes multiple columns, and gathers them into key-value pairs: it makes ???wide??? data longer, it has melt(), pivot() and fold()

-   spread(): spread() takes two columns (a key-value pair) and spreads them in to multiple columns, making ???long??? data wider.

``` r
input <- data.frame(
  name = c("Jason", "William", "Tom"),
  a = c(67, 80, 64),
  b = c(56, 90, 50)
)
input
```

    ##      name  a  b
    ## 1   Jason 67 56
    ## 2 William 80 90
    ## 3     Tom 64 50

Now we want to extend it into a key-value pair. we use gather()

``` r
input %>% gather(nationality, birthplace, a:b)
```

    ##      name nationality birthplace
    ## 1   Jason           a         67
    ## 2 William           a         80
    ## 3     Tom           a         64
    ## 4   Jason           b         56
    ## 5 William           b         90
    ## 6     Tom           b         50

Hmm. Quite interesting

Let's see how to do that for spread()

``` r
input %>% gather(nationality, birthplace, a:b) %>% spread(nationality, birthplace)
```

    ##      name  a  b
    ## 1   Jason 67 56
    ## 2     Tom 64 50
    ## 3 William 80 90

Oh Yeah! It is now returned back to where it looks like for the first place.
