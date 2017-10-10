A data manipulation sample
================
Jason Sun
2017-10-06

Intro
-----

This is the data manipulation sample of Gapminder. Check this out!~

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

Group

``` r
step1 <- gapminder %>% group_by(continent) %>% summarize(Nrows=n(), SumOfCol3=sum(year))
kable(step1)
```

| continent |  Nrows|  SumOfCol3|
|:----------|------:|----------:|
| Africa    |    624|    1235208|
| Americas  |    300|     593850|
| Asia      |    396|     783882|
| Europe    |    360|     712620|
| Oceania   |     24|      47508|

Split

``` r
step2 <- dcast(step1,continent~continent,value.var="Nrows")
kable(step2)
```

| continent |  Africa|  Americas|  Asia|  Europe|  Oceania|
|:----------|-------:|---------:|-----:|-------:|--------:|
| Africa    |     624|        NA|    NA|      NA|       NA|
| Americas  |      NA|       300|    NA|      NA|       NA|
| Asia      |      NA|        NA|   396|      NA|       NA|
| Europe    |      NA|        NA|    NA|     360|       NA|
| Oceania   |      NA|        NA|    NA|      NA|       24|

Stack

``` r
step3 <- melt(step2,id="continent") %>% arrange(continent)
kable(step3)
```

| continent | variable |  value|
|:----------|:---------|------:|
| Africa    | Africa   |    624|
| Africa    | Americas |     NA|
| Africa    | Asia     |     NA|
| Africa    | Europe   |     NA|
| Africa    | Oceania  |     NA|
| Americas  | Africa   |     NA|
| Americas  | Americas |    300|
| Americas  | Asia     |     NA|
| Americas  | Europe   |     NA|
| Americas  | Oceania  |     NA|
| Asia      | Africa   |     NA|
| Asia      | Americas |     NA|
| Asia      | Asia     |    396|
| Asia      | Europe   |     NA|
| Asia      | Oceania  |     NA|
| Europe    | Africa   |     NA|
| Europe    | Americas |     NA|
| Europe    | Asia     |     NA|
| Europe    | Europe   |    360|
| Europe    | Oceania  |     NA|
| Oceania   | Africa   |     NA|
| Oceania   | Americas |     NA|
| Oceania   | Asia     |     NA|
| Oceania   | Europe   |     NA|
| Oceania   | Oceania  |     24|

Join

``` r
step4 = left_join(step3, step3, c=("continent" = "variable"))
```

    ## Joining, by = c("continent", "variable", "value")

``` r
kable(step4)
```

| continent | variable |  value|
|:----------|:---------|------:|
| Africa    | Africa   |    624|
| Africa    | Americas |     NA|
| Africa    | Asia     |     NA|
| Africa    | Europe   |     NA|
| Africa    | Oceania  |     NA|
| Americas  | Africa   |     NA|
| Americas  | Americas |    300|
| Americas  | Asia     |     NA|
| Americas  | Europe   |     NA|
| Americas  | Oceania  |     NA|
| Asia      | Africa   |     NA|
| Asia      | Americas |     NA|
| Asia      | Asia     |    396|
| Asia      | Europe   |     NA|
| Asia      | Oceania  |     NA|
| Europe    | Africa   |     NA|
| Europe    | Americas |     NA|
| Europe    | Asia     |     NA|
| Europe    | Europe   |    360|
| Europe    | Oceania  |     NA|
| Oceania   | Africa   |     NA|
| Oceania   | Americas |     NA|
| Oceania   | Asia     |     NA|
| Oceania   | Europe   |     NA|
| Oceania   | Oceania  |     24|

Subset

``` r
step5 <- step4 %>% filter("continent" == "Africa")
kable(step5)
```

continent variable value ---------- --------- ------

Transpose

``` r
transpose <- data.frame(t(step4))
kable(transpose)
```

|           | X1     | X2       | X3     | X4     | X5      | X6       | X7       | X8       | X9       | X10      | X11    | X12      | X13  | X14    | X15     | X16    | X17      | X18    | X19    | X20     | X21     | X22      | X23     | X24     | X25     |
|-----------|:-------|:---------|:-------|:-------|:--------|:---------|:---------|:---------|:---------|:---------|:-------|:---------|:-----|:-------|:--------|:-------|:---------|:-------|:-------|:--------|:--------|:---------|:--------|:--------|:--------|
| continent | Africa | Africa   | Africa | Africa | Africa  | Americas | Americas | Americas | Americas | Americas | Asia   | Asia     | Asia | Asia   | Asia    | Europe | Europe   | Europe | Europe | Europe  | Oceania | Oceania  | Oceania | Oceania | Oceania |
| variable  | Africa | Americas | Asia   | Europe | Oceania | Africa   | Americas | Asia     | Europe   | Oceania  | Africa | Americas | Asia | Europe | Oceania | Africa | Americas | Asia   | Europe | Oceania | Africa  | Americas | Asia    | Europe  | Oceania |
| value     | 624    | NA       | NA     | NA     | NA      | NA       | 300      | NA       | NA       | NA       | NA     | NA       | 396  | NA     | NA      | NA     | NA       | NA     | 360    | NA      | NA      | NA       | NA      | NA      | 24      |
