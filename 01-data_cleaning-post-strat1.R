#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [https://usa.ipums.org/usa/]
# Author: "Jingjie Zhang, Naifeng Zhang, Jiaxin Cheng, Yipeng Yin"
# Data: 22 October 2020
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data.
setwd("C:/Users/dongc/OneDrive/Desktop/ps3")
raw_data <- read_dta("usa_00003.dta")


# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_data <- 
  raw_data %>% 
  select(region,
         statefip,
         sex, 
         age,
         race, 
         hispan,
         marst, 
         bpl,
         citizen,
         educd,
         labforce)
         

#### What's next? ####

## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)

reduced_data <- 
  reduced_data %>%
  count(age, sex) %>%
  group_by(age, sex) 

reduced_data <- 
  reduced_data %>% 
  filter(age != "less than 1 year old") %>%
  filter(age != "90 (90+ in 1980 and 1990)")

reduced_data$age <- as.integer(reduced_data$age)

# Saving the census data as a csv file in my
# working directory
write_csv(reduced_data, "census_data.csv")



         