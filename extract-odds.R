library(rvest)
library(stringr)
library(tidyverse)


# parses raw HTML and returns tibble with odds, if any
extract_odds <- function(raw_html) {
	tmp <- raw_html %>% 
		str_match_all(., "\"sn\":\"([a-zA-Z]+)\",.+\"epr\":\"([0-9]+\\.[0-9]+)") %>% 
		.[[1]] %>% 
		.[, 2:3] %>% 
		as.tibble()
	
	if (nrow(tmp) > 0) cbind(
		tmp[c(TRUE, FALSE), ] %>% rename(rikishi1 = V1, odds1 = V2),
		tmp[c(FALSE, TRUE), ] %>% rename(rikishi2 = V1, odds2 = V2)
	) %>%
		mutate_at(vars(contains("odds")), as.numeric) %>% 
		mutate(ts = format(Sys.time())) %>% 
		filter(complete.cases(.))
}


# parses raw HTML and returns tibble with outrights, if any
extract_outrights <- function(raw_html) {
	tmp <- raw_html %>% 
		read_html() %>% 
		html_node("table.outright-table") %>% 
		html_table()
	
	if (ncol(tmp) %% 2 == 0 & nrow(tmp) > 0) {
		# multiple Name/Price columns
		if (ncol(tmp) > 2) {
			do.call(
				rbind,
				lapply(
					1:(ncol(tmp) / 2),
					function(x) tmp[, (x * 2 - 1):(x * 2)]
				)
			)
		} else tmp
	}
}


# example: no odds found (e.g. no ongoing tournament)
extract_odds(readRDS("sample-html/sample-html-empty.rds"))


# example: odds found
extract_odds(readRDS("sample-html/sample-html-with-odds.rds"))
