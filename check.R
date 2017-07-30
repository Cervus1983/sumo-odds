library(httr)
library(stringr)
library(tidyverse)

try(system("touch last_run", intern = TRUE, ignore.stderr = TRUE))

tmp <- as.tibble(
	str_match_all(
		content(GET("https://www.betmarathon.com/en/betting/Sumo/?menu=954952"), "text"),
		"\"sn\":\"([a-zA-Z]+)\",.+\"epr\":\"([0-9]+\\.[0-9]+)"
	)[[1]][, 2:3]
)

if (nrow(tmp) > 0) write.table(
	cbind(
		tmp[c(TRUE, FALSE), ] %>% rename(rikishi1 = V1, odds1 = V2),
		tmp[c(FALSE, TRUE), ] %>% rename(rikishi2 = V1, odds2 = V2)
	) %>%
	mutate_at(vars(contains("odds")), as.numeric) %>% 
	mutate(ts = format(Sys.time())) %>% 
	filter(complete.cases(.)),
	file = "201707.csv",
	append = TRUE,
	quote = FALSE,
	sep = ",",
	row.names = FALSE,
	col.names = FALSE
)
