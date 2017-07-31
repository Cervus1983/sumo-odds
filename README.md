# Sumo odds (scraped from Marathonbet)
I was able to find only one bookmaker offering odds on sumo — https://www.betmarathon.com/en/betting/Sumo/?menu=954952 — and took it upon myself to save these odds for further analysis.

## This repository contains
[csv/](csv) — odds I've extracted so far:
- 201705.csv (2017 May tournament, odds scraped every 60 minutes)
- 201707.csv (2017 July tournament, odds scraped every 15 minutes)

[sample-html/](sample-html) — samples of raw HTML for testing purposes

[extract-odds.R](extract-odds.R) — function to extract odds from raw HTML

[job.R](job.R) — script I run during a tournament (cron job)

[sumo-odds.Rmd](sumo-odds.Rmd) — [flexdashboard](rmarkdown.rstudio.com/flexdashboard/) with a nice visualisation of historical odds.

##
Excellent online database with sumo results: http://sumodb.sumogames.de
