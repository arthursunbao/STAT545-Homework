---
title: "scrape_download_show"
author: "Jason Sun"
date: "12/5/2017"
output: github_document
---


```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Let's load some library first

```{r cars}
library(purrr)
library(ggplot2)
library(reshape)
library(stringr)
library(tidyverse)
library(glue)
library(plyr)
library(rvest)
```

## Work That I have Done

I have continued with the slide's requirement in bestplace.com to dig information with rvest and I 

choose to find some crime information in Missouri and its counties. I firstly find out all the counties in Missouri and its respecitve crime link in the website and then saved as a dataframe for the next step's exploration. Then I choose a random county to download the detailed crime information of the county and showed as text.

The whole process is like this: scrape_data ----> scrape_download_show

You can use Makefile to automate the whole process.


## Let's do some work
First of all, let's know how many counties are there in Missouri?
```{r,warning = FALSE, message=FALSE}
county_crime_link <- read_csv("./mo_dataframe.csv")
nrow(county_crime_link)
```

Since I have already got the county name and its crime rate link, then I will show the table of the information.

```{r,warning = FALSE, message=FALSE}

knitr::kable(county_crime_link)
```

What if we want to see some detailed information regarding Wright?

We can use read_html(), html_nodes() and html_table() to help dig a little deeper and extract certain text information from it.

```{r,warning = FALSE, message=FALSE}
current_url <- "https://www.bestplaces.net/crime/county/missouri/wright"
temp_text <- read_html(current_url)
node <- html_nodes(temp_text, css = "table")
text <- html_table(node, head = TRUE,fill = TRUE)[[1]]
text
```

Hmm, Nice. We got the Crime Overview of the Wright County, Missouri as well as its respective composed of four offenses.


