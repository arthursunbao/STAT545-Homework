library(purrr)
library(gapminder)
library(tidyverse)
library(forcats)
library(knitr)
library(ggthemes)
library(reshape)
library(tidyverse)
library(tidyr)
library(stringr)


new_dataset = readRDS("figure.rds")

#Let's do the work 

#Step1: Let's change the order of the new_dataset column

result_reorder_data <- new_dataset %>% mutate(continent = fct_reorder(continent,lifeExp, max))

result_reorder_data %>% saveRDS("reordered_dataset.rds")

#Step2: Plot a plot based on the above result_reorder_data for life_exp

max_life_exp <- result_reorder_data %>% group_by(continent) %>%  summarise(max_life_exp = max(lifeExp)) 
  
ggplot(max_life_exp, aes(x = continent, y = max_life_exp, color = max_life_exp))+ 
geom_point() + theme_bw() + theme(axis.title.x = element_text(size=20), axis.title.y = element_text(size=20), plot.title=element_text(hjust=0.5)) +
labs(title="max_LifeExp for each continent reordered")

ggsave("continent_based_max_life.png")

min_life_exp <- result_reorder_data %>% group_by(continent) %>%  summarise(min_life_exp = min(lifeExp)) 

ggplot(min_life_exp, aes(x = continent, y = min_life_exp, color = min_life_exp))+ 
  geom_point() + theme_bw() + theme(axis.title.x = element_text(size=20), axis.title.y = element_text(size=20), plot.title=element_text(hjust=0.5)) +
  labs(title="min_LifeExp for each continent reordered")

ggsave("continent_based_min_life.png")




