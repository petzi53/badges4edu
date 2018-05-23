################################################################################
# Count and print the number of activity type badges
#
# INPUT:    data-processed/badges.rds
# OUTPUT:   data-processed/badges-by-activity.rds
# USAGE:    source("R/badges-by-activity.R")
# PACKAGES: tidyverse (dplyr)
################################################################################

library(tidyverse)
badges <- readRDS("data-processed/badges.rds")

by_activity <- badges %>%
        group_by(activity) %>%
        summarise(n = n(),
                  total = sum(award_count)) %>%
        ungroup()
saveRDS(by_activity, file = "data-processed/badges-by-activity.rds")
