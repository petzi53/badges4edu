################################################################################
# Download related r-tags from Stack Overflow API
#
# see for more information: http://api.stackexchange.com/docs
#
# INPUT:    from Stack Overflow API
# OUTPUT1:  data-raw/tags-r-related.rds
# OUTPUT2:  data-processed/tags-r-related.rds
# USAGE:    source("R/tags-r-related-download.R")
# PACKAGES: stackr
################################################################################

library(stackr)

# filter = "!9f2VKxW_*" without "has_synonyms", "is_moderator_only", "is_required"
# filter only returns: "count" and "name".
r_tags <- stack_tags(name = "r",
                     special = "related",
                     pagesize = 100, # = max, 30 is standard
                     page = 1,
                     num_pages = 3,
                     filter = "!9f2VKxW_*")
saveRDS(r_tags, file = "data-raw/tags-r-related-raw.rds")

r_tags_ordered <- r_tags[c(2,1)]
saveRDS(r_tags_ordered, file = "data-processed/tags-r-related.rds")
