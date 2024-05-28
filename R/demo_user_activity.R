library(Matrix)

options(xts_check_TZ = FALSE)

markov_chain <- function(n = 50) {
  # Define all possible states
  states <- c(
    "PAGE_VIEW", "CLICK_AD", "ACCEPT_INVITE",
    "PASSWORD_RESET_REQUEST", "PASSWORD_CHANGE", "PROFILE_UPDATE", "LEAVE_REVIEW",
    "CONTACT_SUPPORT", "VIEW_HELP_FAQ", "DOWNLOAD_FILE", "ENABLE_NOTIFICATIONS",
    "DISABLE_NOTIFICATIONS", "INVITE_FRIEND", "SOCIAL_SHARE",
    "SUBSCRIBE_TO_NEWSLETTER", "UNSUBSCRIBE_FROM_NEWSLETTER",
    "SIGN_UP", "SIGN_IN",
    "VIEW_ANALYTICS_DASHBOARD", "USE_FEATURE_A", "USE_FEATURE_B",
    "SHOW_PAYWALL", "CLOSE_PAYWALL", "APPLY_COUPON", "BOUNCE",
    "SUBSCRIBE",
    "USE_FEATURE_C", "USE_FEATURE_D", "USE_FEATURE_E",
    "UNSUBSCRIBE", "RENEW_SUBSCRIPTION", "UPGRADE_SUBSCRIPTION", "DOWNGRADE_SUBSCRIPTION"
  )

  # Define the initial state probabilities
  initial_probs <- c(
    "PAGE_VIEW" = 0.645,
    "CLICK_AD" = 0.35,
    "ACCEPT_INVITE" = 0.005
  )

  # Define transition probabilities for Nutrition group
  nutrition_states <- c(
    "PASSWORD_RESET_REQUEST", "PASSWORD_CHANGE", "PROFILE_UPDATE", "LEAVE_REVIEW",
    "CONTACT_SUPPORT", "VIEW_HELP_FAQ", "DOWNLOAD_FILE", "ENABLE_NOTIFICATIONS",
    "DISABLE_NOTIFICATIONS", "INVITE_FRIEND", "SOCIAL_SHARE", "SUBSCRIBE_TO_NEWSLETTER",
    "UNSUBSCRIBE_FROM_NEWSLETTER"
  )

  free_section_states <- c(
    "VIEW_ANALYTICS_DASHBOARD", "USE_FEATURE_A", "USE_FEATURE_B", "SHOW_PAYWALL",
    "CLOSE_PAYWALL", "APPLY_COUPON", "BOUNCE"
  )

  premium_section_states <- c(
    "USE_FEATURE_C", "USE_FEATURE_D", "USE_FEATURE_E", "UNSUBSCRIBE",
    "RENEW_SUBSCRIPTION", "UPGRADE_SUBSCRIPTION", "DOWNGRADE_SUBSCRIPTION"
  )

  # Initialize an empty sparse transition matrix
  transition_matrix <- Matrix(0,
                              nrow = length(states),
                              ncol = length(states),
                              dimnames = list(states, states),
                              sparse = TRUE)

  # Function to set equal transition probabilities within a group
  set_equal_transitions <- function(matrix, from_states, to_states) {
    for (from in from_states) {
      for (to in to_states) {
        matrix[from, to] <- 1 / length(to_states)
      }
    }
    return(matrix)
  }

  # Function to set specific transition probabilities
  set_specific_transitions <- function(matrix, from_state, to_states, probabilities) {
    for (i in seq_along(to_states)) {
      matrix[from_state, to_states[i]] <- probabilities[i]
    }
    return(matrix)
  }

  # Set transitions according to the rules
  transition_matrix <- set_equal_transitions(transition_matrix, names(initial_probs), nutrition_states)
  transition_matrix <- set_equal_transitions(transition_matrix, nutrition_states, "SIGN_UP")
  transition_matrix <- set_equal_transitions(transition_matrix, "SIGN_UP", "SIGN_IN")
  transition_matrix <- set_equal_transitions(transition_matrix, "SIGN_IN", free_section_states)
  transition_matrix <- set_equal_transitions(transition_matrix, free_section_states, c("SUBSCRIBE", "BOUNCE"))

  # Add specific transition probabilities
  # Free section transitions
  free_probs <- c(0.08, 0.92)
  transition_matrix <- set_specific_transitions(transition_matrix, "SUBSCRIBE", free_section_states, free_probs)

  # Premium section transitions
  premium_probs <- c(0.8, 0.14, 0.04, 0.02)
  transition_matrix <- set_specific_transitions(transition_matrix, "SUBSCRIBE", premium_section_states, premium_probs)

  # Convert to dense matrix for normalization
  transition_matrix <- as.matrix(transition_matrix)

  # Normalize the transition matrix to ensure rows sum to 1, handle rows with zero sums and NAs
  normalize_rows <- function(matrix) {
    for (i in 1:nrow(matrix)) {
      row_sum <- sum(matrix[i, ], na.rm = TRUE)
      if (row_sum > 0) {
        matrix[i, ] <- matrix[i, ] / row_sum
      } else {
        matrix[i, ] <- rep(0, ncol(matrix))  # Ensure no NA values and set to zero
      }
      matrix[i, is.na(matrix[i, ])] <- 0  # Replace any remaining NAs with zeros
    }
    return(matrix)
  }

  transition_matrix <- normalize_rows(transition_matrix)

  # Custom function to simulate the Markov chain
  simulate_markov_chain <- function(initial_probs, transition_matrix, n) {
    sequence <- character(n)
    sequence[1] <- sample(names(initial_probs), 1, prob = initial_probs)

    for (i in 2:n) {
      current_state <- sequence[i - 1]
      next_states <- colnames(transition_matrix)
      next_probs <- transition_matrix[current_state, ]
      if (sum(next_probs, na.rm = TRUE) == 0) {
        sequence[i] <- sample(names(initial_probs), 1, prob = initial_probs)
      } else {
        sequence[i] <- sample(next_states, 1, prob = next_probs)
      }
    }

    return(sequence)
  }

  simulate_markov_chain(initial_probs, transition_matrix, n)
}

