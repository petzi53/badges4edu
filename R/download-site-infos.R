################################################################################
# Download site infos from Stack Overflow API
#
# More information: https://api.stackexchange.com/docs/info
#
# INPUT:    from Stack Overflow API
# OUTPUT:   data-raw/site-infos-raw.rds
# USAGE:    source("R/download-site-infos.R")
# PACKAGES: stackr
################################################################################

library(stackr)
library(tidyverse)
# filter = `!Fn4IB7S7UXxd9SuQf.UcABm-Ya`
#           excludes: info.site(api_revision, new_active_users), related_site, styling
#           includes: site(audience, launch_date, name, site_url)


# Error in stack_parse(req) : Error 400: No site found for name `ru
# Error in stack_parse(req) : Error 400: No site found for name `pt`
# Error in stack_parse(req) : Error 400: No site found for name `es`

# "rus"
# Error in rbind(deparse.level, ...) :
#     numbers of columns of arguments do not match

# "ruspberrypi",

# "islam"
# Error in rbind(deparse.level, ...) :
#     numbers of columns of arguments do not match

# "sqa"
# Error in rbind(deparse.level, ...) :
#     numbers of columns of arguments do not match

# "ja",
# Error in stack_parse(req) : Error 400: No site found for name `ja`

# parenting

# boardgames



my_filter <- "!)5IY6Rv(v4uf99YRN3Xu1nQJwwXP"
all_stacks0 <- c("stackoverflow", "superuser", "askubuntu", "english", "serverfault",
                  "unix", "math", "apple", "gaming", "dba", "stats", "tex", "electronics",
                  "ell", "diy", "physics", "android", "cooking", "scifi",
                  "softwareengineering", "codereview", "ru", "mechanics", "security",
                  "webapps", "graphicdesign", "wordpress", "pt", "gis", "travel", "es",
                  "rpg", "movies", "chemistry", "sharepoint", "salesforce", "magento",
                  "workplace", "academia", "rus", "ruspberrypi","anime", "blender",
                  "money", "islam", "photo", "aviation", "biology", "drupal",
                  "bicycles", "music", "gamedev", "sqa", "ja", "ethereum", "ux", "gardening",
                  "datascience", "arduino", "mathoverflow", "networkengineering", "parenting",
                  "ethereum", "ux", "datascience", "arduino", "mathoverflow",
                  "networkengineering", "bitcoin", "webmasters", "christianity",
                  "worldbuilding", "boardgames", "cs", "history", "puzzling", "pets", "spanish",
                  "dsp", "interpersonal", "lifehacks", "german", "mathematica", "japanese",
                  "crypto", "french", "writing", "skeptics", "hermeneutics", "meta",
                  "hinduism", "fitness", "quant", "sports", "portuguese", "space",
                  "politics", "philososphy", "law", "video", "codegolf", "engineering",
                  "health", "reverseengineering", "pm", "judaism", "vi", "woodworking",
                  "softwarerecs", "sound", "psychology", "economics", "astronomy",
                  "earthscience", "homebrew", "sitecore", "emacs", "tor", "craftcms",
                  "chess", "scicomp", "linguistics", "windowsphone", "devops", "alcohol",
                  "monero", "elementaryos", "chinese", "italian", "joomla", "3dprinting",
                  "robotics", "expatriates", "literature", "buddhism", "mythology", "bricks",
                  "musicfans", "ai", "ham", "martialarts", "cstheory", "coffee", "ukrainian",
                  "cseducators", "genealogy", "sustainability", "ebooks", "poker", "russian",
                  "opendata", "crafts", "iot", "computergraphics", "latin", "retrocomputing",
                  "matheducators", "expressionengine", "patents", "civicrm", "hsm",
                  "bioinformatics", "opensource", "freelancing", "tridion", "korean",
                  "stackapps", "hardwarerecs","iota", "quantumcomputing", "vegetarianism",
                  "stellar", "languagelearning", "esperanto", "augur", "conlang",
                  "communitybuilding")

info_df0 <- data.frame(character(),
                 stringsAsFactors = FALSE)

for (i in all_stacks0)
    {
    info_df0 <- bind_rows(info_df0, stack_info(i, filter = my_filter))
}



# saveRDS(info_df, file = "data-raw/sites-infos-raw.rds")
