Tidy data and joins
================
Jason Sun
2017-11-05

Intro
-----

Today we will do Data wrangling wrap up

This page will be divided into the following aspects and solve the respective problems

-   Character data

-   Writing functions

-   Work with the candy data

-   Work with the singer data

-   Work with a list

-   Work with a nested data frame

Initial Setup
-------------

We need to load some dataset first

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
suppressPackageStartupMessages(library(stringr))
library(forcats)
library(gapminder)
library(tidyverse)
library(ggplot2)
library(knitr)
library(ggthemes)
library(reshape)
library(tidyr)
library(stringr)
knitr::opts_chunk$set(fig.width=8, fig.height=5)
```

Let's do some work buddy!
-------------------------

### Question 1: Character data: Read and work the exercises in the Strings chapter or R for Data Science.

#### Question1: In code that doesn't use stringr, you'll often see paste() and paste0(). What's the difference between the two functions? What stringr function are they equivalent to? How do the functions differ in their handling of NA?

Answer: Both function has the same argument called sep, which describes the space to write the series of strings. So The difference between paste() and paste0() is that the argument sep by default is (paste) and (paste0).

The equivalent function in stringr is str\_c(). However, in str\_c(), NA functions are silently dropped() while paste will not.

#### Question2: In your own words, describe the difference between the sep and collapse arguments to str\_c()

Answer: Basically it describes the same function of the cancatenation of two words by what character. However, sep describtes the element which separates every term and tt should be specified with character string format.

However, collapse describtes the element which separates every result and it should be specified with character string format and it is optional.

#### Use str\_length() and str\_sub() to extract the middle character from a string. What will you do if the string has an even number of characters?

Answer: If there is even number of characters, then just extract the two characters which are in the middle of the string

#### What does str\_wrap() do? When might you want to use it?

Answer: strwrap() function wraps character strings to format paragraphs. The input strings are split into paragraphs and then formateed by breaking lines at word boundaries. So str\_wrap() is basically used to wrap character strings into fromat paragraphs.

#### What does str\_trim() do? What's the opposite of str\_trim()?

Answer: str\_trim() is used to delete the whitespaces from the start and the end of the string. The opposite of str\_trim() is str\_c() I think because it can add new white spaces in front of the string or at the end of the string.

#### Explain why each of these strings don't match a : "", "\\", "\\".

Answer: "" is an escape character inregular expressions. First you need to escape it by creating a regular expression "\\" and then use a string, then you need to have another "" and finally to match a literal "", you need to add another "". So finally the result should be "\\\\"

#### What patterns will the regular expression "......" match? How would you represent it as a string?

Answer: "." will try to match a character and "." is a specific character. So basically it means that it is a kind of string like "CharacterA.CharacterB.CharacterC"

#### For each of the following challenges, try solving it by using both a single regular expression

##### Find all words that start or end with x.

Answer: str\_detect(words, "^x") or str\_detect(words, "x$")

##### Find all words that start with a vowel and end with a consonant.

Answer: str\_detect(words, "[1]\[a-z0-9\]\[^aeiou\]$")

##### Are there any words that contain at least one of each different vowel?

Answer: str\_detect(words, "\[aeiou\]")

#### Split up a string like "apples, pears, and bananas" into individual components.

Answer: str\_split(string, ", ")

#### Why is it better to split up by boundary("word") than " "?

Answer: We can use regex to try to specify any special conditions.

#### How would you find all strings containing  with regex() vs. with fixed()?

Answer: for regex(), we can use "\\" expression to look for  and with fixed(), we can use just use "" to do the exact match for
\#\#\#\# What are the five most common words in sentences?

We can use stri\_locale\_info() to find out the most common words in sentences.

#### Find the stringi functions that: Count the number of words, Find duplicated strings, Generate random text.

Answer: **Count the number of words**: str\_count()

**Find duplicated strings**: str\_detect() or str\_locate() can help to identify a certain pattern in a string.

**Generate random text**: stri\_rand\_strings() can help to generate random text.

Question2: Write functions: If you plan to complete the homework where we build an R package, write a couple of experimental functions exploring some functionality that is useful to you in real life and that might form the basis of your personal package
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

I will make a couple of experimental functions to explore some possibility for intro math expression with well wrapper functions

I will first try to write a function which will get the central tendency and the data information of a vector x. The input parameters are the input numeric vector x, whether we need to print the result or not:

``` r
estimate_central_tendency <- function(input, npar=TRUE, result = TRUE){
  if(!npar){
    result_center <- mean(input);
    estimiation_std <- sd(input);
  }
  else{
    result_center <- median(input);
    estimiation_std <- mad(input);
  }
  if(result & !npar){
    cat("Mean=", result_center, "\n", "Standard_Deviation=", estimiation_std, "\n")
  }
  else if(result & npar){
    cat("Median=", result_center, "\n", "Standard_Deviation=", estimiation_std, "\n")
  }
  return_result <- list(center=result_center,spread=estimiation_std)
  return(return_result)
}

