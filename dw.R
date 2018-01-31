library(tidyverse)

# local file with latest odds
file_name <- list.files("odds", pattern = ".+\\.csv$") %>% tail(1)

# upload file to data.world (you'll need your own account)
library(data.world)
set_config(cfg_env(auth_token_var = "DW_API_TOKEN"))

upload_file(
	dataset = paste(Sys.getenv("DW_USER"), "sumo-wrestling-betting-odds", sep = "/"),
	path = paste("odds", file_name, sep = "/"),
	file_name = file_name
)
