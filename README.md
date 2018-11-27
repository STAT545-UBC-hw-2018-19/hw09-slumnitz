# STAT 547 - HW 09: Automating Data-analysis Pipelines

## Overview

This repository contains the homework assignment for the R course [STATS 545](http://stat545.com). A description of the assignment can be found [here](http://stat545.com/Classroom/assignments/hw09/hw09.html) and important information about the course can be found in the [course classroom](http://stat545.com/Classroom/).

This assignment and repository is developed and maintained by **Stefanie Lumnitz**.

## Content

In this assignment I automated a data analysis pipeline with `make` that showcases [Vancouver's Street Trees](https://vancouvertrees.shinyapps.io/vancouver_street_trees/).

**CHECK IT OUT:** one of the individualized reports for [Vancouver's West End](https://slumnitz.github.io/STAT547_participation/).

In my master's research I am testing a novel approach to easily update tree inventory data using Deep Learning and street view imagery. Especially important are hereby street tree location and genus. Knowing locations and genus helps bio-surveillance officials to target their surveillance efforts. For example, in order to detect harmful forest invasive insect species, like the Asian Longhorned Beetle early, teams of surveillors regularly check trees that could be potential host trees for this Beetle. The earlier they will detect the Beetle, the more likely it is that the Beetle gets successfully eradicated and cannot attack other trees.

This data analysis pipeline will help bio-surveillanve managers to understand the current tree genus composition in Vancouver. I will be using both R and Python scripts. More concretly this is what this pipeline includes:


Tasks | Fullfilled | notes
------|------------|------
Making a pipeline from scratch | :heavy_check_mark: | [Makefile](https://github.com/STAT545-UBC-students/hw09-slumnitz/blob/master/Makefile)
Include scripts of different language: Python | :heavy_check_mark: | see below
Adding structure to the project folder | :heavy_check_mark: | [`data`](https://github.com/STAT545-UBC-students/hw09-slumnitz/tree/master/data), [`images`](https://github.com/STAT545-UBC-students/hw09-slumnitz/tree/master/images), [`src`](https://github.com/STAT545-UBC-students/hw09-slumnitz/tree/master/src), [`reports`](https://github.com/STAT545-UBC-students/hw09-slumnitz/tree/master/reports)
Provide description of setup for RStudio if you use conda for Python | :heavy_check_mark: | [data download](https://github.com/STAT545-UBC-students/hw09-slumnitz/blob/master/src/python/download_tree_inventory.py)
Including automatic download and unpacking of tree inventory data | :heavy_check_mark: | [Python scripts](https://github.com/STAT545-UBC-students/hw09-slumnitz/blob/master/src/python/download_tree_inventory.py)
or option to use existing data with more phony targets | :heavy_check_mark: | [`make from_scratch` vs `make all`](https://github.com/STAT545-UBC-students/hw09-slumnitz/blob/master/Makefile)
Include R script for data processing | :heavy_check_mark: | [genus counts](https://github.com/STAT545-UBC-students/hw09-slumnitz/blob/master/src/r/genus_count.r)
Include R script for data visualization | :heavy_check_mark: | [plot genus counts](https://github.com/STAT545-UBC-students/hw09-slumnitz/blob/master/src/r/plot_genus.r)
Include [`.r`](https://github.com/STAT545-UBC-students/hw09-slumnitz/blob/master/src/r/generate_reports.r) script and [`.Rmd` template](https://github.com/STAT545-UBC-students/hw09-slumnitz/blob/master/src/rmd/report.rmd) for reporting pipline for all [`.csv`](https://github.com/STAT545-UBC-students/hw09-slumnitz/tree/master/data) files | :heavy_check_mark: | check all generated [reports](https://github.com/STAT545-UBC-students/hw09-slumnitz/tree/master/reports)
Add source links in reports | :heavy_check_mark: | [Vancouver street tree dataset](https://data.vancouver.ca/datacatalogue/streettrees.htm)


## Set-up, Comments & Resources

With this pipeline I wanted to test if it is possible to process multiple `.csv` files at once. In detail you will

* [download and extract](https://github.com/STAT545-UBC-students/hw09-slumnitz/tree/master/data) all `.csv` files from a `.zip` file in Python
* generate [customized plots](https://github.com/STAT545-UBC-students/hw09-slumnitz/tree/master/images) for all `.csv` files
* and generate [custom reports](https://github.com/STAT545-UBC-students/hw09-slumnitz/tree/master/reports) for all `.csv` files

My general *take-away* is that it is usually better to write a package instead of or complementary to using `make` for automating the processing of multiple input datasets, since hard coded dependencies and filename hacks can be avoided. However, it is possible to process multiple datasets in one pipeline, shown in this repo.

### Set-up and usage

#### With data download and Python

The difficulty downloading the data was that the data can only be downloaded from an `ftp` server, the file is downloaded as a `.zip` and needs to be unpacked and lastly, there are multiple `.csv` files in the unzupped folder which will all be used in the analysis pipline. I wrote this download pipeline in Python, which addedd the additional difficulty to set-up Rstudio correctly to communicate to the anaconda environment where my Python 3 is installed. Here is a little description on how this process can be reproduced:

1. To leverage the fullpotential of this makefile you will neet `Python 3` installed, preferably via `anaconda`.
2. In order to install all required python packages, namely `zipfile` and `ftplib` via anaconda you might need to change your RStudio default options. You can herefore open your `.Rprofile` file in a text editor, I used `vim` and add `Sys.setenv(PATH = paste("/home/username/anaconda/bin", Sys.getenv("PATH"), sep=":"))` as suggested on [stackoverflow](https://stackoverflow.com/questions/13735745/locate-the-rprofile-file-generating-default-options)
3. Once your environment is set up you are free to use the 

* `make from_scratch` and 
* `clean from_scratch` commands.

#### Without data download, relying on R

If you are having difficulties installing Python with anaconda and setting up your R environment you can simply use the data I provide for this example. I provided the commands 

*`make all` and 
* `make clean` 

for all users who do not want to bother working in two programming languages.


### The challenge of processing multiple datasets with make

**CHECK IT OUT:** one of the individualized reports for [Vancouver's West End](https://slumnitz.github.io/STAT547_participation/).

The challange in automatically processing multiple datasets with make is: **You really have to be on top of path names, know your patterns and be creative in processing characters**. 

* Did you know, depending on whether you are working in a `.R` script or an `.Rmd` file path names have to be dealt with differently. In an `.R` script you can for example use your current working directory and always access it relatively with a `./`, eg. `./images/` independet from the folder your R script is called from. RMarkdown files however need a path description absolute from the directory the `.Rmd` file is positioned at. If your `.Rmd` file would be in the same folder as your `.R` file, the path to `inages` needs to look like this: `../../images/`. 
* Leverage patterns to access all `.csv` files, for [example](https://github.com/STAT545-UBC-students/hw09-slumnitz/blob/master/src/r/genus_count.r) with: `fileNames <- Sys.glob("./data/*.csv")` and `for (fileName in fileNames) {}`
* `paste()` and `gsub()`are your dearest friends in order to extract nice descriptive name or automatize to iterate over multiple `.csv` files, like in this [example](https://github.com/STAT545-UBC-students/hw09-slumnitz/blob/master/src/rmd/report.rmd): `newFileName <- paste(gsub(".png", gsub("StreetTrees_", # e.g. "WestPointGrey`
* Lastly, I found it extremely valuable to be able to set `parameter variables` when I call a `.Rmd` file from an `.R` file: `params = list(fileName = fileName)`. THis way it is possible to "transfer" variables from one file to another and leverage the for-loop in the `.R` script.

### Resources

Resources that helped figure out the logic and build in the processing pipeline:

* Set-up
	* [anaconda and RStudio?](https://support.rstudio.com/hc/en-us/community/posts/201970148-Can-I-use-anaconda-python-in-RStudio-)
	* [locating and changing .Rprofile](https://stackoverflow.com/questions/13735745/locate-the-rprofile-file-generating-default-options)

* Iterating on multiple files
	* [Perform a function on multiple files in R](https://www.r-bloggers.com/perform-a-function-on-each-file-in-r/)
	* [create multiple reports in RMarkdown](https://www.reed.edu/data-at-reed/software/R/markdown_multiple_reports.html)
	* [example report](https://www.reed.edu/data-at-reed/resources/R/markdown_loop_example.html)
	* [iterative coding repo](https://github.com/majerus/r_code_tips/tree/master/iterative_reporting)
	* [Params in RMarkdown](https://stackoverflow.com/questions/32479130/passing-parameters-to-r-markdown)
	* [Knitting with parameters](https://bookdown.org/yihui/rmarkdown/params-knit.html)
	* [Parametrized reports](https://bookdown.org/yihui/rmarkdown/parameterized-reports.html)

* Working directories
	* [Working directories in RMarkdown](https://support.rstudio.com/hc/en-us/community/posts/220826588-Working-directory-in-R-Notebooks)

* Visualizations:
	* [DT an R interface to the DataTables library](https://rstudio.github.io/DT/)
	* [Leaflet for R: Markers](https://rstudio.github.io/leaflet/markers.html)
	* [beautiful plotting in R cheat sheet](http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/)

### Data

This app uses the freely available [Vancouver street tree dataset](https://data.vancouver.ca/datacatalogue/streettrees.htm). This dataset is very large, it includes roughly 100.000 trees or rows. Shiny does get slower with the amount of data displayed. Therefore I chose to have the user select tree heigh, diamter, neighbourhood and street in order to reduce the time spend loading the app.
