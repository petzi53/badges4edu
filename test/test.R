#' ---
#' title: "Test: Compiling Reports from scripts"
#' author: "Peter Baumgartner"
#' date: "May 23rd, 2018"
#' ---

path <- getwd()
2 + 2

#' A script comment that includes **markdown** formatting.

x <- 2 * 3

#' The sum of {2 + 3} - {4 - 5} is
{{(2 + 3) - (4 - 5)}}
#' in total.

#+ test-a, cache=FALSE
saveRDS(x, file = "test.rds")

y <- readRDS("test.rds")
