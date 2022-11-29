library(tidyverse)
library(rvest)


html <- read_html("https://en.wikipedia.org/wiki/2022_FIFA_World_Cup_squads")

# Download raw data

x <- html |>
  html_elements("td:nth-child(4)") %>%
  html_text2() %>%
  as_tibble() |>
  filter(str_length(value) > 13)

# Clean up data. This gives 831 rows, which is almost 32 teams times 26 players per
# team. But doesn't France just have 25 players? Iran only has 25 players.

x |>
  separate(value, into = c("var1", "month", "var3", "var4", "var5"), sep = " ") |>
  select(month) |>
  mutate(month = factor(month,  levels = month.name)) |>
  ggplot(aes(month)) +
    geom_bar()



