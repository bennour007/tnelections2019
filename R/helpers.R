



compute <- function(data){
  data %>%
    group_by(state) %>%
    mutate(
      total_votes = sum(votes), # all legitimate votes for each state
      percent = votes/total_votes, # percentage of votes of each list per each state
      hare_quota = total_votes/n_of_seats,
      party_quota = votes/hare_quota,
      quota_seats = as.integer(party_quota),
      remains = party_quota - quota_seats,
      remains_seats = 0,
      remaining_seat = n_of_seats - sum(quota_seats)
    ) %>%
    arrange(desc(remains), .by_group = T) %>%
    ungroup() %>%
    return()
}





remains <- function(filtered_data){
  filtered_data %>%
    select(
      state,
      party,
      remaining_seat
    ) %>%
    nest_by(
      state,
      remaining_seat,
    ) %>%
    mutate(
      data = map2(
        data,
        remaining_seat,
        function(x,y) rep(x,3)[1:y]
      )
    ) %>%
    unnest(data) %>%
    add_column(remains_seats = 0) %>%
    mutate(
      remains_seats = remains_seats + 1
    ) %>%
    group_by(data, state) %>%
    summarize(
      r_seats = sum(remains_seats)
    ) %>%
    rename('party' = 'data') %>%
    ungroup() %>%
    return()
}



