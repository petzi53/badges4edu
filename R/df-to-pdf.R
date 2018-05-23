################################################################################
# Some utility function
#
# 1. Print dataframe as PDF into working directory
#
# USAGE:    source("R/toolbox.R")
################################################################################

my_packages <- c("gridExtra", "datasets")
lapply(my_packages, library, character.only = TRUE)

# Print dataframe as PDF to working directory
# Create a directory named "pdf" in your working directory
# example usage:
#     df_to_pdf()
#     df_to_pdf(my_df, "pdf/my_table.pdf")
#     df_to_pdf(my_df, "pdf/my_table.pdf", width=5)
data("mtcars")
df_to_pdf <- function(df = mtcars, file = "pdf/test.pdf", height=11, width=8.5){
        pdf(file, height, width)
        grid.table(df)
        dev.off()
}

################################################################################
