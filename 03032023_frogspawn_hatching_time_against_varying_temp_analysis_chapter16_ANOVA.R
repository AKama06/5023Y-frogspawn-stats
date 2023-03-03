#___________________________----
# SET UP ----
## A statistical analysis of frogspawn hatching time with varying terperatures of 13°C, 18°C and 25°C. ----

### Newly-layed frogspawn were collected from a pond in the Italian Alps, brought back to the lab, and divided into 60 water containers.20 of the containers’ water temperature was kept to 13°C, 20 containers were kept to 18°C and the remaining 20 containers were kept to 25°C. Water containers were monitored and days until hatching of egg (hatching times) were recorded.  ----

### Hypothesis- mean frogspawn hatching time will vary with temperature level ----
#__________________________----
# PACKAGES ----
library(tidyverse)
library(janitor) 
library(lubridate) 
library(here)
#__________________________----
# IMPORT DATA ----
frogspawn <- read.csv(here("data","frogs_messy_data.csv"))
#__________________________----
#CLEAN DATA ----
frogspawn <- janitor::clean_names(frogspawn)
colnames(frogspawn)
#rename column names
frogspawn <- rename(frogspawn,
                    "id"="frogspawn_sample_id",
                    "13"="temperature13",
                    "18"="temperature18",
                    "25"="temperature25")
# Get a sum of how many observations are missing in our dataframe
frogspawn %>% 
  is.na() %>% 
  sum()
summary(frogspawn)
glimpse(frogspawn)

#pivot table from wider to longer
frogspawn <- pivot_longer(data = frogspawn,
                          cols = "13":"25",
                          names_to = "temperature",
                          names_prefix = "temp",
                          values_to = "days")
frogspawn <- drop_na(frogspawn)
frogspawn
