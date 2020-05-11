library(tidyverse)
library(dplyr)
tests <- read.csv('tests.csv')
census <- read.csv('Census.csv')
popdens <- read.csv('uszips.csv')
housing <- read.csv('Housing.csv')
tests <- tests %>%
  rename(., c('Zipcode' = 'MODZCTA', 'Percent.Population' = 'zcta_cum.perc_pos'))

censusdata <- census %>% 
  mutate(., Percent_College = (Bachelors + Masters + Professional +Doctorate)/TotalEd * 100) %>%
  mutate(., Percent_Public_Transit = Publictrans/Totaltrans * 100) %>%
  select(., 'Area.Name', 'Median.household.income.in.the.past.12.months..in.2017.inflation.adjusted.dollars.', 'Percent_College', Percent_Public_Transit) %>%
  rename(., c('Zipcode' = 'Area.Name','Median.Household.Income'= 'Median.household.income.in.the.past.12.months..in.2017.inflation.adjusted.dollars.'))

censusdata$Zipcode = substr(censusdata$Zipcode, 6, 999)
censusdata$Zipcode = as.numeric(censusdata$Zipcode)

housing <- housing %>%
  mutate(., Percent_Crowded = (Family5 + Family6 + Family7 + NoFamily4 + NoFamily5 + NoFamily6 + NoFamily7)/Total * 100) %>%
  select(., 'Percent_Crowded')
housing$Zipcode = substr(censusdata$Zipcode, 6, 999)
housing$Zipcode = as.numeric(censusdata$Zipcode)

popdens <- popdens %>%
  select(., 'zip', 'density') %>%
  #filter(., city == 'New York' | city == 'Staten Island' | city == 'Bronx') %>%
  rename(., 'Zipcode' = 'zip')

workingdata = inner_join(inner_join(inner_join(tests, censusdata, 'Zipcode'), popdens, 'Zipcode'), housing, 'Zipcode')
write_csv(workingdata, './cleaned_data.csv')
