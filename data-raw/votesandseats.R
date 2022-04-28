## code to prepare `votesandseats` dataset goes here

library(tidyverse)
library(janitor)

votes <- read_csv(file = 'data-raw/votes.csv')
seats <- read_csv(file = 'data-raw/seats.csv')




data_clean <- votes %>%
  clean_names() %>%
  mutate_if(is.double, ~coalesce(.,0))

seats <-seats %>%
  rename('state' = 'Circonscription',
         'n_of_seats' = Sièges)


votesandseats <- data_clean %>%
  pivot_longer(cols = afek_tounes:autres,
               values_to = 'votes',
               names_to = 'party') %>%
  rename('state'='name_fr') %>%
  left_join(seats, by = 'state') %>%
  mutate(party = str_replace_all(party, '_',' '),
         party = str_to_upper(party)) %>%
  as_tibble()



usethis::use_data(votesandseats, overwrite = TRUE)
