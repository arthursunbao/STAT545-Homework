Use dplyr and ggplot2 to manipulate and explore gapminder dataset
================
Jason Sun
2017-10-03

Intro
-----

Today we will use some common functions in ggplot2 and dplyr to dive deeper into the gapminder dataset

This page will be divided into the following aspects: - Get the maximum and minimum of GDP per capita for all continents.

-   Look at the spread of GDP per capita within the continents

-   Compute a trimmed mean of life expectancy for different years. Or a weighted mean, weighting by population. Just try something other than the plain vanilla mean

-   Find out the life expectancy changing over time on different continents

-   Report the absolute and/or relative abundance of countries with low life expectancy over time by continent: Compute some measure of worldwide life expectancy by mean or median or some other quantile or perhaps your current age. Then determine how many countries on each continent have a life expectancy less than this benchmark, for each year

-   Find countries with interesting stories. Open-ended and, therefore, hard. Promising but unsuccessful attempts are encouraged. This will generate interesting questions to follow up on in class

Initial Setup
-------------

We need to load the Gapminder first

``` r
library(gapminder)
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(ggplot2)
library(knitr)
library(ggthemes)
library(reshape)
```

    ## 
    ## Attaching package: 'reshape'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     rename

    ## The following objects are masked from 'package:tidyr':
    ## 
    ##     expand, smiths

``` r
knitr::opts_chunk$set(fig.width=8, fig.height=5)
```

Do some work
------------

### Question1: Get the maximum and minimum of GDP per capita for all continents

Wow, I got to say the first question is a little bit tricky :( and let 's figure it out step by step.

So we first groupby gapminder by continents

Then we extract the max and min from column gdpPercap. Done

``` r
gdpper <- gapminder %>% group_by(continent) %>% summarize(maximum_gdpPercap=max(gdpPercap), minimum_gdpPercap=min(gdpPercap))
kable(gdpper)
```

| continent    |   maximum\_gdpPercap|                            minimum\_gdpPercap|
|:-------------|--------------------:|---------------------------------------------:|
| Africa       |             21951.21|                                      241.1659|
| Americas     |             42951.65|                                     1201.6372|
| Asia         |            113523.13|                                      331.0000|
| Europe       |             49357.19|                                      973.5332|
| Oceania      |             34435.37|                                    10039.5956|
| We can use a |  histogram to draw t|  he table to show the results of maximum GDP.|

``` r
ggplot(gdpper, aes(gdpper$continent, gdpper$maximum_gdpPercap, fill=gdpper$continent)) + geom_bar(stat="identity",position="dodge")+geom_text(aes(label=gdpper$maximum_gdpPercap),position=position_dodge(width=0.9), vjust=-0.25)
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

Quite astonishing right? It is an Asia country who has the most GDP per capita, which is Qatar.

We can use a histogram to draw the table to show the results of minimum GDP.

``` r
ggplot(gdpper, aes(gdpper$continent, gdpper$minimum_gdpPercap, fill=gdpper$continent)) + geom_bar(stat="identity",position="dodge")+geom_text(aes(label=gdpper$minimum_gdpPercap),position=position_dodge(width=0.9), vjust=-0.25)
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

Hmm, It is quite clear that Africa indeed has the lowest GDP.

### Question2: Look at the spread of GDP per capita within the continents

We also need to groupby the gapminder by continents and then create subview in (continent, gdpPercap), then filter by continents and then do respective summary()

The spread of gdpPercap by for all country starting from the smallest gdpPercap to the largest. Because the country name is hard to display on the x-axis, then we will use index instead. It is quite clear for the trend.

For Asia

``` r
summary(asia<-gapminder %>% group_by(continent) %>% select(continent, gdpPercap) %>% filter(continent=="Asia")%>%arrange(gdpPercap))
```

    ##     continent     gdpPercap     
    ##  Africa  :  0   Min.   :   331  
    ##  Americas:  0   1st Qu.:  1057  
    ##  Asia    :396   Median :  2647  
    ##  Europe  :  0   Mean   :  7902  
    ##  Oceania :  0   3rd Qu.:  8549  
    ##                 Max.   :113523

``` r
ggplot(asia, aes(x=row.names(asia), y = asia$gdpPercap, group=1)) + geom_bar(stat="identity",position="dodge", fill = "dark blue")+labs(x = "Index", y = "GDP PerCap", title = "GDP Trend Line of Asia")+scale_x_discrete(limits= row.names(asia))+ theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)

For Europe

``` r
summary(europe<-gapminder %>% group_by(continent) %>% select(continent, gdpPercap) %>% filter(continent=="Europe")%>%arrange(gdpPercap))
```

    ##     continent     gdpPercap      
    ##  Africa  :  0   Min.   :  973.5  
    ##  Americas:  0   1st Qu.: 7213.1  
    ##  Asia    :  0   Median :12081.8  
    ##  Europe  :360   Mean   :14469.5  
    ##  Oceania :  0   3rd Qu.:20461.4  
    ##                 Max.   :49357.2

``` r
ggplot(europe, aes(x=row.names(europe), y = europe$gdpPercap, group=1)) + geom_bar(stat="identity",position="dodge", fill = "dark blue")+labs(x = "Index", y = "GDP PerCap", title = "GDP Trend Line of Europe")+scale_x_discrete(limits= row.names(europe))+ theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)

