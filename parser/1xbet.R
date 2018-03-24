library(rvest)
library(tidyverse)

parse_1xbet <- function(raw_html) {
	columns <- c(
		"gameid",
		"coef",
		"betname",
		"opp1",
		"opp2"
	)
	
	df <- raw_html %>% 
		read_html() %>% 
		html_nodes("a:not(.non).c-bets__bet") %>% 
		html_attrs() %>% 
		map_df(bind_rows) %>% 
		set_names(sub("data-", "", names(.)))
	
	if (
		is.data.frame(df) && df %>% 
			colnames() %>% 
			setdiff(columns, .) %>% 
			length() == 0
	) df %>% 
		select(one_of(columns)) %>% 
		spread(betname, coef) %>% 
		mutate_at(4:5, as.numeric) %>% 
		arrange(gameid)
}
