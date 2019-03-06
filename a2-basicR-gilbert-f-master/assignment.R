# a2-foundational-skills


# -------------------- Set up and Defining variables --------------------

# Install and load the the `stringr` package, which has a variety of built in functions that make working
# with string variables easier.
install.packages("stringr", repos='http://cran.us.r-project.org')
library("stringr")

# Create a numeric variable `my_age` that is equal to your age
my_age <- 19

# Create a variable `my_name` that is equal to your first name
my_name <- "Gilbert"

# Using multiplication, create a variable `minutes_in_day` that is equal to the number of minutes in a day
minutes_in_day <- 60 * 24

# Using multiplication, create a variable `hours_in_year` that is the number of hours in a year
hours_in_year <- 24 * 365

# Create a variable `minutes_rule` that is a boolean value (TRUE/FALSE) by logical operations
# It should be TRUE if there are more minutes in a day than hours in a year, otherwise FALSE
minutes_rule <- minutes_in_day > hours_in_year

### Compute and print the following a bit useful numbers.
### Assign the result to a suitably named variable.
### 
### How many seconds are there in year?
cat(60 * 60 * 24 * 365)
seconds_in_year <- 60 * 60 * 24 * 365

### How many seconds is a typical human lifetime?
cat(60 * 60 * 24 * 365 * 79)
seconds_in_lifetime <- 60 * 60 * 24 * 365 * 79

### Age of the universe is 13.8 billion years.  What is it's age in seconds?
cat(60 * 60 * 24 * 365 * 13.8 * 10^9)
age_of_universe <- 60 * 60 * 24 * 365 * 13.8 * 10^9


### -------------------- Working with functions --------------------

# Write a function called `makeIntroduction` that takes in two arguments: name, and age. 
## This function should return a string value that says something like "Hello, my name is {name}, and I'm
## {age} years old".
makeIntroduction <- function(name, age) {
  return (str_c("Hello, my name is ", name, ", and I'm ", age, " years old."))
}

# Create a variable `my_intro` by passing your variables `my_name` and `my_age` into your `makeIntroduction`
# function
my_intro <- makeIntroduction(my_name, my_age)

# Create a variable `casual_intro` by substituting "Hello, my name is ", with "Hey, I'm" in your `my_intro`
# variable
casual_intro <- str_replace(my_intro, "Hello, my name is ", "Hey, I'm ")

# Create a new variable `loud_intro`, which is your `my_intro` variable in all upper-case letters
loud_intro <- str_to_upper(my_intro)

# Create a new variable `quiet_intro`, which is your `my_intro` variable in all lower-case letters
quiet_intro <- str_to_lower(my_intro)

# Create a new variable capitalized, which is your `my_intro` variable with each word capitalized 
# hint: consult the stringr function `str_to_title`
capitalized <- str_to_title(my_intro)

## Using the `str_count` function, create a variable `occurrences` that stores the # of times the letter "e"
## appears in `my_intro`
occurrences <- str_count(my_intro, "e")

# Write another function `Double` that takes in a (numeric) variable and returns that variable times two
Double <- function(var) {
  return (var * 2)
}

## Using your `Double` function, create a variable `minutes_in_two_days`, which is the number of minutes in
## two days
minutes_in_two_days <- Double(minutes_in_day)

# Write another function `ThirdPower` that takes in a value and returns that value cubed
ThirdPower <- function(var) {
  return (var ^ 3)
}

# Create a variable `twenty_seven`` by passing the number 3 to your `ThirdPower` function
twenty_seven <- ThirdPower(3)

# Vectors ----------------------------------------------------------------------

# Create a vector `movies` that contains the names of six movies you like
movies <- c("Ironman", "Superman", "Aliens", "Predator", "I.T.", "Superbad")

# Create a vector `top_three` that only contains the first three movies in the vector
top_three <- movies[c(1:3)]

# Using your vector and the paste method, create a vector `excited` that adds the phrase -
# " is a great movie!" to the end of each element in your movies vector
excited <- paste(movies, "is a great movie!")

# Create a vector `without_four` that has your first three movies, and your 5th and 6th movies.
without_four <- movies[-4]

# Create a vector `numbers` that is the numbers 700 through 999
numbers <- 700:999

## Using the built in length function, create a variable `len` that is equal to the length of your vector
## `numbers`
len <- length(numbers)

# Using the `mean` function, create a variable `numbers_mean` that is the mean of your vector `numbers`
numbers_mean <- mean(numbers)

# Using the `median` function, create a variable `numbers_median` that is the mean of your vector `numbers`
numbers_median <- median(numbers)

# Create a vector `lower_numbers` that is the numbers 500:699
lower_numbers <- seq(500, 699)

# Create a vector `all_numbers` that combines your `lower_numbers` and `numbers` vectors
all_numbers <- c(lower_numbers, numbers)

### -------------------- Dates --------------------

# Use the `as.Date()` function to create a variable `today` that represents today's date
# You can pass in a character string of the day you wrote this, or you can get the current date
# Hint: https://www.rdocumentation.org/packages/base/versions/3.3.2/topics/Sys.time
today <- as.Date(Sys.Date())

# Create a variable `winter_break` that represents the first day of Winter break (December 15, 2017). 
# Make sure to use the `as.Date` function again
winter_break <- as.Date("2017-12-15")

# Create a variable `days_to_break` that is how many days until break (hint: subtract the dates!)
days_to_break <- winter_break - today;

# Define a function called `MakeBirthdayIntro` that takes in three arguments: 
# a name, an age, and a character string for your next (upcoming) birthday.
# This method should return a character string of the format:
#  "Hello, my name is {name} and I'm {age} years old. In {N} days I'll be {new_age}" 
## You should utilize your `MakeIntroduction()` function from Part 1, and compute {N} and {new_age} in your
## function
MakeBirthdayIntro <- function(name, age, date) {
  return (str_c(makeIntroduction(name, age), " In ", date - today, " days I'll be ", age + 1))
}

## Create a variable `my_bday_intro` using the `MakeBirthdayIntro` function, passing in `my_name`, `my_age`,
## and your upcoming birthday.
my_bday_intro <- MakeBirthdayIntro(my_name, my_age, as.Date("2018-02-01"))

## Note: you may look up 'lubridate' package by Hadley Wickham for more convenient handling of dates


### -------------------- Challenge --------------------
## Write a function `RemoveDigits` that will remove all digits (i.e., 0 through 9) from all elements in a
## *vector of strings*.
RemoveDigits <- function(strings) {
  return (gsub('[[:digit:]]+', '', strings))
}

# Demonstrate that your approach is successful by passing a vector of courses to your function
# For example, RemoveDigits(c("INFO 201", "CSE 142"))
remove_digits <- RemoveDigits(c("INFO 201", "CSE 142"))

# Write an if/else statement that checks to see if your vector has any digits. If it does have digits, print 
# "Oh no!", if it does not then print "Yay!"
for (i in 0:9) {
  if (str_detect(remove_digits[1], as.character(i)) | str_detect(remove_digits[2], as.character(i))) {
    cat("Oh no!", "\n")
    break
  } else {
    if (i == 9) {
      cat("Yay!", "\n")
    }
  }
}
