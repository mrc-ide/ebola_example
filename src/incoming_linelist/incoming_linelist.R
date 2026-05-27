orderly::orderly_description("Example incoming linelist report- no real data")
orderly::orderly_resource("linelist_template_expanded_with_errors_locations.csv") #this is fake data in the style used in the chainchecker app https://shiny.dide.ic.ac.uk/chainchecker/
orderly::orderly_artefact(description="Tidied linelist", files="cleaned_linelist.rds")

# call some packages
library(dplyr)
library(ggplot2)

# reading in the resource file- you may want to use cyphr for this or store the data elsewhere (eg. a protected folder on sharepoint)
ll <- read.csv("linelist_template_expanded_with_errors_locations.csv", stringsAsFactors = FALSE)

# clean the dates
ll <- ll %>% mutate(across(contains("date"), as.Date, tryFormats = c("%d/%m/%Y")))

# Add a quick visual
ll %>% 
  group_by(date_of_onset, location) %>% 
  summarise(count = n()) %>%
  ggplot()+
  aes(x = date_of_onset, y = count, fill = location)+
  geom_col() +
  theme_minimal() # you may spot it looks like there is an error in some of the dates that you may want to fix here 

# save the file
saveRDS(ll, "cleaned_linelist.rds")
