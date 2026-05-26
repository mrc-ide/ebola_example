orderly::orderly_description("Example incoming linelist report- no real data")
orderly::orderly_resource("linelist_template.csv") #this is taken from the chainchecker app https://shiny.dide.ic.ac.uk/chainchecker/
orderly::orderly_artefact(description="Tidied linelist", files="cleaned_linelist.rds")

# call some packages
library(dplyr)

# reading in the resource file- you may want to use cyphr for this or store the data elsewhere (eg. a protected folder on sharepoint)
ll <- read.csv("linelist_template.csv", stringsAsFactors = FALSE)

# clean the dates
ll <- ll %>% mutate(across(contains("date"), as.Date, tryFormats = c("%d/%m/%Y")))

# save the file
saveRDS(ll, "cleaned_linelist.rds")
