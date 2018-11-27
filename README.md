# STAT 547 - HW 09: Automating Data-analysis Pipelines

## Overview

This repository contains the homework assignment for the R course [STATS 545](http://stat545.com). A description of the assignment can be found [here](http://stat545.com/Classroom/assignments/hw09/hw09.html) and important information about the course can be found in the [course classroom](http://stat545.com/Classroom/).

This assignment and repository is developed and maintained by **Stefanie Lumnitz**.

## Content

In this assignment I automated a data analysis pipeline with `make` that showcases [Vancouver's Street Trees](https://vancouvertrees.shinyapps.io/vancouver_street_trees/). 

In my master's research I am testing a novel approach to easily update tree inventory data using Deep Learning and street view imagery. Especially important are hereby street tree location and genus. Knowing locations and genus helps bio-surveillance officials to target their surveillance efforts. For example, in order to detect harmful forest invasive insect species, like the Asian Longhorned Beetle early, teams of surveillors regularly check trees that could be potential host trees for this Beetle. The earlier they will detect the Beetle, the more likely it is that the Beetle gets successfully eradicated and cannot attack other trees.

This data analysis pipeline will help bio-surveillanve managers to understand the current tree genus composition in Vancouver. I will be using both R and Python scripts. More concretly this is what this pipeline includes:


Tasks | Fullfilled | notes
------|------------|------
Making a pipeline from scratch| :heavy_check_mark: |
Including texts of different languages | :heavy_check_mark: | Python scripts
Provide description of setup for RStudio if you use conda for Python| :heavy_check_mark: |
Option to download data| :heavy_check_mark: |
Option to use existing data | :heavy_check_mark: |
Include R script for data processing | :heavy_check_mark: |
Include .Rmd Script for reporting | :heavy_check_mark: | 
Make a graph of the pipeline using makefile2dot | :heavy_check_mark: |
Add pie chart displaying genus distribution for selected trees and region | :heavy_check_mark: |
Add disclaimer text | :heavy_check_mark: |
Add source links | :heavy_check_mark: | [Vancouver street tree dataset](https://data.vancouver.ca/datacatalogue/streettrees.htm) using `p()`
Deploy on shinyapps.io | :heavy_check_mark: | [Vancouver's Street Trees](https://vancouvertrees.shinyapps.io/vancouver_street_trees/)

## Comments & Resources

### The challenge of reactivity

**TRY IT OUT:** click on any row in the table.

The challange in creating great shiny apps is correctly connecting inputs and outputs with each other. For example, so that the user can click on rows in a table and shiny automatically highlights specific objects in other visualisations. Or that only street names are displayed that are present in a previously selected neighbourhood. I did not find good best practive examples on the internet how to solve these problems, checkign documentation and stackoverflow chats. In the end I wrote code connected to the logic described in standard documentation examples. Due to the lack of best practice examples on how to properly connect inputs and outputs this work can fill teh gap and show others the value added.

### Resources

Resources that helped figure out the logic and build the app include:

* [DT an R interface to the DataTables library](https://rstudio.github.io/DT/)
* [Leaflet for R: Markers](https://rstudio.github.io/leaflet/markers.html)
* [DT in practice shiny app](https://yihui.shinyapps.io/DT-rows/)
* [Shiny for spatial data](https://paula-moraga.github.io/tutorial-shiny-spatial/)
* [DataTables extensions](https://rstudio.github.io/DT/extensions.html)
* [Doc: update extravaganza](https://datatables.net/blog/2015-08-13)
* [Building a shiny app - interactive tutorial](https://deanattali.com/blog/building-shiny-apps-tutorial/#11-using-uioutput-to-create-ui-elements-dynamically)
* [Doc: sinyapps.io](http://docs.rstudio.com/shinyapps.io/getting-started.html#deploying-applications)

### Data

This app uses the freely available [Vancouver street tree dataset](https://data.vancouver.ca/datacatalogue/streettrees.htm). This dataset is very large, it includes roughly 100.000 trees or rows. Shiny does get slower with the amount of data displayed. Therefore I chose to have the user select tree heigh, diamter, neighbourhood and street in order to reduce the time spend loading the app.

  
  
  .Rprofile

`Sys.setenv(PATH = paste("/home/username/anaconda/bin", Sys.getenv("PATH"), sep=":"))'