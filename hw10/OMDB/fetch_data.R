library(httr)
library(purrr)
library(ggplot2)
library(reshape)
library(tidyverse)
library(glue)
library(plyr)
library(stringr)
library(dplyr)

#Get A Movie Rating
get_movie_rating <- function(name){
  if(is.null(name)){
    stop("Error Happend. Please kindly help to double check")
  }
  movie_name <- find_movie_info(name)
  movie_rating <- get_rating(movie_name)
  #We need to do some data cleansing for the score for imdb
  movie_rating$imdb <- movie_rating$imdb %>% str_replace_all("/10","")
  #We need to do some data cleansing for the score for RT score to exclude %
  movie_rating$RT <- as.numeric((movie_rating$RT %>% str_replace_all("%","")))/10
  #We need to do some data cleansing for the score for Met score to exclude /100
  movie_rating$Met <- as.numeric((movie_rating$Met %>% str_replace_all("/100","")))/10

  if(is.null(movie_rating)){
    stop("Error Happend. Please kindly help to double check")
  }
  else{
    return(movie_rating)
  }
}

get_rating <- function(name){
  if(is.null(name)){
    stop("Error Happend. Please kindly help to double check")
  }
  get_rating_result <- lapply(name$imdbID[1:nrow(name)],get_temp_ratings)
  output_result <- merge_recurse(get_rating_result)

  if(is.null(output_result)){
    stop("Error Happend. Please kindly help to double check")
  }
  else{
    return(output_result)
  }
}

get_temp_ratings <- function(ID){

  query_string <- glue("http://www.omdbapi.com/?i={ID}&apikey=bba70661")
  raw_data <- GET(query_string)
  parsed_data <- content(raw_data,as = "parsed")

  movie_title <- data.frame(movie_title = parsed_data$Title)
  movie_ratings <- parsed_data$Ratings %>% map_df(`[`, c("Source", "Value"))
  Year <- data.frame(Year = parsed_data$Year)

  temp_rating <- data.frame(t(movie_ratings[-1]))
  colnames(temp_rating) <- movie_ratings[ , 1]
  temp_rating <- cbind(rownames(temp_rating), temp_rating)
  rownames(temp_rating) <- NULL

  #Check how many rating do we have and apply all of them if possible
  if(nrow(movie_ratings) == 1){
    colnames(temp_rating) <- c("Value","imdb")
  }
  else if(nrow(movie_ratings) == 2){
    colnames(temp_rating) <- c("Value","imdb","RT")
  }
  else if(nrow(movie_ratings) == 3){
    colnames(temp_rating) <- c("Value","imdb","RT","Met")
  }
  else{
    colnames(temp_rating) <- c("Value")
  }

  #merge all the outputs
  Output <- merge(merge(movie_title,Year),temp_rating)
  Output = subset(Output, select = -c(Value) )

  return(Output)
}

# Find A Movie Info
find_movie_info <- function(name){
  api_key <- glue("http://www.omdbapi.com/?s={name}&apikey=bba70661")
  raw_data <- GET(api_key)
  parsed_data <- content(raw_data,as = "parsed")

  if(parsed_data$Response != "True"){
    stop("Error Happend. Please kindly help to double check")
  }

  #JSON Data Mapping
  mapped_result_data <- parsed_data$Search %>%
    map_df(`[`, c("Title","imdbID","Year","Type", "Poster"))

  if(is.null(mapped_result_data)){
    return(NULL)
  }
  else{
    return(mapped_result_data)
  }

}

#Get some data as examples for Transformers
movie_rating_transformers <- get_movie_rating("Transformers")
write_csv(movie_rating_transformers,"./transformers_rating.csv")

#Get some data as examples for Star Trek
movie_rating_startrek <- get_movie_rating("star+trek")
write_csv(movie_rating_startrek,"./star_trek_rating.csv")





