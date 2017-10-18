Tidy data and joins
=====================

### About this folder
Hi Everyone!

This is the folder for STAT545 Homework4: Tidy data and joins


![Direct Link to the File](https://github.com/arthursunbao/STAT545-Homework/blob/master/hw04/Tidy_data_and_joins.md "Direct Link to the File")

Basically we will introduce the dataset according to these following fields: 

- Make you own cheatsheet similar to Tyler Rinker's minimal guide to tidyr.

- Make a tibble with one row per year and columns for life expectancy for two or more countries.

- Compute some measure of life expectancy (mean? median? min? max?) for all possible combinations of continent and year. Reshape that to have one row per year and one variable for each continent. Or the other way around: one row per continent and one variable per year.

- In Window functions, we formed a tibble with 24 rows: 2 per year, giving the country with both the lowest and highest life expectancy (in Asia). Take that table (or a similar one for all continents) and reshape it so you have one row per year or per year * continent combination.

- Previous TA Andrew MacDonald has a nice data manipulation sampler. Make up a similar set of exercises for yourself, in the abstract or (even better) using Gapminder or other data, and solve them.

- Create a second data frame, complementary to Gapminder. Join this with (part of) Gapminder using a  dplyr join function and make some observations about the process and result. Explore the different types of joins. 

- Create your own cheatsheet patterned after mine but focused on something you care about more than comics! 

- Explore the base function merge(), which also does joins. Compare and contrast with dplyr joins.

- Explore the base function match(), which is related to joins and merges, but is really more of a ???table lookup???. Compare and contrast with a true join/merge.
