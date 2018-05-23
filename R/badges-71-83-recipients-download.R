################################################################################
# Download recipients of badges 71 and 83 from Stack Overflow API
# This badges are awarded for 30 or 100 days consecutive site visiting
# see for more information: http://api.stackexchange.com/docs
#
# INPUT:    from Stack Overflow API
# OUTPUT1:  data-raw/badges-71-83-recipients-raw.rds
# OUTPUT2:  data-processed/badges-71-83-recipients.rds
# USAGE:    source("R/badges-71-83-recipients-download.R")
# PACKAGES: tidyverse (dplyr), stackr
################################################################################

library(stackr)
library(tidyverse)
# filter = `!*Jxe64Hz*eXDuu-I`
#           excludes from badge: badge_type, description, link
#           excludes from shallow user: display_name, link, profile_image, user_type

badges_consecutive_raw <- stack_badges(c(71,83),
                                       "recipients",
                                       page = 1,
                                       pagesize = 100,
                                       num_page = 10000,
                                       fromdate = 1356998400, # 2013-01-01
                                       todate =   1514678400, # 2017-12-31
                                       filter = "!*Jxe64Hz*eXDuu-I")
saveRDS(badges_consecutive_raw, file = "data-raw/badges-71-83-recipients-raw.rds")


####
badges_consecutive <- badges_consecutive_raw
colnames(badges_consecutive) <- c("rank", "badge_id", "name", "reputation", "user_id",
                                  "accept_rate", "bronze", "silver", "gold")
badges_consecutive <- badges_consecutive %>%
        select(user_id, badge_id, reputation, bronze, silver, gold, accept_rate, name, rank)
badges_consecutive <- arrange(badges_consecutive, badge_id, reputation)
saveRDS(badges_consecutive, file = "data-processed/badges-71-83-recipients.rds")


