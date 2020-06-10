library(tidyverse)
library(rvest)

## Webscraping the Florida Demographics data

url <- "https://www.florida-demographics.com/counties_by_population"
h <- read_html(url)
tab <- h %>% html_nodes("table")
tab <- tab %>% html_table
FloridaDemographics <- as.data.frame(tab)

## Converting character columns to numeric

FloridaDemographics$Rank <- as.numeric(FloridaDemographics$Rank)
FloridaDemographics$Population <- parse_number(FloridaDemographics$Population)

## Removing the last row because it is needless text

FloridaDemographics <- FloridaDemographics[-c(68),]

library(maps)
library(ggmap)
library(mapdata)

## Getting the Florida Longitude and Latitude data
states <- map_data("state")
FL_df <- subset(states, region == "florida")
counties <- map_data("county")
FL_counties <- subset(counties, region == "florida")

## Merging the Long and Lat data with the demographics

Florida_merged <- inner_join(FloridaDemographics, FL_counties, by = "County")

## Looking at the data, it appears Miami-Dade County did not merge. The Fl_counties data was "Miami-dade County"
## while the FloridaDemographics was "Miami-Dade County"

## Let me see if there are any other Counties that did not merged. I can check this by looking at the "Rank"
## variable in the new merged data.

unique(Florida_merged$Rank)

## Counties with Ranks 21, 24, and 48 were also not merged.






