library(knitr)
library(markdown)
library(rmarkdown)

imageNames <- Sys.glob("./images/*.png")


# for each area in Vancouver create a report
# these reports are saved in output_dir with the name specified by output_file
for (fileName in imageNames){
	# extract filename
	newBaseName <-paste(sub(".png", basename(fileName), replacement = ""))
	newFileName <- paste(gsub(".png", gsub("StreetTrees_", x= basename(fileName), replacement = ""), replacement = ""))

	rmarkdown::render(input = './src/rmd/report.Rmd',  # report file template
										params = list(
											fileName = fileName),
										output_format = "html_document",
										output_file =  paste0("report_", newFileName, ".html"),
										output_dir = './reports/')

	
}