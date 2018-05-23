################################################################################
# Count and print the number of the origin of badges
#
# INPUT:    data-processed/badges.rds
# OUTPUT:   data-processed/badges-by-origin.rds
# USAGE:    source("R/badges-by-origin.R")
# PACKAGES: tidyverse (dplyr)
################################################################################

library(tidyverse)
badges <- readRDS("data-processed/badges.rds")

by_origin <- badges %>%
        group_by(origin) %>%
        summarise(n = n(),
                  total = sum(award_count)) %>%
        ungroup()
saveRDS(by_origin, file = "data-processed/badges-by-origin.rds")

