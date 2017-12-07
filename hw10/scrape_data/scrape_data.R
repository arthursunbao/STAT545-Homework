library(httr)
library(glue)
library(rvest)
library(tidyverse)
library(reshape)
library(ggplot2)
library(stringr)


#Let's get the URL
my_url <- "http://www.bestplaces.net/find/county.aspx?counties=mo"
raw_data <- read_html(my_url)

#Extract some Links baesd on Webpage structure
raw_data_link <- raw_data %>% html_nodes("a") %>% html_attr("href")
raw_county_data_link <- raw_data_link[55:169]


#Extract some text(ounties' name) baesd on Webpage structure
raw_data_counties <- raw_data %>% html_nodes("a") %>% html_text()
raw_data_counties <- raw_data_counties[55:169]


#Create a new data.frame for CA_counties
mo_dataframe <- data.frame(
  counties = raw_data_counties,
  crime_link = raw_county_data_link
)

#Add crime url
crime_url <- "https://www.bestplaces.net/crime"
crime_temp_link <- mo_dataframe$crime_link %>% str_replace_all("\\.\\.",crime_url)
mo_dataframe$crime_link=crime_temp_link

write_csv(mo_dataframe,"./mo_dataframe.csv")

