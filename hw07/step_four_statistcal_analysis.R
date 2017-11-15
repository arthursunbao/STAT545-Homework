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
library(broom)
library(ggmap)

new_dataset = readRDS("new_dataset.rds")

# Let's do some work
# Let's do the linear regression model
# Fit a linear regression of life expectancy on year within each country. Write the estimated intercepts, slopes, and residual error variance (or sd) to file. The R package broom may be useful here.
# Let's define a function to do the linear regression with lifeExp with year
linear_regression_model <- function(year) {
  lm(lifeExp ~ I(year - 1900), data = year)
}

nest_country <- new_dataset %>% group_by(continent, country) %>% nest()

result <- nest_country %>%  mutate(model = map(data, linear_regression_model), tidy = map(model, tidy)) %>% 
select(continent, country, tidy) %>% unnest(tidy) %>% mutate(term = recode(term, `Interception` = "intercept", `Year Difference` = "slope"))
                                                    

result 

result %>%saveRDS("linear_regression_result.rds")

# Let's now do some plotting to apply the linear regression model into the each continent

asia <- new_dataset %>% filter(continent == "Asia")
  
ggplot(asia, aes(x=year,y=lifeExp)) + geom_point(aes(color = country)) +  geom_smooth(method="lm",se=FALSE) + labs(title="Asia country by country life exp plot")

ggsave("Asia_country_by_country_life_exp_plot.png" )


africa <- new_dataset %>% filter(continent == "Africa")

ggplot(africa, aes(x=year,y=lifeExp)) + geom_point(aes(color = country)) +  geom_smooth(method="lm",se=FALSE) + labs(title="Africa country by country life exp plot")

ggsave("Africa_country_by_country_life_exp_plot.png" )


america <- new_dataset %>% filter(continent == "Americas")

ggplot(america, aes(x=year,y=lifeExp)) + geom_point(aes(color = country)) +  geom_smooth(method="lm",se=FALSE) + labs(title="America country by country life exp plot")

ggsave("America_country_by_country_life_exp_plot.png" )

europe <- new_dataset %>% filter(continent == "Europe")

ggplot(europe, aes(x=year,y=lifeExp)) + geom_point(aes(color = country)) +  geom_smooth(method="lm",se=FALSE) + labs(title="European country by country life exp plot")

ggsave("European_country_by_country_life_exp_plot.png" )


# Let's find out the best 4 and worst 4 countries for each continent and I will use the stderr to do the judgement

Asia_good <- result %>%  filter(continent == "Asia") %>% arrange(std.error) %>%  head(3L)
knitr::kable(Asia_good)

Asia_bad <- result %>%  filter(continent == "Asia") %>% arrange(desc(std.error)) %>%  head(3L)
knitr::kable(Asia_good)

europe_good <- result %>%  filter(continent == "Europe") %>% arrange(std.error) %>%  head(3L)
knitr::kable(europe_good)

europe_bad <- result %>%  filter(continent == "Europe") %>% arrange(desc(std.error)) %>%  head(3L)
knitr::kable(europe_bad)

america_good <- result %>%  filter(continent == "Americas") %>% arrange(std.error) %>%  head(3L)
knitr::kable(america_good)

africa_bad <- result %>%  filter(continent == "Africa") %>% arrange(desc(std.error)) %>%  head(3L)
knitr::kable(africa_bad)

africa_good <- result %>%  filter(continent == "Africa") %>% arrange(std.error) %>%  head(3L)
knitr::kable(africa_good)

asia_bad <- result %>%  filter(continent == "Asia") %>% arrange(desc(std.error)) %>%  head(3L)
knitr::kable(asia_bad)

asia_good <- result %>%  filter(continent == "Asia") %>% arrange(std.error) %>%  head(3L)
knitr::kable(asia_good)
