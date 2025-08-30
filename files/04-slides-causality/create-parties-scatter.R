
library(tidyverse)
library(ggrepel)
library(readxl)
library(haven)

cg_df <- read_csv("05-slides-causality/es_data-v3.csv") %>%
  glimpse()

polity_df <- read_excel("05-slides-causality/p4v2017.xls") %>%
  select(-country) %>%
  glimpse()



df <- cg_df %>%
  separate(elec_id, c("A", "B", "year", "month", "D")) %>%
  mutate(year = as.numeric(year)) %>%
  left_join(polity_df) %>% 
  select(country, year, month, enep, average_magnitude = tier1_avemag, polity) %>%
  group_by(country) %>% 
  #mutate(max_year = max(year)) %>%
  filter(year == max(year)) %>%
  filter(month == max(month)) %>%
  filter(polity == 10) %>%
  filter(year >= 2000) %>%
  glimpse()


gg <- ggplot(df, aes(x = average_magnitude, y = enep, label = country)) + 
  scale_x_log10() + #scale_y_log10() + 
  geom_point() + 
  #geom_smooth(method = "lm", se = FALSE, color = "black") + 
  #geom_label_repel() + 
  hrbrthemes::theme_ipsum() + 
  labs(x = "Average District Magnitude",
       y = "Effective Number of Electoral Parties")
ggsave("05-slides-causality/scatter.png", gg, height = 3, width = 4, scale = 2)

gg2 <- gg + geom_smooth(method = "lm", se = FALSE, color = "#1b9e77")
ggsave("05-slides-causality/scatter2.png", gg2, height = 3, width = 4, scale = 2)

gg3 <- gg2 + geom_text_repel(size = 2.4, segment.alpha = 0.3, color = "#7570b3"); gg3
ggsave("05-slides-causality/scatter3.png", gg3, height = 3, width = 4, scale = 2)