generate_random_date <- function(start_year = 2020, end_year = 2026) {
  start_date <- as.Date(paste0(start_year, "-01-01"))
  end_date <- as.Date(paste0(end_year, "-12-31"))
  random_date <- sample(seq.Date(start_date, end_date, by = "day"), 1)
  return(random_date)
}

generate_user_feed <- function(user_id, start_year, end_year) {
  random_int <- rnbinom(1, size = 0.8, mu = 80) + 2
  activity <- markov_chain(random_int)
  start_time <- as.POSIXct(generate_random_date(start_year = start_year,
                                                end_year = end_year))
  # Generate random time increments (in seconds) using exponential distribution
  # Adjust the rate to spread the timestamps over 2 years
  rate <- 1/(3600 * 24 * 365 / 80)  # Scaling to stretch over 2 years
  time_increments <- cumsum(rexp(random_int, rate))
  timestamps <- start_time + time_increments
  data_xts <- xts(
    data.frame(
      user_id = as.integer(rep(user_id, random_int)),
      activity = as.character(activity), stringsAsFactors = FALSE
    ),
    order.by = as.POSIXct(timestamps)
  )
  return(data_xts)
}

generate_users_feed <- function(users_count = 10000,
                                start_year = 2020,
                                end_year = 2025) {
  user_feeds <- list()
  for (user_id in seq_len(users_count)) {
    user_feed <- generate_user_feed(user_id,
                                    start_year = start_year,
                                    end_year = end_year)
    user_feeds[[user_id]] <- user_feed
  }
  feed <- do.call(rbind, user_feeds)
  feed
}
