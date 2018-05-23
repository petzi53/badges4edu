################################################################################
# Download badges data from Stack Overflow API
#
# see for more information: http://api.stackexchange.com/docs
#
# INPUT:    from Stack Overflow API
# OUTPUT:   data-raw/badges-raw.rds
# USAGE:    source("R/badges-download.R")
# PACKAGES: stackr
################################################################################

library(stackr)
# filter = `!--l6ygBKIgeI`
#           includes: badge.description
#           excludes: badge_type

badges <- stack_badges(special = "name",
                       sort = "name",
                       order = "asc",
                       pagesize = 100,
                       filter = "!--l6ygBKIgeI")

saveRDS(badges, file = "data-raw/badges-raw.rds")