For Africa

``` r
summary(africa<-gapminder %>% group_by(continent) %>% select(continent, gdpPercap) %>% filter(continent=="Africa")%>%arrange(gdpPercap))
```

    ##     continent     gdpPercap      
    ##  Africa  :624   Min.   :  241.2  
    ##  Americas:  0   1st Qu.:  761.2  
    ##  Asia    :  0   Median : 1192.1  
    ##  Europe  :  0   Mean   : 2193.8  
    ##  Oceania :  0   3rd Qu.: 2377.4  
    ##                 Max.   :21951.2

``` r
ggplot(africa, aes(x=row.names(africa), y = africa$gdpPercap, group=1)) + geom_bar(stat="identity",position="dodge", fill = "dark blue")+labs(x = "Index", y = "GDP PerCap", title = "GDP Trend Line of Africa")+scale_x_discrete(limits= row.names(africa))+ theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

For Americas

``` r
summary(america<-gapminder %>% group_by(continent) %>% select(continent, gdpPercap) %>% filter(continent=="Americas")%>%arrange(gdpPercap))
```

    ##     continent     gdpPercap    
    ##  Africa  :  0   Min.   : 1202  
    ##  Americas:300   1st Qu.: 3428  
    ##  Asia    :  0   Median : 5466  
    ##  Europe  :  0   Mean   : 7136  
    ##  Oceania :  0   3rd Qu.: 7830  
    ##                 Max.   :42952

``` r
ggplot(america, aes(x=row.names(america), y = america$gdpPercap, group=1)) + geom_bar(stat="identity",position="dodge", fill = "dark blue")+labs(x = "Index", y = "GDP PerCap", title = "GDP Trend Line of America")+scale_x_discrete(limits= row.names(america))+ theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-8-1.png)

For Oceania

``` r
summary(oceania<-gapminder %>% group_by(continent) %>% select(continent, gdpPercap) %>% filter(continent=="Oceania")%>%arrange(gdpPercap))
```

    ##     continent    gdpPercap    
    ##  Africa  : 0   Min.   :10040  
    ##  Americas: 0   1st Qu.:14142  
    ##  Asia    : 0   Median :17983  
    ##  Europe  : 0   Mean   :18622  
    ##  Oceania :24   3rd Qu.:22214  
    ##                Max.   :34435

``` r
ggplot(oceania, aes(x=row.names(oceania), y = oceania$gdpPercap, group=1)) + geom_bar(stat="identity",position="dodge", fill = "dark blue")+labs(x = "Index", y = "GDP PerCap", title = "GDP Trend Line of Oceania")+scale_x_discrete(limits= row.names(oceania))+ theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)

Then let's do an overview of the whoe five continents

``` r
kable(gapminder %>% 
group_by(continent) %>% 
summarize(mean=mean(gdpPercap),min=min(gdpPercap), max=max(gdpPercap), std=sd(gdpPercap), q25=quantile(gdpPercap, probs=.25), q50=quantile(gdpPercap, probs=.5), q75=quantile(gdpPercap, probs=.75)))
```

| continent |       mean|         min|        max|        std|        q25|        q50|        q75|
|:----------|----------:|-----------:|----------:|----------:|----------:|----------:|----------:|
| Africa    |   2193.755|    241.1659|   21951.21|   2827.930|    761.247|   1192.138|   2377.417|
| Americas  |   7136.110|   1201.6372|   42951.65|   6396.764|   3427.779|   5465.510|   7830.210|
| Asia      |   7902.150|    331.0000|  113523.13|  14045.373|   1056.993|   2646.787|   8549.256|
| Europe    |  14469.476|    973.5332|   49357.19|   9355.213|   7213.085|  12081.749|  20461.386|
| Oceania   |  18621.609|  10039.5956|   34435.37|   6358.983|  14141.859|  17983.304|  22214.117|

Then let's try box plots to take a look by taking a log10 scale to solve unballance between different continents.

``` r
ggplot(gapminder, aes(x=continent, y=gdpPercap)) +
  geom_boxplot(outlier.colour = "blue", alpha=0.5, size=1, shape=1)  +
  scale_y_log10()
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-11-1.png)

