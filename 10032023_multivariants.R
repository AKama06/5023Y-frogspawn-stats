#__________________________----
# PACKAGES ----
library(tidyverse)
library(janitor) 
library(lubridate) 
library(here)
library(rstatix)
library(performance)
library(emmeans)
#__________________________----
# IMPORT DATA ----
biomass <- read_csv(here::here("data", "biomass.csv"))
#__________________________----
#CLEAN DATA ----
biomass <- janitor::clean_names(biomass)
colnames(biomass)

glimpse(biomass)

biomass <- rename(biomass,
                  "fertiliser"="fert",
                  "fertiliser_light"="fl",
                  "biomass"="biomass_m2")
colnames(biomass)

#check for NA values
biomass %>%
  is.na() %>%
  sum()

# check for duplication
biomass %>% 
  duplicated() %>% 
  sum()

biomass <-pivot_longer(data = biomass,
                       cols = fertiliser:fertiliser_light,
                       names_to = "status",
                       values_to = "conditions")

