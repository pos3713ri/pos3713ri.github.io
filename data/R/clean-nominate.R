
# raw: HSall_members.csv
# url: https://voteview.com/data
# accessed: 2018-09-09

# load packages
library(tidyverse)

# read and tidy data
df <- read_csv("data/raw/HSall_members.csv") %>%
  mutate(party = ifelse(party_code == 100, "Democrat",
                        ifelse(party_code == 200, "Republican", NA))) %>% 
  select(congress, chamber, state = state_abbrev, district = district_code, party, name = bioname, ideology = nominate_dim1) %>%
  filter(!is.na(party)) %>%
  filter(congress >= 100) %>%
  filter(chamber == "House") %>%
  mutate(party = fct_reorder(party, ideology)) %>%
  glimpse()
  
# check data look good
ggplot(df, aes(x = ideology, fill = party)) + 
  geom_histogram(position = "identity", alpha = 0.5) + 
  facet_wrap(vars(congress))
  
# export
library(rio)

stem <- "nominate"
ext <- c("csv", "xlsx", "dta", "rds")
for (i in 1:length(ext)) {
  filename <- paste0("data/", stem, ".", ext[i])
  export(df, filename)
}