### Question3: Compute a trimmed mean of life expectancy for different years.

How to compute a trimmed mean of life expectancy for different years? Let's take the trim value = 0.1 for example

``` r
kable(years <- gapminder %>% group_by(year) %>% select(year, lifeExp) %>% summarise_each(funs(mean(lifeExp, trim=0.1)), lifeExp))
```

    ## `summarise_each()` is deprecated.
    ## Use `summarise_all()`, `summarise_at()` or `summarise_if()` instead.
    ## To map `funs` over a selection of variables, use `summarise_at()`

|  year|   lifeExp|
|-----:|---------:|
|  1952|  48.57668|
|  1957|  51.26888|
|  1962|  53.58075|
|  1967|  55.86538|
|  1972|  58.01444|
|  1977|  60.10206|
|  1982|  62.11694|
|  1987|  63.92106|
|  1992|  65.18519|
|  1997|  66.01736|
|  2002|  66.71641|
|  2007|  68.11489|

``` r
ggplot(years, aes(x=year, y = lifeExp)) + geom_bar(stat="identity",position="dodge",fill = "Red")+labs(x = "Year", y = "Life Exp", title = "Life Exp by Year") + theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-1.png)

It is quite clear that the life exp increases steadily year by year.

### Question4: How is life expectancy changing over time on different continents?

Then we need to get all the life expectancy data by contients, groupby year and then get the average life expectany of the year, then we draw the plot and then we can see the tendency of changes

This is for Asia

``` r
asialifeexp <- gapminder %>% select(continent, year, lifeExp) %>% filter(continent=="Asia") %>% group_by(year) %>% summarize(avg_life_exp = mean(lifeExp))
ggplot(asialifeexp, aes(x=year, y = avg_life_exp)) + geom_bar(stat="identity",position="dodge",fill = "dark blue")+labs(x = "Year", y = "Life Exp", title = "Life Exp by Year for Asia") + theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png)

America starts from about 44 to 66 overall.

This is for Americas

``` r
americalifeexp <- gapminder %>% select(continent, year, lifeExp) %>% filter(continent=="Americas") %>% group_by(year) %>% summarize(avg_life_exp = mean(lifeExp))
ggplot(americalifeexp, aes(x=year, y = avg_life_exp)) + geom_bar(stat="identity",position="dodge",fill = "dark blue")+labs(x = "Year", y = "Life Exp", title = "Life Exp by Year for America") + theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-14-1.png)

America starts from about 54 to 68 overall.

This is for Africa

``` r
africalifeexp <- gapminder %>% select(continent, year, lifeExp) %>% filter(continent=="Africa") %>% group_by(year) %>% summarize(avg_life_exp = mean(lifeExp))
ggplot(africalifeexp, aes(x=year, y = avg_life_exp)) + geom_bar(stat="identity",position="dodge",fill = "dark blue")+labs(x = "Year", y = "Life Exp", title = "Life Exp by Year for Africa") + theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-15-1.png)

Africa seems to be starting from 39 to 46.

For Oceania

