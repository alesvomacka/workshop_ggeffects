# Data and packages -------------------------------------------------------
library(tidyverse)

ess = read_rds("data/ESS8CZ.rds")

# Data preparation --------------------------------------------------------
ess = ess %>% mutate(vote = na_if(vote, "Not eligible to vote"),
                     vote = droplevels(vote),
                     vote = relevel(vote, ref = "No"),
                     education = fct_collapse(edlvdcz,
                                              `Základní` = levels(ess$edlvdcz)[1:3],
                                              `Střední bez M`  = levels(ess$edlvdcz)[4:5],
                                              `Střední s M` = levels(ess$edlvdcz)[6:9],
                                              `Vysokoškolské` = levels(ess$edlvdcz)[10:12]),
                     age = as.numeric(as.character(agea)),
                     happy_int = as.numeric(happy) - 1)


# Data export -------------------------------------------------------------
write_rds(ess, file = "data/ess_cleaned.rds")
