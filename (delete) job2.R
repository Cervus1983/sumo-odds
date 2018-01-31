library(tidyverse)

# files on data.world (you'll need your own account)
library(data.world)
set_config(cfg_env(auth_token_var = "DW_API_TOKEN"))

dataset <- paste(Sys.getenv("DW_USER"), "sumo-wrestling-betting-odds", sep = "/")
file_names <- map_chr(get_dataset(dataset)$files, "name")

# scrape betmarathon.com
library(httr)
raw_html <- content(GET("https://www.betmarathon.com/en/betting/Sumo/?menu=954952"), "text")

# raw HTML -> odds
source("betmarathon-parse.R")
new_odds <- extract_odds(raw_html)

# create/append file on data.world
if (is.data.frame(new_odds) && nrow(new_odds) > 0) {
	file_name <- paste(format(Sys.Date(), "%Y.%m"), "csv", sep = ".")
	
	if (file_name %in% file_names) new_odds <- rbind(
		download_file_as_data_frame(dataset, file_name),
		new_odds
	)

	upload_data_frame(
		dataset = dataset,
		data_frame = new_odds,
		file_name = file_name
	)
}
