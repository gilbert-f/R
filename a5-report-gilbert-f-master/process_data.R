### This file contains your main code.
### Feel free to rename it, or use several files instead.
### It should contain the code along the following lines:

#install.packages('eeptools')
library(jsonlite)
library(httr)
library(dplyr)
library(ggplot2)
library(eeptools)

key <- readLines("~/Desktop/INFO 201/a5-report-gilbert-f/keys.R")
google.key <- gsub('"', '',gsub('^.*?"', '', key[1]))
propublica.key <- gsub('"', '',gsub('^.*?"', '', key[2]))

## 1. create the google civic platform request and httr::GET() the result
##    you need to include your api key in the request
## 2. extract the elected officials' data from the result
uri <- "https://www.googleapis.com/civicinfo/v2/representatives"
query.params <- list(key = google.key, 
                     address="San Franciso CA")

google.response <- GET(uri, query=query.params)
google.body <- fromJSON(content(google.response, "text"))

## 3. transform the data into a well formatted table
electedOffices <- c(google.body$offices$name[1:3], 
                    google.body$offices$name[3], 
                    google.body$offices$name[4:19])

electedOfficials <- mutate(google.body$officials, 
                           photoUrl = ifelse(is.na(photoUrl), '-', paste0('![](', photoUrl,')')), 
                           emails = ifelse(emails == 'NULL', '-', emails), 
                           electedOffices, 
                           name = paste0("[", name, "](", urls, ")")) 

## 4. Get state representatives from propublica API
##    you need the respective API key.
propublica.response <- GET("https://api.propublica.org/congress/v1/115/house/members.json", 
              add_headers('X-API-Key' = propublica.key))
propublica.body <- fromJSON(content(propublica.response, "text"))

## 5. transform it in a form you can use for visualizations
stateRepresentatives <- filter(as.data.frame(propublica.body$results$members), state == 'CA')

repTable <- mutate(stateRepresentatives, Name = paste(first_name, last_name)) %>%
  select(Name, DOB = date_of_birth, Party = party, Seniority = seniority, URL = url, 
         Phone = phone, District = district)

party.df <- group_by(repTable, Party) %>%
  count()

seniority.df <- mutate(repTable, Seniority = as.numeric(Seniority)) %>%
  group_by(Seniority) %>%
  count()

## 6. pick a representative.
linda <- filter(stateRepresentatives, first_name == 'Linda')

## 7. get this representative's info
linda.age <- floor(age_calc(as.Date(linda$date_of_birth), as.Date(Sys.Date()),
                            units = "years"))
linda.party <- ifelse(linda$party == 'D', 'Democratic','Republican')

## 8. get her recent votes.
rep.response <- GET("https://api.propublica.org/congress/v1/members/S001156/votes.json",
                     add_headers('X-API-Key' = propublica.key))

rep.body <- data.frame(fromJSON(content(rep.response, "text"))$results$votes)
rep.body <- data.frame(rep.body$position, rep.body$result)
majority.pct <- (filter(rep.body, (rep.body.position == 'Yes' & rep.body.result == 'Passed') | 
                         (rep.body.position == 'No' & rep.body.result == 'Failed')) %>%
                count()) * 100 / 20