``` r
oceanialifeexp <- gapminder %>% select(continent, year, lifeExp) %>% filter(continent=="Oceania") %>% group_by(year) %>% summarize(avg_life_exp = mean(lifeExp))
ggplot(oceanialifeexp, aes(x=year, y = avg_life_exp)) + geom_bar(stat="identity",position="dodge",fill = "dark blue")+labs(x = "Year", y = "Life Exp", title = "Life Exp by Year for Oceania") + theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-16-1.png)

So it is quite clear that the life of Oceania increase from about 64 to 81. Wow so high!

For Europe

``` r
europelifeexp <- gapminder %>% select(continent, year, lifeExp) %>% filter(continent=="Europe") %>% group_by(year) %>% summarize(avg_life_exp = mean(lifeExp))
ggplot(europelifeexp, aes(x=year, y = avg_life_exp)) + geom_bar(stat="identity",position="dodge",fill = "dark blue")+labs(x = "Year", y = "Life Exp", title = "Life Exp by Year for Europe") + theme(plot.title = element_text(hjust = 0.5))
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-17-1.png)

So it is quite clear that the life of Europe increase from more than 60 to 78.

### Question 5: Find countries whose life expectancy is lower than the average of the world

First we need to compute the average life expectancy of the world for all the years together, which I want to take it in an easy way, just use the mean() function to calculate the lifeExp in gapminder dataset

``` r
avg_life <- mean(gapminder$lifeExp)
avg_life
```

    ## [1] 59.47444

Let's then calculate the average life expectancy of countries one by one whose is below the avg\_life calculated above

``` r
below_life <- gapminder%>%group_by(country, continent)%>%summarize(avg_life_exp = mean(lifeExp))%>%filter(avg_life_exp < avg_life)%>%arrange(continent)%>%group_by(continent)%>%summarize(n = n())

ggplot(below_life, aes(x=continent, y = n)) + geom_bar(stat="identity",position="dodge",fill = "dark blue")+labs(x = "Continent", y = "Life Exp", title = "Life Exp below average") + theme(plot.title = element_text(hjust = 0.5))+geom_text(aes(label=n), vjust=0)
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-19-1.png) Wow, it seems that there are total of 70 countries who is under average life exp and Africa accounts for over 81.6% of the total.

### Question 6: Find countries with interesting stories. Open-ended and, therefore, hard. Promising but unsuccessful attempts are encouraged. This will generate interesting questions to follow up on in class

Let's see what countries do we have

``` r
gapminder$country%>%unique()
```

    ##   [1] Afghanistan              Albania                 
    ##   [3] Algeria                  Angola                  
    ##   [5] Argentina                Australia               
    ##   [7] Austria                  Bahrain                 
    ##   [9] Bangladesh               Belgium                 
    ##  [11] Benin                    Bolivia                 
    ##  [13] Bosnia and Herzegovina   Botswana                
    ##  [15] Brazil                   Bulgaria                
    ##  [17] Burkina Faso             Burundi                 
    ##  [19] Cambodia                 Cameroon                
    ##  [21] Canada                   Central African Republic
    ##  [23] Chad                     Chile                   
    ##  [25] China                    Colombia                
    ##  [27] Comoros                  Congo, Dem. Rep.        
    ##  [29] Congo, Rep.              Costa Rica              
    ##  [31] Cote d'Ivoire            Croatia                 
    ##  [33] Cuba                     Czech Republic          
    ##  [35] Denmark                  Djibouti                
    ##  [37] Dominican Republic       Ecuador                 
    ##  [39] Egypt                    El Salvador             
    ##  [41] Equatorial Guinea        Eritrea                 
    ##  [43] Ethiopia                 Finland                 
    ##  [45] France                   Gabon                   
    ##  [47] Gambia                   Germany                 
    ##  [49] Ghana                    Greece                  
    ##  [51] Guatemala                Guinea                  
    ##  [53] Guinea-Bissau            Haiti                   
    ##  [55] Honduras                 Hong Kong, China        
    ##  [57] Hungary                  Iceland                 
    ##  [59] India                    Indonesia               
    ##  [61] Iran                     Iraq                    
    ##  [63] Ireland                  Israel                  
    ##  [65] Italy                    Jamaica                 
    ##  [67] Japan                    Jordan                  
    ##  [69] Kenya                    Korea, Dem. Rep.        
    ##  [71] Korea, Rep.              Kuwait                  
    ##  [73] Lebanon                  Lesotho                 
    ##  [75] Liberia                  Libya                   
    ##  [77] Madagascar               Malawi                  
    ##  [79] Malaysia                 Mali                    
    ##  [81] Mauritania               Mauritius               
    ##  [83] Mexico                   Mongolia                
    ##  [85] Montenegro               Morocco                 
    ##  [87] Mozambique               Myanmar                 
    ##  [89] Namibia                  Nepal                   
    ##  [91] Netherlands              New Zealand             
    ##  [93] Nicaragua                Niger                   
    ##  [95] Nigeria                  Norway                  
    ##  [97] Oman                     Pakistan                
    ##  [99] Panama                   Paraguay                
    ## [101] Peru                     Philippines             
    ## [103] Poland                   Portugal                
    ## [105] Puerto Rico              Reunion                 
    ## [107] Romania                  Rwanda                  
    ## [109] Sao Tome and Principe    Saudi Arabia            
    ## [111] Senegal                  Serbia                  
    ## [113] Sierra Leone             Singapore               
    ## [115] Slovak Republic          Slovenia                
    ## [117] Somalia                  South Africa            
    ## [119] Spain                    Sri Lanka               
    ## [121] Sudan                    Swaziland               
    ## [123] Sweden                   Switzerland             
    ## [125] Syria                    Taiwan                  
    ## [127] Tanzania                 Thailand                
    ## [129] Togo                     Trinidad and Tobago     
    ## [131] Tunisia                  Turkey                  
    ## [133] Uganda                   United Kingdom          
    ## [135] United States            Uruguay                 
    ## [137] Venezuela                Vietnam                 
    ## [139] West Bank and Gaza       Yemen, Rep.             
    ## [141] Zambia                   Zimbabwe                
    ## 142 Levels: Afghanistan Albania Algeria Angola Argentina ... Zimbabwe

Let's see which country has the highest gdpPercapita by mean, which means that the country is more wealthy in from a general perspective.

``` r
gapminder%>%select(country, pop, gdpPercap, year) %>% group_by(country) %>% summarize(population = mean(pop), gdp_percapita = mean(gdpPercap)) %>% arrange(desc(gdp_percapita)) %>% head()
```

    ## # A tibble: 6 x 3
    ##         country population gdp_percapita
    ##          <fctr>      <dbl>         <dbl>
    ## 1        Kuwait    1206496      65332.91
    ## 2   Switzerland    6384293      27074.33
    ## 3        Norway    4031441      26747.31
    ## 4 United States  228211232      26261.15
    ## 5        Canada   24462967      22410.75
    ## 6   Netherlands   13786798      21748.85

Wow, it is Kuwait which enjoys the highest GDP. So let's see the detailed timeline for tendency.

``` r
a<-gapminder%>%filter(country=="Kuwait")%>%select(year, gdpPercap, pop)
ggplot(a, aes(x=year, y = gdpPercap, color=year)) + geom_line() + geom_point()
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-22-1.png) It is quite interesting that the GDP was quite high in 1950s but in drastically droped between 1970 to 1980 and then slowly recovered... Let's add the population into consideration to see whether it has anything to do with the drop.

