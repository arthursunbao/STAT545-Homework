library(httr)
library(glue)
library(rvest)
library(stringr)
library(tidyverse)
library(reshape)
library(ggplot2)

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
  link = raw_county_data_link
)

write_csv(mo_dataframe,"./mo_dataframe.csv")




#Function to get table of a url
Get_table <- function(url){
  kw <- read_html(url)
  c <- html_nodes(kw, css = "table")
  html_table(c, head = TRUE,fill = TRUE)[[1]]
}

#Call the function and get the table recursively
All_city_job <- lapply(unique(CA_counties$Link), Get_table)
All_city_job <- merge_recurse(All_city_job)
All_city_job <- All_city_job %>%
  drop_na()

#Switch the rows and columns
All_city_job2 <- data.frame(t(All_city_job[-1]))
colnames(All_city_job2) <- All_city_job[ , 1]

#Rename the columns
All_city_job2 <- cbind(rownames(All_city_job2), All_city_job2)
rownames(All_city_job2) <- NULL
colnames(All_city_job2) <- c("Counties","IncomePerCap","HouseholdIncome","UnemploymentRate","RecentJobGrowth","FutureJobGrowth")

#Store to the local
write_csv(All_city_job2,"./All_city_job.csv")

#Do the same work for Cost of living part

#Add cost_url
Cost_url <- "https://www.bestplaces.net/cost_of_living"
Cost_Link <- CA_counties$Link %>%
  str_replace_all("https://www.bestplaces.net/jobs",Cost_url)
CA_counties$Link=Cost_Link

#Store to the local
write_csv(CA_counties,"./CA_counties_cost.csv")

#Get table
Get_table2 <- function(url){
  kw <- read_html(url)
  c <- html_nodes(kw, css = "table")
  html_table(c, head = TRUE,fill = TRUE)[[2]]
}

#Call the function and get the table recursively
All_city_cost <- lapply(unique(CA_counties$Link), Get_table2)
All_city_cost <- merge_recurse(All_city_cost)

#Switch the rows and columns
All_city_cost2 <- data.frame(t(All_city_cost[-1]))
colnames(All_city_cost2) <- All_city_cost[ , 1]

#Rename the columns
All_city_cost2 <- cbind(rownames(All_city_cost2), All_city_cost2)
rownames(All_city_cost2) <- NULL
colnames(All_city_cost2) <- c("Counties","Overall","Grocery","Health","Housing","Utilities","Transportation","Miscellaneous")

#Store to the local
write_csv(All_city_cost2,"./All_city_cost.csv")
