
# load packages
library(tidyverse)
library(rio)

# read data
df_raw <- haven::read_dta("data/raw/shor+mccarty+1993-2016+individual+legislator+data+May+2018+release+(Updated+July+2018).dta") %>%
  glimpse()
df <- df_raw %>%
  mutate(legislator_id = 1:n()) %>%
  gather(year, in_house, house1993:house2014) %>%
	filter(!is.na(in_house)) %>%
	select(name, legislator_id, party, st, np_score, year) %>%
	rename(state = st, ideology = np_score) %>%
  separate(year, into = c("body", "year"), sep = -4) %>%
  mutate(year = as.numeric(year)) %>%
  glimpse()

export(df, "data/state-legislators.csv")
export(df, "data/state-legislators.rds")
export(df, "data/state-legislators.dta")
export(df, "data/state-legislators.xlsx")




