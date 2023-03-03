#___________________________----
# SET UP ----
## An analysis of frogspawn hatching time with varying terperatures of 13°C, 18°C and 25°C. ----

### Newly-layed frogspawn were collected from a pond in the Italian Alps, brought back to the lab, and divided into 60 water containers.20 of the containers’ water temperature was kept to 13°C, 20 containers were kept to 18°C and the remaining 20 containers were kept to 25°C. Water containers were monitored and days until hatching of egg (hatching times) were recorded.  ------
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
