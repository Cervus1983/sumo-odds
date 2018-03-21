library(jsonlite)
library(rvest)
library(tidyverse)

parse_marathonbet <- function(raw_html) {
	df <- raw_html %>% 
		read_html() %>% 
		html_nodes("td.price") %>% 
		html_attr("data-sel") %>% 
		lapply(function(x) fromJSON(x)[c("sn", "epr")])	%>% 
		map_df(bind_rows)
	
	if (is.data.frame(df) && nrow(df) > 0 && nrow(df) %% 2 == 0) cbind(
		df[c(TRUE, FALSE), 1:2],
		df[c(FALSE, TRUE), 2:1]
	) %>% 
		set_names(c("rikishi1", "odds1", "odds2", "rikishi2")) %>% 
		mutate_at(vars(contains("odds")), as.numeric) %>% 
		as_tibble()
}
