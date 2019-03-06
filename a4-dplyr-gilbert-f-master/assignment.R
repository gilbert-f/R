# a4-data-wrangling

################################### Set up ###################################

# Install (if not installed) + load dplyr package 
#install.packages('dplyr')
library(dplyr)

# Set your working directory to the appropriate project folder
setwd("~/Desktop/INFO 201/a4-dplyr-gilbert-f/")

# Read in `any_drinking.csv` data using a relative path
any.drinking <- read.csv('data/any_drinking.csv', stringsAsFactors=FALSE)

# Read in `binge.drinking.csv` data using a relative path
binge.drinking <- read.csv('data/binge_drinking.csv', stringsAsFactors=FALSE)

# Create a directory (using R) called "output" in your project directory
# Make sure to suppress any warnings, in case the directory already exists
dir.create('output', showWarnings = FALSE)

################################### Any drinking in 2012 ###################################

# For this first section, you will work only with the *any drinking* dataset.
# In particular, we'll focus on data from 2012, keeping track of the `state` and `location` variables

# Create a data.frame that has the `state` and `location` columns, and all columns with data from 2012
any.drinking.2012 <- select(any.drinking, state, location, contains('_2012'))

# Using the 2012 data, create a column that has the difference in male and female drinking patterns
any.drinking.2012 <- mutate(any.drinking.2012, difference_2012 = males_2012 - females_2012)

# Write your 2012 data to a .csv file in your `output/` directory with an expressive filename
# Make sure to exclude rownames
write.csv(any.drinking.2012, 'output/any_drinking_2012_with_difference.csv', row.names = FALSE)

# Are there any locations where females drink more than males?
## Your answer should be a *dataframe* of the locations, states, and differences for all locations (no extra
## columns)
# A) none
locations.females.drink.more.any <- filter(any.drinking.2012, difference_2012 < 0) %>% 
  select(location, state, difference_2012)

## What is the location in which male and female drinking rates are most similar (*absolute* difference is
## smallest)?
## Your answer should be a *dataframe* of the location, state, and value of interest (no extra
## columns)
# A) Oneida County, Wisconsin, 0.8
location.drinking.most.similar.any <- filter(any.drinking.2012, difference_2012 == min(abs(difference_2012))) %>% 
  select(location, state, difference_2012)

## As you've (hopefully) noticed, the `location` column includes national, state, and county level
## estimates.
## However, many audiences may only be interested in the *state* level data. Given that, you
## should do the following:
# Create a new variable that is only the state level observations in 2012
# For the sake of this analysis, you should treat Washington D.C. as a *state*
any.drinking.state.2012 <- filter(any.drinking.2012, location == state)

# Which state had the **highest** drinking rate for both sexes combined? 
# Your answer should be a *dataframe* of the state and value of interest (no extra columns)
# A) Vermont, 68.4
state.highest.both.2012.any <- filter(any.drinking.state.2012, both_sexes_2012 == max(both_sexes_2012)) %>%
  select(state, both_sexes_2012)

# Which state had the **lowest** drinking rate for both sexes combined?
# Your answer should be a *dataframe* of the state and value of interest (no extra columns)
# A) Utah, 28.2
state.lowest.both.2012.any <- filter(any.drinking.state.2012, both_sexes_2012 == min(both_sexes_2012)) %>%
  select(state, both_sexes_2012)

## What was the difference in (any-drinking) prevalence between the state with the highest level of
## consumption,
# and the state with the lowest level of consumption?
# Your answer should be a single value (a dataframe storing one value is fine)
# A) 50.2
difference.max.min.2012.any <- summarise(any.drinking.state.2012, difference = max(both_sexes_2012, females_2012, males_2012)) - 
  summarise(any.drinking.state.2012, difference = min(both_sexes_2012, females_2012, males_2012))

# Write your 2012 state data to an appropriately named file in your `output/` directory
# Make sure to exclude rownames
write.csv(any.drinking.state.2012, 'output/any.drinking.state.2012.csv', row.names = FALSE)

## Write a function that allows you to specify a state, then saves a .csv file with only observations from
## that state
# This includes data about the state itself, as well as the counties within the state
# You should use the entire any.drinking dataset for this function
# The file you save in the `output` directory indicates the state name
# Make sure to exclude rownames
specifyState <- function(stateName) {
  state.df <- filter(any.drinking, state == stateName) 
  write.csv(state.df, paste0('output/', stateName, '.csv'), row.names = FALSE)
}

