library(xts)
library(dplyr)
library(magrittr)
library(tidyr)
library(lubridate)

user_activity <- generate_users_feed()

usethis::use_data(user_activity, overwrite = TRUE)
