suppressPackageStartupMessages(library(tidyverse))

fileNames <- Sys.glob("./data/*.csv")

for (fileName in fileNames) {
# read data and clean dataframe
trees <- read.csv(fileName, stringsAsFactors = FALSE) %>% 
	select(lon="LONGITUDE",
				 lat="LATITUDE",
				 std_street="STD_STREET",
				 on_street="ON_STREET",
				 neighbourhood="NEIGHBOURHOOD_NAME",
				 height="HEIGHT_RANGE_ID",
				 diameter="DIAMETER",
				 date_planted="DATE_PLANTED",
				 genus="GENUS_NAME",
				 species="SPECIES_NAME",
				 common_name="COMMON_NAME") %>% 
	filter(!(lat==0)) %>% 
	transform(date_planted = as.Date(as.character(date_planted), "%Y%m%d"))
# filter 0 lat values and transform date integer to proper date.

genus_count <- trees %>% 
	group_by(genus) %>%
	summarise(number = n())

newFileName <- paste0("./data/", gsub(".csv", x= basename(fileName), replacement = ".tsv"))

write.table(genus_count, newFileName,
						sep = "\t", row.names = FALSE, quote = FALSE)}
