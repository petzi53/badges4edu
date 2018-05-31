my_packages <- c("tidyverse", "knitr", "kableExtra", "pander")
temp <- lapply(my_packages, library, character.only = TRUE)

df_tbl <- readRDS("data-processed/sites.rds")
df_tbl <- df_tbl[order(df_tbl$total_users, decreasing = TRUE), ] # sort by number of users
df_tbl <- rowid_to_column(df_tbl, var = "site_rank") # set  1…n to column variable
df_tbl <- df_tbl[order(df_tbl$site_name), ]   # sort by name and remember rank by user

sites <- df_tbl %>% select(
    site_name,
    site_site_url
)

table.format <- "html"
table.escape = TRUE


if (knitr::is_html_output()) {
    table.format <- "html"
    sites <- sites %>% mutate(
        urlName = paste0("<a href=\"", sites$site_site_url, "\">",
                         sites$site_name, "</a>")
    )
    table.escape = FALSE
}


# if (knitr::is_latex_output()) {
    table.format <- "latex"
    sites <- sites %>% mutate(
        urlName = paste0("\\href{", sites$site_site_url, "}{",
                         sites$site_name, "}")
    )
    table.escape = FALSE
# }


kable(sites, table.format, table.escape)
