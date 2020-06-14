library(tidyverse)
library(rvest)

## Webscraping Florida County Demographics data

url <- "https://www.florida-demographics.com/counties_by_population"
h <- read_html(url)
tab <- h %>% html_nodes("table")
tab <- tab[[2]]
tab <- tab %>% html_table
FloridaDemographics <- as.data.frame(tab)

library(maps)
library(ggmap)
library(mapdata)
library(devtools)

install_github('arilamstein/choroplethrZip@v1.4.0')
