################################################################################
# Add different categories to badge data
#
# There are different step in this script:
# 1. Reorder and rename columns
# 2. Add types of activity
# 3. Add types of origin for awared badges
#
# INPUT:    data-raw/badges-raw.rds
# OUTPUT:   data-processed/badges.rds
# USAGE:    source("R/badges-transform.R")
# PACKAGES: tidyverse
################################################################################


library(tidyverse)
badges <- tbl_df(readRDS("data-raw/badges-raw.rds"))

######
# 1. factorize and order column "rank"

badges$rank <- as.ordered(factor(badges$rank, levels = c("bronze", "silver", "gold")))


######
# 2. Add types of activity

activity <-      c(1,5,5,4,3,1,3,5,3,5,
                   4,4,4,3,4,3,3,4,4,1,
                   4,4,4,6,6,6,4,4,2,3,
                   3,4,2,1,3,1,2,2,1,2,
                   1,2,2,5,1,1,3,4,3,2,
                   2,1,5,1,4,3,4,1,2,3,
                   1,4,5,3,3,2,4,2,4,2,
                   1,2,4,1,4,1,4,4,1,4,
                   4,4,4,3,4,2,2,1,2,4,
                   3)
badges <- cbind(badges, activity)
activity_types <- c(
        "Question",       # 1
        "Answer",         # 2
        "Participation",  # 3
        "Moderation",     # 4
        "Other",          # 5
        "Documentation"   # 6
)
badges$activity <- factor(badges$activity, levels = c(1:6), labels = activity_types)

# 3. Add types of origin for the awarded badges

origin <- c(
         1,4,2,1,1,1,3,2,3,3,
         1,1,1,1,3,3,2,1,1,1,
         1,1,1,4,4,4,1,1,2,1,
         2,1,1,2,1,2,2,2,2,2,
         2,2,1,1,1,1,2,1,2,2,
         2,2,3,2,1,2,1,2,2,4,
         1,1,2,2,2,1,1,2,1,1,
         1,1,3,1,1,2,1,1,1,1,
         1,2,1,2,2,1,1,2,2,1,
         3)

badges <- cbind(badges, origin)
based_on <- c(
        "User",           # 1
        "Community",      # 2
        "Event",          # 3
        "Dead"            # 4
)
badges$origin <- factor(badges$origin, levels = c(1:4), labels = based_on)

badges <- badges[, c(
        "badge_id",
        "name",
        "award_count",
        "rank",
        "activity",
        "origin",
        "description")]


saveRDS(badges, file = "data-processed/badges.rds")
