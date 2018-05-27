################################################################################
# Add different categories to badge data
#
# There are different step in this script:
# 1. Factorize and order column "rank"
# 2. Add types of activity
# 3. Add types of origin for awarded badges
# 4. Mark same action necessary for badges, but with different degrees of difficulty
# 5. Reorder columns
# 6. Clean up html entities and URls in column "description"
#
# INPUT:    data-raw/badges-raw.rds
# OUTPUT:   data-processed/badges.rds
# USAGE:    source("R/badges-transform.R")
# PACKAGES: tidyverse, XML
################################################################################


library(tidyverse)
badges <- tbl_df(readRDS("data-raw/badges-raw.rds"))

#####################################
# 1. Factorize and order column "rank"

badges$rank <- as.ordered(factor(badges$rank, levels = c("bronze", "silver", "gold")))


#####################################
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

#####################################
# 3. Add types of origin for awarded badges

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
        "Peer",           # 2
        "Event",          # 3
        "Dead"            # 4
)
badges$origin <- factor(badges$origin, levels = c(1:4), labels = based_on)

#####################################
# 4. Mark same action necessary for badges, but with different degrees of difficulty

alike <- c(
    "XX","XX","22","20","XX","XX","13","22","09","XX",
    "16","XX","XX","10","17","09","14","19","XX","01",
    "18","16","XX","XX","XX","XX","19","XX","XX","11",
    "12","20","05","04","11","02","XX","06","03","06",
    "03","XX","05","XX","01","XX","12","16","12","07",
    "06","03","XX","04","XX","15","XX","04","XX","13",
    "XX","XX","22","10","14","05","21","XX","18","07",
    "XX","XX","17","01","XX","02","18","19","XX","XX",
    "XX","XX","21","15","XX","XX","08","XX","08","XX",
    "XX"
)
badges <- cbind(badges, alike)

#####################################
# 5. Reorder columns

badges <- badges[, c(
        "badge_id",
        "name",
        "award_count",
        "rank",
        "activity",
        "origin",
        "alike",
        "description")]

#####################################
# 6. Clean up manually long text in column "description"

# badges[1,8] <- "First bounty you manually award on another person's question"
# badges[5,8] <- "Complete 'About Me' section of user profile"
# badges[7,8] <- "Voted 10 times, added 3 posts score > 0, and visited the site on 3 separate days during the private bet"
# badges[9,8] <- "Visit an election during any phase of an active election and have enough reputation to cast a vote"
# badges[16,8] <- "Vote for a candidate in the final phase of an election"
# badges[17,8] <- "10 posts with score of 2 on meta (MSO)"
# badges[21,8] <- "Complete at least one review task. This badge is awarded once per review type"
# badges[26,8] <- "Earned at least one badge for contributing to Stack Overflow Documentation"
# badges[30,8] <- "Visit the site each day for 30 consecutive days. (Days are counted in UTC.)"
# badges[33,8] <- "Edit and answer 1 question (both actions within 12 hours, answer score > 0)"
# badges[35,8] <- "Visit the site each day for 100 consecutive days. (Days are counted in UTC.)"
# badges[43,8] <- "Edit and answer 500 questions (both actions within 12 hours, answer score > 0)"
# badges[44,8] <- "Read the entire tour page"
# badges[46,8] <- "First bounty you offer on another person's question"
# badges[49,8] <- "Earn at least 200 reputation (the daily maximum) in a single day"
# badges[53,8] <- "Met a Stack Overflow employee at an event where Stack Overflow was an organizer or participant with 50 or more attendees"
# badges[56,8] <- "Post 10 messages in chat starred by 10 different users"
# badges[60,8] <- "Followed the Area 51 proposal for this site before it entered the commitment phase"
# badges[65,8] <- "One post with score of 2 on met"
# badges[66,8] <- "Edit and answer 50 questions (both actions within 12 hours, answer score > 0)"
# badges[69,8] <- "Complete at least 250 review tasks. This badge is awarded once per review type"
# badges[77,8] <- "Complete at least 1,000 review tasks. This badge is awarded once per review type"
# badges[82,8] <- "First approved tag synonym"
# badges[84,8] <- "Post 10 messages, with 1 or more starred, in chat"

library(XML)

# https://stackoverflow.com/questions/42724885/convert-html-entity-to-proper-character-r
decode <- function(x) {
    xmlValue(getNodeSet(htmlParse(x, asText = TRUE), "//p")[[1]])
}

badges$description <- lapply(badges$description, decode)

saveRDS(badges, file = "data-processed/badges.rds")
