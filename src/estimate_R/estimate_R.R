orderly::orderly_dependency("incoming_linelist", "latest", "cleaned_linelist.rds")
orderly::orderly_artefact(description = "EpiEstim output", "epiestim.rds")
orderly::orderly_artefact(description = "EpiEstim figure", "epiestim.png")

library(dplyr)
library(ggplot2)
library(EpiEstim)

ll <- readRDS("cleaned_linelist.rds")

incid <- ll %>% group_by(date_of_onset) %>% summarise(I = n()) %>% rename(dates=date_of_onset) %>% arrange(dates)
incid <- incid %>% filter(dates>as.Date("2026-05-01")) #let's say you know for certain there were no cases before May '26

dt <- 1
mean_si <- 6.3 # vaguely inspired by https://www.nature.com/articles/sdata201519
std_si <- 1
method <- "parametric_si"
config <- EpiEstim::make_config(list(mean_si = mean_si,
                                     std_si = std_si))

output <- EpiEstim::estimate_R(incid = incid,
                               dt = dt,
                               recon_opt = "match",
                               method = method,
                               config = config)

p <- plot(output)
ggsave(p, filename="epiestim.png")

saveRDS(output, "epiestim.rds")
