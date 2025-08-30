
library(googledrive)
library(googlesheets4)
library(tidyverse)
gs <- drive_get(id = "157kU4Y7jSpfJs6tnBvxAOctsvd1Lqf43pOfMbWyBwoA")
sheets_get(gs)

df <- read_sheet(gs) %>%
  rename(prediction = `What measurement will best predict a person's height?`,
         height = `What is your height (in cm)?`,
         forearm = `What is your forearm span?`,
         hand = `What is your hand span?`,
         head = `What is your head circumference?`) %>%
  filter(height < 500 & height > 150) %>%
  filter(forearm < 35) %>%
  glimpse()

df0 <- select(df, -Timestamp, -prediction) %>%
  write_csv("data/height.csv")

GGally::ggscatmat(df0)

ggsave("misc/height-matrix.pdf", height = 6, width = 6)

ggplot(df, aes(x = forearm, y = height)) + 
  geom_point()
ggsave("misc/forearm-height.pdf", height = 4, width = 6)


