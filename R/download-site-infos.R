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

################################################################################
# QUERY PREPARATION:
# infos of all stacks: https://api.stackexchange.com/docs/info
#   1.) [edit] on the left side: you can search websites with their deisplay names
#       a) typing into the search field opens up a menue where you can choose from a list
#       b) when a name is set the field displays the name of the site o address it via the api
#   2.) [edit] on the right side: you can select the data you want and set a filter
#       a) the filter can be added to the call to the api "&filter=<char string>"
#       b) with link you can see a URL-string to copy & edit for your programme
#   3.) You can run your settings to see what you will get
#   4.) A dummy example ("filter=default") with type description is prepared at:
#       https://api.stackexchange.com/docs/types/info

# QUERY DESIGN:
# I am interested in all infos of all sites but without their meta sites
# with one essential EXCEPTION: the meta site for the whole exchange network
# its api-syntax = "meta"
# with this exception: every site has a related site with the api-syntax:
# "<name>.meta"  (e.g. "outdoors.meta")
# I called https://stackexchange.com/sites#name
# hovering the mouse over the link gives you the api-syntax for the site name

# WATCH OUT
# (1) There are "spin-offs" from the orginal stackoverflow sites in local languages.
#     They have the api-syntax "<language-code>.stackoverflow", e.g. "pt.stackoverflow"
# (2) Tests turned out that the query returns for each website one line/row of data
#     but with different number of columns!
#     My solution was to use `bind_rows()` from the `dplyr` package.
#
# My query gets 172 websites, which is minus one of the figure mentioned on stackoverflow!
# But I checked it with the list of all sites: https://stackexchange.com/sites#name
##########################################################################################

library(stackr)
library(tidyverse)
# filter = `!9Z(-wtBWT`
#           excludes: everything, especially `site`
#           date of download: 25th May, 2018, 14:25 UCT


my_filter <- "!9Z(-wtBWT"
stack_names <- c(
"3dprinting",          "academia",            "ai",                  "alcohol",
"android",             "anime",               "apple",
"arduino",             "askubuntu",           "astronomy",           "augur",
"aviation",            "bicycles",            "bioinformatics",      "biology",
"bitcoin",             "blender",             "boardgames",          "bricks",
"buddhism",            "chemistry",           "chess",               "chinese",
"christianity",        "civicrm",             "codegolf",            "codereview",
"coffee",              "communitybuilding",   "computergraphics",    "conlang",
"cooking",             "craftcms",            "crafts",              "crypto",
"cs",                  "cseducators",         "cstheory",
"datascience",         "dba",                 "devops",              "diy",
"drupal",              "dsp",                 "earthscience",        "ebooks",
"economics",           "electronics",         "elementaryos",        "ell",
"emacs",               "engineering",         "english",             "esperanto",
"es.stackoverflow",
"ethereum",            "expatriates",         "expressionengine",
"fitness",             "freelancing",         "french",              "gamedev",
"gaming",              "gardening",           "genealogy",           "german",
"gis",                 "graphicdesign",       "ham",                 "hardwarerecs",
"health",              "hermeneutics",        "hinduism",            "history",
"homebrew",            "hsm",                 "interpersonal",       "iot",
"iota",                "islam",               "italian",             "ja.stackoverflow",
"japanese",
"joomla",              "judaism",             "korean",              "languagelearning",
"latin",               "law",                 "lifehacks",           "linguistics",
"literature",          "magento",             "martialarts",         "math",
"matheducators",       "mathematica",         "mathoverflow",
"mechanics",           "meta",                "monero",              "money",
"movies",              "music",               "musicfans",           "mythology",
"networkengineering",  "opendata",            "opensource",          "outdoors",
"parenting",           "patents",             "pets",                "philosophy",
"photo",               "physics" ,            "pm",                  "poker",
"politics",            "portuguese",          "psychology",          "pt.stackoverflow",
"puzzling",            "quant",               "quantumcomputing",    "raspberrypi",
"retrocomputing",      "reverseengineering",
"robotics",            "rpg",                 "ru.stackoverflow",    "rus",
"russian",             "salesforce",
"scicomp",             "scifi",               "security",            "serverfault",
"sharepoint",          "sitecore",            "skeptics",            "softwareengineering",
"softwarerecs",        "sound",               "space",               "spanish",
"sports",              "sqa",                 "stackapps",           "stackoverflow",
"stats",               "stellar",             "superuser",           "sustainability",
"tex",                 "tor",                 "travel",              "tridion",
"ukrainian",           "unix",                "ux",
"vegetarianism",       "vi",                  "video",               "webapps",
"webmasters",          "windowsphone",        "woodworking",         "wordpress",
"workplace",           "worldbuilding",       "writing"
)

# To collect the data (one row for one site). I have to create an empty data.frame
# Normally I would have to initialize the whole data frame with the proper data types.
# But with `bind_rows()` this is not necessary.
# But I have at least to declare a data frame with one (empty) column
# https://stackoverflow.com/questions/10689055/create-an-empty-data-frame

info_tbl <- tibble(new_active_users = numeric())
for (i in stack_names)
    {
    info_tbl <- as.tibble(bind_rows(info_tbl, stack_info(i, filter = my_filter)))
}
saveRDS(info_tbl, file = "data-raw/sites-raw.rds")

