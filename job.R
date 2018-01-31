# scrape betmarathon.com
library(httr)
raw_html <- content(GET("https://www.betmarathon.com/en/betting/Sumo/?menu=954952"), "text")

# raw HTML <-> odds & outrights
source("betmarathon-parse.R")

# creates new file or appends to existing one
save_to_folder <- function(data, folder) if (!is.null(data)) {
	file_path <- paste0(folder, "/", format(Sys.Date(), "%Y%m"), ".csv")
	
	if (file.exists(file_path)) write_csv(
		data,
		file_path,
		append = TRUE
	) else write_csv(
		data,
		file_path
	)
}

# odds (individual bouts)
if (!dir.exists("odds")) dir.create("odds")

raw_html %>% 
	extract_odds() %>% 
	save_to_folder("odds")

# outrights (tournament winner)
if (!dir.exists("outrights")) dir.create("outrights")

raw_html %>% 
	extract_outrights() %>% 
	save_to_folder("outrights")
