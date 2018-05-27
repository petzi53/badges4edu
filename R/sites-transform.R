################################################################################
# Clean up column site_name
#
# INPUT:    data-raw/sites-raw.rds
# OUTPUT:   data-processed/sites.rds
# USAGE:    source("R/sites-transform.R")
# PACKAGES: ----
################################################################################

sites <- readRDS("data-raw/sites-raw.rds")

# sort by name to find the correct row number for change
sites <- sites[order(sites$site_name), ]

# set language names of SO sites to English
sites[145, 26] <- "Stack Overflow in Portuguese"
sites[146, 26] <- "Stack Overflow in Spanish"
sites[147, 26] <- "Stack Overflow in Russian"
sites[171, 26] <- "Russian Language in Russian"
sites[172, 26] <- "Stack Overflow in Japanese"

# https://stackoverflow.com/questions/11936339/replace-specific-characters-within-strings
sites$site_name <- gsub("&amp;",  "&", sites$site_name, fixed = TRUE)
sites$site_name <- gsub("&#174;", "®", sites$site_name, fixed = TRUE)

# sort again by name to reorder column inlcuding the new (changes) names
sites <- sites[order(sites$site_name),]
saveRDS(sites, file = "data-processed/sites.rds")


