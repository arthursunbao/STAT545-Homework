library(purrr)
library(ggplot2)
library(reshape)
library(stringr)
library(tidyverse)
library(glue)
library(plyr)

#Get the data from the csv
movie_rating_transformers <- read_csv("/Users/jasonsun/stat545/work1/STAT545-hw01--Bao-Sun/hw10/OMDB/transformers_rating.csv")
movie_rating_startrek <- read_csv("/Users/jasonsun/stat545/work1/STAT545-hw01--Bao-Sun/hw10/OMDB/star_trek_rating.csv")

#Let's get a brief overview of the current dataset we have for transformers
knitr::kable(movie_rating_transformers)
#Let's get a brief overview of the current dataset we have for star trek
knitr::kable(movie_rating_startrek)

#Let's do some plots
#Let's first get the IMDB score for transformers
movie_rating_transformers_temp <- movie_rating_transformers  %>% select(movie_title, imdb)%>% filter(imdb > 0) %>% arrange(desc(imdb))
#Let's choose top 5 for IMDB for transformers
movie_rating_transformers_temp <- movie_rating_transformers_temp[0:5,]
knitr::kable(movie_rating_transformers_temp)
#Then let's draw a plot for top 5 scores
plot1 <- ggplot(movie_rating_transformers_temp, aes(x=movie_rating_transformers_temp$movie_title, y = movie_rating_transformers_temp$imdb)) +
  geom_bar(stat="identity",position="dodge",fill = "dark blue")+
  labs(x = "Movie Name", y = "IMDB Score", title = "IMDB Score of Transformers") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("/Users/jasonsun/stat545/work1/STAT545-hw01--Bao-Sun/hw10/OMDB/imdb_transformer.png",plot1,device = "png", width = 10, height = 7,dpi = 500)

#Let's first get the RT score for transformers
movie_rating_transformers_temp_rt <- movie_rating_transformers  %>% select(movie_title, RT)%>% filter(RT > 0) %>% arrange(desc(RT))#Let's choose top 5 for RT for transformers
movie_rating_transformers_temp_rt <- movie_rating_transformers_temp_rt[0:5,]
#Then let's have an overview
knitr::kable(movie_rating_transformers_temp_rt)
#Then let's draw a plot for top 5 scores
plot2 <- ggplot(movie_rating_transformers_temp_rt, aes(x=movie_rating_transformers_temp_rt$movie_title, y = movie_rating_transformers_temp_rt$RT)) +
  geom_bar(stat="identity",position="dodge",fill = "dark blue")+
  labs(x = "Movie Name", y = "RT Score", title = "RT Score of Transformers") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("/Users/jasonsun/stat545/work1/STAT545-hw01--Bao-Sun/hw10/OMDB/rt_transformer.png",plot2,device = "png", width = 10, height = 7,dpi = 500)


#Let's first get the Met score for transformers
movie_rating_transformers_temp_met <- movie_rating_transformers  %>% select(movie_title, Met)%>% filter(Met > 0) %>% arrange(desc(Met))#Let's choose top 5 for RT for transformers
#Let's choose top 5 for RT
movie_rating_transformers_temp_met <- movie_rating_transformers_temp_met[0:5,]
#Then let's have an overview
knitr::kable(movie_rating_transformers_temp_met)
#Then let's draw a plot for top 5 scores
plot3 <- ggplot(movie_rating_transformers_temp_met, aes(x=movie_rating_transformers_temp_met$movie_title, y = movie_rating_transformers_temp_met$Met)) +
  geom_bar(stat="identity",position="dodge",fill = "dark blue")+
  labs(x = "Movie Name", y = "Met Score", title = "Met Score of Transformers") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("/Users/jasonsun/stat545/work1/STAT545-hw01--Bao-Sun/hw10/OMDB/met_transformer.png",plot3,device = "png", width = 10, height = 7,dpi = 500)

#### Do Some Work with Star Trek

#Let's do some plots
#Let's first get the IMDB score for Star Trek
movie_rating_star_trek_temp <- movie_rating_startrek  %>% select(movie_title, imdb)%>% filter(imdb > 0) %>% arrange(desc(imdb))
#Let's choose top 5 for IMDB for Star Trek
movie_rating_star_trek_temp <- movie_rating_star_trek_temp[0:5,]
knitr::kable(movie_rating_star_trek_temp)
#Then let's draw a plot for top 5 scores
plot4 <- ggplot(movie_rating_star_trek_temp, aes(x=movie_rating_star_trek_temp$movie_title, y = movie_rating_star_trek_temp$imdb)) +
  geom_bar(stat="identity",position="dodge",fill = "green")+
  labs(x = "Movie Name", y = "IMDB Score", title = "IMDB Score of Star Trek") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("/Users/jasonsun/stat545/work1/STAT545-hw01--Bao-Sun/hw10/OMDB/imdb_star_trek.png",plot4,device = "png", width = 10, height = 7,dpi = 500)

#Let's first get the RT score for Star Trek
movie_rating_star_trek_temp_rt <- movie_rating_startrek  %>% select(movie_title, RT)%>% filter(RT > 0) %>% arrange(desc(RT))
movie_rating_star_trek_temp_rt <- movie_rating_star_trek_temp_rt[0:5,]
#Then let's have an overview
knitr::kable(movie_rating_star_trek_temp_rt)
#Then let's draw a plot for top 5 scores
plot5 <- ggplot(movie_rating_star_trek_temp_rt, aes(x=movie_rating_star_trek_temp_rt$movie_title, y = movie_rating_star_trek_temp_rt$RT)) +
  geom_bar(stat="identity",position="dodge",fill = "red")+
  labs(x = "Movie Name", y = "RT Score", title = "RT Score of Star Trek") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("/Users/jasonsun/stat545/work1/STAT545-hw01--Bao-Sun/hw10/OMDB/rt_star_trek.png",plot5,device = "png", width = 10, height = 7,dpi = 500)


#Let's first get the Met score for Star Trek
movie_rating_star_trek_temp_met <- movie_rating_startrek  %>% select(movie_title, Met)%>% filter(Met > 0) %>% arrange(desc(Met))
#Let's choose top 5 for Met
movie_rating_star_trek_temp_met <- movie_rating_star_trek_temp_met[0:5,]
#Then let's have an overview
knitr::kable(movie_rating_star_trek_temp_met)
#Then let's draw a plot for top 5 scores
plot6 <- ggplot(movie_rating_star_trek_temp_met, aes(x=movie_rating_star_trek_temp_met$movie_title, y = movie_rating_star_trek_temp_met$Met)) +
  geom_bar(stat="identity",position="dodge",fill = "dark blue")+
  labs(x = "Movie Name", y = "Met Score", title = "Met Score of Star Trek") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("/Users/jasonsun/stat545/work1/STAT545-hw01--Bao-Sun/hw10/OMDB/rt_star_trek.png",plot6,device = "png", width = 10, height = 7,dpi = 500)







