# Data and packages -------------------------------------------------------
library(ordinal)
library(tidyverse)
library(ggeffects)

ess = read_rds("data/ess_cleaned.rds")

# Most simple case --------------------------------------------------------

mod1 = glm(vote ~ age, family = "binomial", data = ess)

ggpredict(mod1) #returns list of data frames, with data frame for each predictor

plot(ggpredict(mod1)) #plots marginal effect


# Specifying terms --------------------------------------------------------
ggpredict(mod1, terms = "age") #Specify, which predictor to use (also, returns a data frame!)

ggpredict(mod1, terms = "age") %>% 
  ggplot(aes(x = x, y = predicted)) +
  geom_line(size = 2, color = "tomato") +
  labs(x = "Věk", y = "% účasti v posledních parlamentních volbách") #more control for the plot design

# Multiple predictors -----------------------------------------------------
mod2 = glm(vote ~ poly(age, degree = 2)*education, family = "binomial" ,data = ess[!is.na(ess$age), ]) #from the presentation

plot(ggpredict(mod2)) #basic individual plots

plot(ggpredict(mod2, terms = c("age", "education"))) #multiple predictors in one plot

# Terms arguments ---------------------------------------------------------

plot(ggpredict(mod2, terms = c("age [25,55,75]", "education"))) #for which x values should the function be evaluated?

plot(ggpredict(mod2, terms = c("age [all]", "education"))) #evaluate for all values (recommended for numeric predictors)

# Last example - ordinal regression ---------------------------------------

mod_ordinal = clm(sclmeet ~ age + education, data = ess) #How often socially meet with friends, family or colleagues

plot(ggpredict(mod_ordinal, terms = c("age [all]", "education"))) #we lost factor labels

ord = ggpredict(mod_ordinal, terms = c("age [all]", "education"))
ord$response.level = as.factor(ord$response.level)
levels(ord$response.level) = levels(ess$sclmeet)

plot(ord) #factor labels are back


