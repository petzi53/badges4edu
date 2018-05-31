################################################################################
# Clean up column site_name
#
# INPUT:    data-raw/sites-raw.rds
# OUTPUT:   data-processed/sites.rds
# USAGE:    source("R/sites-transform.R")
# PACKAGES: tidyverse
################################################################################

library(tidyverse)
library(anytime)

sites <- readRDS("data-raw/sites-raw.rds")

# sites are sorted by site_api_site_parameter
# set language names of SO sites to English
sites[122, 26] <- "Stack Overflow in Portuguese"
sites[55, 26] <- "Stack Overflow in Spanish"
sites[131, 26] <- "Stack Overflow in Russian"
sites[131, 22] <- "for programmers in Russian language"
sites[132, 26] <- "Russian Language in Russian"
sites[132, 22] <- "learners of the Russian language"
sites[82, 26] <- "Stack Overflow in Japanese"
sites[82, 22] <- "for programmers in Japanese language"
sites[59, 22] <- "self-employed and freelance workers"

# https://stackoverflow.com/questions/11936339/replace-specific-characters-within-strings
sites$site_name <- gsub("&amp;",  "and", sites$site_name, fixed = TRUE)
sites$site_audience <- gsub("&amp;",  "and", sites$site_audience, fixed = TRUE)
sites$site_name <- gsub("&#174;", "", sites$site_name, fixed = TRUE)
sites$site_audience <- gsub("&#174;", "", sites$site_audience, fixed = TRUE)
sites$site_audience <- gsub("&#225;", "á", sites$site_audience, fixed = TRUE)
sites$site_audience <- gsub("&quot;", "'", sites$site_audience, fixed = TRUE)
sites$site_audience <- gsub("&#39;", "'", sites$site_audience, fixed = TRUE)

sites$site_audience

# sort by site_name in order to compare with website for adding site_category
sites <- sites[order(sites$site_name),]

site_category <- c(
    1,3,2,1,2,1,2,4,3,1,
    6,1,4,1,5,2,2,2,4,4,
    1,1,2,2,2,4,2,2,2,1,
    1,2,5,4,1,5,4,2,1,4,
    1,1,1,1,1,4,1,4,1,1,
    1,2,2,2,1,3,1,5,2,1,
    3,3,1,2,2,1,3,2,2,4,
    3,2,1,1,3,1,2,2,2,1,
    2,2,2,3,3,4,3,1,2,4,
    1,4,4,1,2,1,2,3,3,3,
    2,1,1,5,3,3,3,4,3,3,
    4,2,2,2,1,6,4,2,6,1,
    1,1,1,1,2,2,1,3,3,1,
    1,1,1,2,1,1,1,1,1,2,
    2,1,1,1,1,1,1,1,3,1,
    2,5,4,1,2,1,2,1,1,2,
    1,3,1,1,1,2,1,3,5,1,
    2,1
)

# using bind_cols from `dplyr`: binding vector needs name for column
sites <- bind_cols(sites, site_category = site_category)

categories <- c(
    "Technology",           # 1
    "Culture/Recreation",   # 2
    "Life/Arts",            # 3
    "Science",              # 4
    "Professional",         # 5
    "Business"              # 6
)

sites$site_category <- factor(sites$site_category,
                              levels = c(1:6),
                              labels = categories)

sites$site_site_state <- factor(sites$site_site_state,
                                levels = c("closed_beta", "open_beta", "normal"),
                                labels = c("closed_beta", "open_beta", "normal"),
                                ordered = TRUE)

# add column with state date (normal or beta launch date)
sites <- sites %>% mutate(
    site_state_date = if_else(
        condition = is.na(sites$site_launch_date),
        true = sites$site_open_beta_date,
        false = sites$site_launch_date)
    )


sites$site_active_days <-
    round(as.numeric(difftime(as.POSIXct(Sys.time(), "UCT"),
                              sites$site_state_date, units = "days")))




saveRDS(as_tibble(sites), file = "data-processed/sites.rds")


