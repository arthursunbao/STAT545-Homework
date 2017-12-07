all: scrape_download_show.html

clean:
	rm -f *.csv
	rm -f *.png
	rm -f *.html

mo_dataframe.csv:
	Rscript scrape_data.R

scrape_download_show.html: scrape_download_show.Rmd mo_dataframe.csv
	Rscript -e 'rmarkdown::render("$<")'
