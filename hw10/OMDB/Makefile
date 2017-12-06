all: omdb_dataset_download_show.html

clean:
	rm -f *.csv
	rm -f *.png
	rm -f *.html

star_trek_rating.csv transformers_rating.csv:
	Rscript fetch_data.R

Plot: Plot.R star_trek_rating.csv transformers_rating.csv
	Rscript $<
	rm -f Rplots.pdf

omdb_dataset_download_show.html: omdb_dataset_download_show.Rmd Plot star_trek_rating.csv transformers_rating.csv
	Rscript -e 'rmarkdown::render("$<")'