We need to do the normalization first by using scale() becasue the popluation number is much larger than the GDP value.

``` r
ggplot(a, aes(x=year)) + geom_point(aes(y=scale(gdpPercap)), ) + geom_line(aes(y=scale(gdpPercap),  color="red")) + geom_point(aes(y=scale(pop))) + geom_line(aes(y=scale(pop)), color = "blue") + labs(title="GDP Change with respective to time and population for Kuwait") + labs(caption="(based on normalized data)")
```

![](a_deeper_exploration_into_gapminder_dataset_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-1.png)

It is quite interesting that the GDP dropped drastically with the soaring growth of human population. Maybe becasue as we all know that during 1970 to 1990, Kuwait had war with Iraq and Iran, which crashed its economy. Maybe that is the reason. It is quite an interesting fact to find how fragile the GDP, or economy is of a country.

Personal Thought
----------------

It is quite clear that hw03 is harder than hw02 and I really spent some time in working on how to plan the piping and how to plot the graph in a more effective way. I like the notion of piping because it is much like the "&gt;" and "||" in Linux and make data handling much easier with linear thinking. No more loops or iterative function to think about and just a couple of simple steps makes the whole process much easier.

Furthermore, I found how to plot the graph is an art and it indeed requires more experience such as how to choose the right type of graph to show your idea in most effective way. How to handle different data ranges in a single graph, how to do the data normalization? It is an interesting topic to think and learn in the long run.
