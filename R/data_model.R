#' Create a data model
#'
#' @param dir A directory with .csv tables.
#'
#' @return A "dm" object.
#' @export
#'
#' @examples
#' library(tibble)
#' library(withr)
#' library(readr)
#' library(fs)
#'
#' tmp <- local_tempdir()
#' write_csv(tibble(x_id = 1, y_id = 2), path(tmp, "x.csv"))
#' write_csv(tibble(y_id = 2), path(tmp, "y.csv"))
#'
#' data_model(tmp)
data_model <- function(dir) {
  dir |>
    fs::dir_ls() |>
    create_data_model() |>
    add_primary_keys() |>
    add_foreign_keys()
}