# Let's have a working function
set.seed(1000)
input_parameter <- rpois(200,3)
output_result <- estimate_central_tendency(input_parameter)
```

    ## Median= 3 
    ##  Standard_Deviation= 1.4826

``` r
# Let's have another self-defined function for returning the max and min function.

find_bigger_number <- function(input1, input2){
  stopifnot(is.numeric(input1));
  stopifnot(is.numeric(input2));
  if(input1 >= input2){
    retrun(input1)
  }
  else{
    return(input2)
  }
}

#Let's test that
output_result = find_bigger_number(15,20)

#Let's develop a function which can return the square of a certain number

squared_number <- function(input_number){
  stopifnot(is.numeric(input_number))
  if(input_number < 0) return(0)
  current_result <- sqrt(input_number)
  return(current_result)
}

#Then let's test that
squared_output = squared_number(10)
```

Work with a list: Work through and write up a lesson from the purrr tutorial:
-----------------------------------------------------------------------------

-   Trump Android Tweets

-   Simplifying data from a list of GitHub users

**Trump Android Tweets** Through the tutorial of purrr, I have learned a lot regarding some new knowledge regarding R programming, mainly about how to manipulate the purrr library as well as to utilize R to solve real world problem, which is a very intersting topic the tutorial given in the website to analyze Trump's tweets.

First regex expreesion is used to filter out the key words of Trumps's tweets, the tutorial used "|" to represent "or" to link all relevant words together and then filter out the tweets which contains all the keywords and then do the strtrim() to clean the word first: "tweets %&gt;% strtrim(70)"

Then the author used a very powerfull tool called gregexpr() to filter out the regex expressions in a certain list, which saves labourious efforts: matches &lt;- gregexpr(regex, tweets)

After that, an even more powerful tool is used called substring to get text from certain positions from a string as we know that the tweet raw data has certain formats and we can get the match result based on certain positions which has been previously defined.

matches() function is then used to extract the key words that are previously defined in the regex expression so that we can get the substring()ed tweets for certain key words, which is fantastic. Then we use match\_length() to store the match lengths of certain words. For example, if we have word happy showed up in tweets for 70 times and sad for only 10 times, then we can have a rough idea that happy has more frequeny of showed up.

So basically the tutorial shows us how to manipulate data in a well-defined method and how to utilize R to solve real-world problem, which is quite nice.

**Simplifying data from a list of GitHub users**

This tutorial is mainly about how to use map() function to extract useful data from non-rectangular data structure and create clean dataframe.

The input data is stored in repurrsive recursive list and the tutorial first tries to inspect the dataset with str() and listveiwer::jsonedit() to explore it in a visual way.

Then the tutorial used purrr::map() function to map the user from the raw data strcutre to login, which is a new list to store all output result. Different output data types are imported like map\_chr to handle char data and map\_lgl(), map\_int() and map\_dbl(), etc.

The tutorial also introduced how to map and retrieve multiple elements, map() function also works in that way and you just need to input multiple mapping parameters into the parameter list.

After that, map\_df() is introduced to map data into data frames, techniques to handle vector input to extract shortcuts and how to handle list inside a certain data frame, which is really worth reading.

Personal Thought
----------------

Since this is the first homework for this new term. So basically the work is not that hard. What I learned is basically try to implement the stringi() and self-defined function, which helped me a lot in developing more complex code in R. Overall, the process is not that diffcult and looking foward to the next time challenge :)
