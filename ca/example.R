
# R scrip to illustrate CA1

# load packages
library(tidyverse)

# load data
df <- read_rds("parties.rds")

# quick look
glimpse(df)

# plot
ggplot(df, aes(x = electoral_system, y = enep)) + 
  geom_violin()

# observation 1: Just write your observations at the bottom of the script like
# this. If you want to "reflow" a script so that each line is the proper length
# without having to many enter the line breaks, just highlight the comment, and
# click *Code > Reflow Comment*. You'll get nice, equally-size lines, like 
# these.

# observation 2: ...

# observation 3: ...