suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(forcats))

fileNames <- Sys.glob("./data/*.tsv")

for (fileName in fileNames) {
# read TSV
tree_genus <- read.table(file = fileName, sep = '\t', header = TRUE)

# make plot
plot <- tree_genus %>%
	filter(number>100) %>% # only show genus ofer count 100
	ggplot(aes(x = number, y = fct_reorder(genus, number))) +
	geom_point(color="darkgreen",) + 
	xlab("count") +
	scale_x_log10() +
	scale_y_discrete() +
	ylab("tree genus") +
	labs(title = paste("Maximum count of tree genus in",
										 gsub(".tsv", gsub("StreetTrees_", x= basename(fileName), replacement = ""),
										 		 replacement = ""))) +
	theme_minimal()

newFileName <- paste0("./images/", gsub(".tsv", x= basename(fileName), replacement = ".png"))

# save image
ggsave(newFileName, plot = plot, device = "png")}