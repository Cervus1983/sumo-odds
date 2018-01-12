# Sumo odds (scraped from Marathonbet)
I was able to find only one bookmaker offering odds on sumo — https://www.betmarathon.com/en/betting/Sumo/?menu=954952 — and took it upon myself to save these odds for further analysis.

### This repository contains
[sample-html/](sample-html) — samples of raw HTML for testing purposes

[betmarathon-parse.R](betmarathon-parse.R) — functions to extract odds & outrights from raw HTML

[job.R](job.R) — script I run during a tournament (every 5 minutes)

[sumo-odds.Rmd](sumo-odds.Rmd) — [flexdashboard](rmarkdown.rstudio.com/flexdashboard/) with a nice visualisation of historical odds ([view](http://ec2-52-58-8-187.eu-central-1.compute.amazonaws.com:3838/sumo-odds/))

##
Excellent online database with sumo results: http://sumodb.sumogames.de
