library(httr)


source("parser/marathonbet.R")

# live
"https://www.marathonbet.com/en/betting/Sumo/?menu=954952" %>% 
	GET() %>% 
	content("text") %>% 
	parse_marathonbet()

# offline
"sample-html" %>% 
	list.files(pattern = "marathonbet", full.names = TRUE) %>% 
	sapply(parse_marathonbet)



source("parser/1xbet.R")

# live
"https://1xbet.com/en/line/Sumo/" %>% 
	GET() %>% 
	content("text") %>% 
	parse_1xbet()

# offline
"sample-html" %>% 
	list.files(pattern = "1xbet", full.names = TRUE) %>% 
	sapply(parse_1xbet)
