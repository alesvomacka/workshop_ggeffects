# Setup -------------------------------------------------------------------
ess = read_rds(url("https://github.com/alesvomacka/workshop_ggeffects/blob/master/data/ess_cleaned.rds?raw=true")) #ESS, 8. wave for Czechia (cleaned)
install.packages("ggeffects")
library(ggeffects)

# Úkoly -------------------------------------------------------------------

#1 Vytvorte si linearni model predikujici celkovou spokojenost (happy_int) se zivotem pomoci dosazeneho vzdelani (education).

mod1 = lm(happy_int ~ education, data = ess)

#2 vytvorte si graf marginalnich efektu pro vytvoreny model (kombinaci funkci ggpredict a plot).

plot(ggpredict(mod1))

#3) Pridejte do modelu promennou vek (age) a vytvorte graf marginalnich efektu pro kazdy prediktor zvlast.
#   Interpretujte.

mod2 = lm(happy_int ~ education + age, data = ess)

plot(ggpredict(mod2))

#4) Vytvorte graf marginalnich efektu, ktery bude obsahovat oba prediktory najednou (pomoci argumentu terms).

plot(ggpredict(mod2, terms = c("age", "education")))
