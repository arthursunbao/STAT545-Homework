scrape\_download\_show
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

``` r
library(rvest)
```

    ## Loading required package: xml2

    ## 
    ## Attaching package: 'rvest'

    ## The following object is masked from 'package:readr':
    ## 
    ##     guess_encoding

    ## The following object is masked from 'package:purrr':
    ## 
    ##     pluck

Work That I have Done
---------------------

I have continued with the slide's requirement in bestplace.com to dig information with rvest and I

choose to find some crime information in Missouri and its counties. I firstly find out all the counties in Missouri and its respecitve crime link in the website and then saved as a dataframe for the next step's exploration. Then I choose a random county to download the detailed crime information of the county and showed as text.

The whole process is like this: scrape\_data ----&gt; scrape\_download\_show

You can use Makefile to automate the whole process.

Let's do some work
------------------

First of all, let's know how many counties are there in Missouri?

``` r
county_crime_link <- read_csv("./mo_dataframe.csv")
nrow(county_crime_link)
```

    ## [1] 115

Since I have already got the county name and its crime rate link, then I will show the table of the information.

``` r
knitr::kable(county_crime_link)
```

| counties       | crime\_link                                                       |
|:---------------|:------------------------------------------------------------------|
| Adair          | <https://www.bestplaces.net/crime/county/missouri/adair>          |
| Andrew         | <https://www.bestplaces.net/crime/county/missouri/andrew>         |
| Atchison       | <https://www.bestplaces.net/crime/county/missouri/atchison>       |
| Audrain        | <https://www.bestplaces.net/crime/county/missouri/audrain>        |
| Barry          | <https://www.bestplaces.net/crime/county/missouri/barry>          |
| Barton         | <https://www.bestplaces.net/crime/county/missouri/barton>         |
| Bates          | <https://www.bestplaces.net/crime/county/missouri/bates>          |
| Benton         | <https://www.bestplaces.net/crime/county/missouri/benton>         |
| Bollinger      | <https://www.bestplaces.net/crime/county/missouri/bollinger>      |
| Boone          | <https://www.bestplaces.net/crime/county/missouri/boone>          |
| Buchanan       | <https://www.bestplaces.net/crime/county/missouri/buchanan>       |
| Butler         | <https://www.bestplaces.net/crime/county/missouri/butler>         |
| Caldwell       | <https://www.bestplaces.net/crime/county/missouri/caldwell>       |
| Callaway       | <https://www.bestplaces.net/crime/county/missouri/callaway>       |
| Camden         | <https://www.bestplaces.net/crime/county/missouri/camden>         |
| Cape Girardeau | <https://www.bestplaces.net/crime/county/missouri/cape_girardeau> |
| Carroll        | <https://www.bestplaces.net/crime/county/missouri/carroll>        |
| Carter         | <https://www.bestplaces.net/crime/county/missouri/carter>         |
| Cass           | <https://www.bestplaces.net/crime/county/missouri/cass>           |
| Cedar          | <https://www.bestplaces.net/crime/county/missouri/cedar>          |
| Chariton       | <https://www.bestplaces.net/crime/county/missouri/chariton>       |
| Christian      | <https://www.bestplaces.net/crime/county/missouri/christian>      |
| Clark          | <https://www.bestplaces.net/crime/county/missouri/clark>          |
| Clay           | <https://www.bestplaces.net/crime/county/missouri/clay>           |
| Clinton        | <https://www.bestplaces.net/crime/county/missouri/clinton>        |
| Cole           | <https://www.bestplaces.net/crime/county/missouri/cole>           |
| Cooper         | <https://www.bestplaces.net/crime/county/missouri/cooper>         |
| Crawford       | <https://www.bestplaces.net/crime/county/missouri/crawford>       |
| Dade           | <https://www.bestplaces.net/crime/county/missouri/dade>           |
| Dallas         | <https://www.bestplaces.net/crime/county/missouri/dallas>         |
| Daviess        | <https://www.bestplaces.net/crime/county/missouri/daviess>        |
| DeKalb         | <https://www.bestplaces.net/crime/county/missouri/dekalb>         |
| Dent           | <https://www.bestplaces.net/crime/county/missouri/dent>           |
| Douglas        | <https://www.bestplaces.net/crime/county/missouri/douglas>        |
| Dunklin        | <https://www.bestplaces.net/crime/county/missouri/dunklin>        |
| Franklin       | <https://www.bestplaces.net/crime/county/missouri/franklin>       |
| Gasconade      | <https://www.bestplaces.net/crime/county/missouri/gasconade>      |
| Gentry         | <https://www.bestplaces.net/crime/county/missouri/gentry>         |
| Greene         | <https://www.bestplaces.net/crime/county/missouri/greene>         |
| Grundy         | <https://www.bestplaces.net/crime/county/missouri/grundy>         |
| Harrison       | <https://www.bestplaces.net/crime/county/missouri/harrison>       |
| Henry          | <https://www.bestplaces.net/crime/county/missouri/henry>          |
| Hickory        | <https://www.bestplaces.net/crime/county/missouri/hickory>        |
| Holt           | <https://www.bestplaces.net/crime/county/missouri/holt>           |
| Howard         | <https://www.bestplaces.net/crime/county/missouri/howard>         |
| Howell         | <https://www.bestplaces.net/crime/county/missouri/howell>         |
| Iron           | <https://www.bestplaces.net/crime/county/missouri/iron>           |
| Jackson        | <https://www.bestplaces.net/crime/county/missouri/jackson>        |
| Jasper         | <https://www.bestplaces.net/crime/county/missouri/jasper>         |
| Jefferson      | <https://www.bestplaces.net/crime/county/missouri/jefferson>      |
| Johnson        | <https://www.bestplaces.net/crime/county/missouri/johnson>        |
| Knox           | <https://www.bestplaces.net/crime/county/missouri/knox>           |
| Laclede        | <https://www.bestplaces.net/crime/county/missouri/laclede>        |
| Lafayette      | <https://www.bestplaces.net/crime/county/missouri/lafayette>      |
| Lawrence       | <https://www.bestplaces.net/crime/county/missouri/lawrence>       |
| Lewis          | <https://www.bestplaces.net/crime/county/missouri/lewis>          |
| Lincoln        | <https://www.bestplaces.net/crime/county/missouri/lincoln>        |
| Linn           | <https://www.bestplaces.net/crime/county/missouri/linn>           |
| Livingston     | <https://www.bestplaces.net/crime/county/missouri/livingston>     |
| Macon          | <https://www.bestplaces.net/crime/county/missouri/macon>          |
| Madison        | <https://www.bestplaces.net/crime/county/missouri/madison>        |
| Maries         | <https://www.bestplaces.net/crime/county/missouri/maries>         |
| Marion         | <https://www.bestplaces.net/crime/county/missouri/marion>         |
| McDonald       | <https://www.bestplaces.net/crime/county/missouri/mcdonald>       |
| Mercer         | <https://www.bestplaces.net/crime/county/missouri/mercer>         |
| Miller         | <https://www.bestplaces.net/crime/county/missouri/miller>         |
| Mississippi    | <https://www.bestplaces.net/crime/county/missouri/mississippi>    |
| Moniteau       | <https://www.bestplaces.net/crime/county/missouri/moniteau>       |
| Monroe         | <https://www.bestplaces.net/crime/county/missouri/monroe>         |
| Montgomery     | <https://www.bestplaces.net/crime/county/missouri/montgomery>     |
| Morgan         | <https://www.bestplaces.net/crime/county/missouri/morgan>         |
| New Madrid     | <https://www.bestplaces.net/crime/county/missouri/new_madrid>     |
| Newton         | <https://www.bestplaces.net/crime/county/missouri/newton>         |
| Nodaway        | <https://www.bestplaces.net/crime/county/missouri/nodaway>        |
| Oregon         | <https://www.bestplaces.net/crime/county/missouri/oregon>         |
| Osage          | <https://www.bestplaces.net/crime/county/missouri/osage>          |
| Ozark          | <https://www.bestplaces.net/crime/county/missouri/ozark>          |
| Pemiscot       | <https://www.bestplaces.net/crime/county/missouri/pemiscot>       |
| Perry          | <https://www.bestplaces.net/crime/county/missouri/perry>          |
| Pettis         | <https://www.bestplaces.net/crime/county/missouri/pettis>         |
| Phelps         | <https://www.bestplaces.net/crime/county/missouri/phelps>         |
| Pike           | <https://www.bestplaces.net/crime/county/missouri/pike>           |
| Platte         | <https://www.bestplaces.net/crime/county/missouri/platte>         |
| Polk           | <https://www.bestplaces.net/crime/county/missouri/polk>           |
| Pulaski        | <https://www.bestplaces.net/crime/county/missouri/pulaski>        |
| Putnam         | <https://www.bestplaces.net/crime/county/missouri/putnam>         |
| Ralls          | <https://www.bestplaces.net/crime/county/missouri/ralls>          |
| Randolph       | <https://www.bestplaces.net/crime/county/missouri/randolph>       |
| Ray            | <https://www.bestplaces.net/crime/county/missouri/ray>            |
| Reynolds       | <https://www.bestplaces.net/crime/county/missouri/reynolds>       |
| Ripley         | <https://www.bestplaces.net/crime/county/missouri/ripley>         |
| Saline         | <https://www.bestplaces.net/crime/county/missouri/saline>         |
| Schuyler       | <https://www.bestplaces.net/crime/county/missouri/schuyler>       |
| Scotland       | <https://www.bestplaces.net/crime/county/missouri/scotland>       |
| Scott          | <https://www.bestplaces.net/crime/county/missouri/scott>          |
| Shannon        | <https://www.bestplaces.net/crime/county/missouri/shannon>        |
| Shelby         | <https://www.bestplaces.net/crime/county/missouri/shelby>         |
| St. Charles    | <https://www.bestplaces.net/crime/county/missouri/st._charles>    |
| St. Clair      | <https://www.bestplaces.net/crime/county/missouri/st._clair>      |
| St. Francois   | <https://www.bestplaces.net/crime/county/missouri/st._francois>   |
| St. Louis      | <https://www.bestplaces.net/crime/county/missouri/st._louis>      |
| St. Louis city | <https://www.bestplaces.net/crime/county/missouri/st._louis_city> |
| Ste. Genevieve | <https://www.bestplaces.net/crime/county/missouri/ste._genevieve> |
| Stoddard       | <https://www.bestplaces.net/crime/county/missouri/stoddard>       |
| Stone          | <https://www.bestplaces.net/crime/county/missouri/stone>          |
| Sullivan       | <https://www.bestplaces.net/crime/county/missouri/sullivan>       |
| Taney          | <https://www.bestplaces.net/crime/county/missouri/taney>          |
| Texas          | <https://www.bestplaces.net/crime/county/missouri/texas>          |
| Vernon         | <https://www.bestplaces.net/crime/county/missouri/vernon>         |
| Warren         | <https://www.bestplaces.net/crime/county/missouri/warren>         |
| Washington     | <https://www.bestplaces.net/crime/county/missouri/washington>     |
| Wayne          | <https://www.bestplaces.net/crime/county/missouri/wayne>          |
| Webster        | <https://www.bestplaces.net/crime/county/missouri/webster>        |
| Worth          | <https://www.bestplaces.net/crime/county/missouri/worth>          |
| Wright         | <https://www.bestplaces.net/crime/county/missouri/wright>         |

What if we want to see some detailed information regarding Wright?

We can use read\_html(), html\_nodes() and html\_table() to help dig a little deeper and extract certain text information from it.

``` r
current_url <- "https://www.bestplaces.net/crime/county/missouri/wright"
temp_text <- read_html(current_url)
node <- html_nodes(temp_text, css = "table")
text <- html_table(node, head = TRUE,fill = TRUE)[[1]]
text
```

    ##     
    ## 1 NA
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        CRIME OVERVIEW
    ## 1 Wright County, Missouri, violent crime, on a scale from 1 (low crime) to 100, is 45. Violent crime is composed of four offenses: murder and nonnegligent manslaughter, forcible rape, robbery, and aggravated assault. The US average is 31.1.Wright County, Missouri, property crime, on a scale from 1 (low) to 100, is 46. Property crime includes the offenses of burglary, larceny-theft, motor vehicle theft, and arson. The object of the theft-type offenses is the taking of money or property, but there is no force or threat of force against the victims. The US average is 38.1.

Hmm, Nice. We got the Crime Overview of the Wright County, Missouri as well as its respective composed of four offenses.
