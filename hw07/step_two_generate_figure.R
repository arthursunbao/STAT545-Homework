library(purrr)
library(forcats)
library(tidyverse)
library(gapminder)
library(tidyverse)
library(knitr)
library(ggthemes)
library(reshape)
library(tidyr)
library(stringr)

knitr::opts_chunk$set(fig.width=13, fig.height=10)

#Let's do some work

new_dataset = readRDS("new_dataset.rds")

# Let's try to see the scatterplot for the relationship between lifeExp and gdpPercap

scatterplot_lifexp_gdppercap <- ggplot(new_dataset, aes(x = gdpPercap, y = lifeExp)) + geom_point()

scatterplot_lifexp_gdppercap

ggsave("life_exp_hist",scatterplot_lifexp_gdppercap ,device = "png", width = 10, height = 10,dpi = 300)


# Let's try to find out the log10(gdpPerCap) towards lifeExp

scatterplot_log10_lifeexp_gdppercap <- ggplot(new_dataset, aes(x = log10(gdpPercap), y = lifeExp)) + geom_point()

scatterplot_log10_lifeexp_gdppercap

ggsave("scatterplot_log10_lifeexp_gdppercapt",scatterplot_log10_lifeexp_gdppercap ,device = "png", width = 10, height = 10,dpi = 300)

# Let's draw a plot by year with different countries and their respective lifeExp

jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")

different_life_exp <- ggplot(subset(new_dataset, country %in% jCountries), aes(x = year, y = lifeExp, color = country)) + geom_line() + geom_point()

different_life_exp

ggsave("different_life_exp",different_life_exp ,device = "png", width = 10, height = 10,dpi = 300)

# I will reorder the avg life expectany by continents in year 2007 from largest to smallest based on their respective average life expectancy

# Make a plot of GDP for country codec between 30 and 120
new_dataset_codec <- new_dataset %>%  filter(iso_num >30 & iso_num <120) %>% ggplot(aes(x = year, y = (gdpPercap*pop)))+ facet_wrap(~ country , scales = "free_y") + geom_point(aes(color = country, size = 2)) + theme_bw() +
theme(strip.background = element_rect(fill="grey"), axis.title.x = element_text(size=15), axis.title.y = element_text(size=15), strip.text = element_text(size=10, face="bold",hjust=0.5)) + scale_y_continuous("GDP")   

new_dataset_codec

ggsave("new_dataset_codec",new_dataset_codec ,device = "png", width = 10, height = 10,dpi = 300)


new_dataset %>% saveRDS("figure.rds")
