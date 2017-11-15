## A simple makefile to automate gapminder dataset exploration.

all: linear_regression_result.rds

#curl -L https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv > gapminder.tsv
#curl -L https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/country-codes.tsv > countrycode.tsv


original_dataset.tsv:
	Rscript step_zero_download_data.R

new_dataset.rds: step_one_get_dataset.R original_dataset.tsv
	Rscript step_one_get_dataset.R

figure.rds: step_two_generate_figure.R new_dataset.rds
	Rscript step_two_generate_figure.R
  
reordered_dataset.rds: step_three_reorder_data.R figure.rds
	Rscript step_three_reorder_data.R

linear_regression_result.rds: step_four_statistcal_analysis.R reordered_dataset.rds
	Rscript step_four_statistcal_analysis.R

clean:
	rm -f gapminder.tsv countrycode.tsv *.png *.rds *.pdf *.html