# Demonstrate your function works by passing 3 states of your choice to the function
specifyState('Washington')
specifyState('Alabama')
specifyState('Michigan')

################################### Binge drinking Dataset ###################################
# In this section, we'll ask a variety of questions regarding our binge.drinking dataset
# Moreover, we'll be looking at a subset of the observations which is just the counties 
# (i.e., exclude state/national estimates)
# In order to ask these questions, you'll need to first prepare a subset of the data for this section:

# Create a dataframe with only the county level observations from the binge_driking dataset 
# You should (again) think of Washington D.C. as a state, and therefore *exclude it here*
# This does include "county-like" areas such as parishes and boroughs
binge.drinking.counties <- filter(binge.drinking, location != state, location != 'United States')

# What is the average level of binge drinking in 2012 for both sexes (across the counties)?
# A) 17.96036
mean.both.2012.binge <- summarise(binge.drinking.counties, mean_both_sexes_2012 = mean(both_sexes_2012))

# What is the *minimum* level of binge drinking in each state in 2012 for both sexes (across the counties)? 
## Your answer should contain roughly 50 values (one for each state), unless there are two counties in a
## state with the same value
# Your answer should be a *dataframe* with the 2012 binge drinking rate, location, and state
min.state.2012.binge <- group_by(binge.drinking.counties, state) %>%
  filter(both_sexes_2012 == min(both_sexes_2012)) %>%
  select(both_sexes_2012, location, state)

# What is the *maximum* level of binge drinking in each state in 2012 for both sexes (across the counties)? 
# Your answer should be a *dataframe* with the value of interest, location, and state
max.state.2012.binge <- group_by(binge.drinking.counties, state) %>%
  filter(both_sexes_2012 == max(both_sexes_2012)) %>%
  select(both_sexes_2012, location, state)

# What is the county with the largest increase in male binge drinking between 2002 and 2012?
# Your answer should include the county, state, and value of interest
# A) Loving County, Texas, 14.9
county.max.increase.male.2002.2012.binge <- mutate(binge.drinking.counties, difference = males_2012-males_2002) %>%
  filter(difference == max(difference)) %>%
  select(location, state, difference)

# How many counties experienced an increase in male binge drinking between 2002 and 2012?
# Your answer should be an integer (a dataframe with only one value is fine)
# A) 1992
county.increase.male.2002.2012.binge <- mutate(binge.drinking.counties, difference = males_2012-males_2002) %>%
  filter(difference > 0) %>%
  summarise(n())

# What percentage of counties experienced an increase in male binge drinking between 2002 and 2012?
# Your answer should be a fraction or percent (we're not picky)
# A) 63.72361
percent.county.increase.male.2002.2012.binge <- mutate(binge.drinking.counties, difference = males_2012-males_2002) %>%
  filter(difference > 0) %>%
  summarise(n()/count(binge.drinking.counties)*100)

# How many counties observed an increase in female binge drinking in this time period?
# Your answer should be an integer (a dataframe with only one value is fine)
# A) 2580
county.increase.female.2002.2012.binge <- mutate(binge.drinking.counties, difference = females_2012-females_2002) %>%
  filter(difference > 0) %>%
  summarise(n())

# What percentage of counties experienced an increase in male binge drinking between 2002 and 2012?
# Your answer should be a fraction or percent (we're not picky)
# A) 63.72361
percent.county.increase.male.2002.2012.binge <- mutate(binge.drinking.counties, difference = males_2012-males_2002) %>%
  filter(difference > 0) %>%
  summarise(n()/count(binge.drinking.counties)*100)

# How many counties experienced a rise in female binge drinking *and* a decline in male binge drinking?
# Your answer should be an integer (a dataframe with only one value is fine)
# A) 786
counties.rise.female.decline.male.2002.2012.binge <- mutate(binge.drinking.counties, difference_females_2012 = females_2012-females_2002, 
       difference_males_2012 = males_2012-males_2002) %>%
  filter(difference_females_2012 > 0 & difference_males_2012 < 0) %>%
  summarise(n())

################################### Joining Data ###################################
## You'll often have to join different datasets together in order to ask more involved questions of your
## dataset.
# In order to join our datasets together, you'll have to rename their columns to differentiate them

