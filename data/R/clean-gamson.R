
# raw: warwick-druckman-2006.dta
# I honestly don't remember where these data came from,
#   but I do remember them being difficult to track down.

# load packages
library(tidyverse)
library(haven)

# read and tidy data
df <- read_dta("data/raw/warwick-druckman-2006.dta") %>%
  select(seat_share = ptyprop, 
         portfolio_share = ppunwtd) %>%
  glimpse()

# export
stem <- "gamson"
ext <- c("csv", "xlsx", "dta", "rds")
for (i in 1:length(ext)) {
  filename <- paste0("data/", stem, ".", ext[i])
  export(df, filename)
}
