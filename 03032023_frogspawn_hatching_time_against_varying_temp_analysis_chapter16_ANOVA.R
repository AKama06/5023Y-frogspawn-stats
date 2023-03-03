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
library(rstatix)
library(performance)
library(emmeans)
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
#________________________----
#LINEAR MODEL ----
frogspawn_ls <- lm(formula = days ~ temperature, data = frogspawn)

#analysis
#anova test
anova(frogspawn_ls)

#linear model summary
broom::tidy(frogspawn_ls, conf.int = T)

#testing assumptions
#check normal distribution
performance::check_model(frogspawn_ls, check=c("normality","qq"))

#check equal variance
performance::check_model(frogspawn_ls, check="homogeneity")

#check outliers
performance::check_model(frogspawn_ls, check="outliers")
#____________________----
#PLOT ----
pal <- c("#4CAF50","#2E7D32","#1B5E20")
frogspawn %>%
  ggplot(aes(temperature,days))+
  geom_boxplot(
               alpha = 0.3, 
               width = 0.5, # change width of boxplot
               show.legend = FALSE)+
  geom_jitter(aes(colour = temperature),
              width=0.2,
              outlier.shape=NA)+
  scale_colour_manual(values = pal)+
  theme_minimal()+
  theme(legend.position = "none")+
  labs(y="Number of days to spawn hatchlings",
       x="Temperature (°C)")
#RESULTS ----
#The frog data illustrated that increasing temperature had a clear effect
#on the number of days to spawn hatchlings (one- way ANOVA, F(2,58)=385.9, p<0.03).
#On average, it took 26.3 days [25.8-26.8 95%CI] for hatchlings to spawn in containers that were 13oC.
#This reduced on average by 5.3 days [4.57-6.03 95%CI] for hatchling spawns in containers at 18oC,
#and reduced by an average of 10.5 days [9.37-10.8 95%CI] hatchlings in containers at 25oC. 


#frogspawn_figure <- emmeans::emmeans(frogspawn_ls, specs = ~ temperature)

#frogspawn_figure

#frogspawn_figure %>% 
#  as_tibble() %>% 
#  ggplot(aes(x=temperature, 
#             y=emmean))+
#  geom_pointrange(aes(
#    ymin=lower.CL, 
#    ymax=upper.CL))+
#  geom_point()+
#  geom_smooth(method = "lm")+
#  labs(y="Number of days to spawn hatchling",
#       x="Temperature (°C)")