# First, rename all prevalence columns in the any.drinking dataset to the have prefix "any."
## Hint: you can get (and set!) column names using the colnames function. This may take multiple lines of
## code.
for (i in 3:35) {
  colnames(any.drinking)[i] <- paste0('any.', colnames(any.drinking[i]))
}

# Then, rename all prevalence columns in the binge.drinking dataset to the have prefix "binge."
## Hint: you can get (and set!) column names using the colnames function. This may take multiple lines of
## code.
for (i in 3:35) {
  colnames(binge.drinking)[i] <- paste0('binge.', colnames(binge.drinking[i]))
}

# Then, create a dataframe with all of the columns from both datasets. 
# Think carefully about the *type* of join you want to do, and what the *identifying columns* are
any.binge.join <- inner_join(any.drinking, binge.drinking, by = c("state", "location"))

# Create a column of difference between `any` and `binge` drinking for both sexes in 2012
any.binge.join <- mutate(any.binge.join, difference_any_binge_both_sexes_2012 = 
                           any.both_sexes_2012-binge.both_sexes_2012)

# Which location has the greatest *absolute* difference between `any` and `binge` drinking?
# Your answer should be a one row data frame with the state, location, and value of interest (difference)
# A) Virginia Falls, Church City, 53.1
max.difference.any.binge.2012 <- filter(any.binge.join, difference_any_binge_both_sexes_2012 == max(abs(difference_any_binge_both_sexes_2012))) %>%
  select(state, location, difference_any_binge_both_sexes_2012)

# Which location has the smallest *absolute* difference between `any` and `binge` drinking?
# Your answer should be a one row data frame with the state, location, and value of interest (difference)
# A) South Dakota, Buffalo County, 3.7
min.difference.any.binge.2012 <- filter(any.binge.join, difference_any_binge_both_sexes_2012 == min(abs(difference_any_binge_both_sexes_2012))) %>%
  select(state, location, difference_any_binge_both_sexes_2012)

################################### Write a function to ask your own question(s) ###################################
## Even in an entry level data analyst role, people are expected to come up with their own questions of
## interest
# (not just answer the questions that other people have). For this section, you should *write a function*
# that allows you to ask the same question on different subsets of data. 
# For example, you may want to ask about the highest/lowest drinking level given a state or year. 
# The purpose of your function should be evident given the input parameters and function name. 
## After writing your function, *demonstrate* that the function works by passing in different parameters to
## your function.

## Write a function that allows you to specify a year, then shows only observations from
## that year
# This includes data about any and binge drinking.
specifyYear <- function(yearName) {
  year.df <- select(any.binge.join, -difference_any_binge_both_sexes_2012) %>%
    select(state, location, contains(as.character(yearName)))
  return (year.df)
}

specifyYear(2012)
specifyYear('2003')

################################### Challenge ###################################

# Using your function from part 1 (that wrote a .csv file given a state name), write a separate file 
# for each of the 51 states (including Washington D.C.)
# The challenge is to do this in a *single line of (concise) code*
for (var in any.drinking.state.2012$state) specifyState(var)

## Using a dataframe of your choice from above, write a function that allows you to specify a *year* and
## *state* of interest,
# that saves a .csv file with observations from that state's counties (and the state itself) 
# It should only write the columns `state`, `location`, and data from the specified year. 
# Before writing the .csv file, you should *sort* the data.frame in descending order
# by the both_sexes drinking rate in the specified year. 
# Again, make sure the file you save in the output directory indicates the year and state. 
# Note, this will force you to confront how dplyr uses *non-standard evaluation*
# Hint: https://cran.r-project.org/web/packages/dplyr/vignettes/nse.html
# Make sure to exclude rownames

specifyStateYear <- function(stateName, yearName) {
  yearName <- as.character(yearName)
  stateYear.df <- filter(any.drinking, state == stateName) %>%
    select(state, location, contains(yearName)) %>%
    arrange_(paste0('desc(any.both_sexes_', yearName, ')'))
  write.csv(stateYear.df, paste0('output/', stateName, yearName, '.csv'), row.names = FALSE)
}

# Demonstrate that your function works by passing a year and state of your interest to the function
specifyStateYear('Alabama', 2012)
specifyStateYear('Washington', '2003')
