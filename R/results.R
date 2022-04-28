
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
    return()
}



