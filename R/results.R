
#' Computes the the results in each state for each part/list
#'
#' @param data the data set to use, uses votesandseats as default
#' @param t the threshold desired, if 1% is what you want to tet put t = 0.01
#'
#' @export

results <- function(data, t){
  filtered_data <- data %>%
    compute() %>%
    filter(percent >= t)

  filtered_data %>%
    group_by(party, state) %>%
    summarise(q_seats = sum(quota_seats)) %>%
    ungroup() %>%
    left_join(
      filtered_data %>%
        remains,
      by = c('party', 'state')
    ) %>%
    mutate(
      r_seats = replace_na(r_seats, 0),
      total_seats = q_seats + r_seats
    ) %>%
    filter(total_seats != 0) %>%
    mutate(
      party = if_else(
        party %in% c('OUTSIDER1', 'OUTSIDER2', 'AUTRES'), 'OTHERS', party
      )
    ) %>%
    return()
}



