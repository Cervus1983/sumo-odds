library(httr)


# parses raw HTML and returns tibble with odds, if any
source("extract-odds.R")

odds <- extract_odds(
	content(
		GET("https://www.betmarathon.com/en/betting/Sumo/?menu=954952"),
		"text"
	)
)


# append new data to <year><month>.csv
if (!is.null(odds)) write_csv(
	odds,
	path = paste(format(Sys.Date(), "%Y%m"), "csv", sep = "."),
	append = TRUE
)
