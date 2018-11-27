# make with data download
from_scratch: report_from_scratch

# make without data download
all: report_all

# clean with data download
clean_from_scratch:
	rm -rf ./data/
	rm -rf ./images/
	rm -rf ./reports/

# clean without data download
clean:
	rm -rf ./images/
	rm -rf ./reports/

# download data
data: ./src/python/download_tree_inventory.py
	mkdir -p ./data/
	python $<

# clean_data
clean_data: ./csv_street_trees.zip
	rm csv_street_trees.zip

# generate data for plotting
count_genus: ./src/r/genus_count.r
	Rscript $<

# plot genus_count
plot_genus: ./src/r/plot_genus.r
	mkdir -p ./images/
	Rscript $<

# generate HTML from scratch
report_from_scratch: ./src/r/generate_reports.r data clean_data count_genus plot_genus
	mkdir -p ./reports/
	Rscript $<

# generate HTML with downloaded data
report_all: ./src/r/generate_reports.r count_genus plot_genus
	mkdir -p ./reports/
	Rscript $<