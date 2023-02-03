#' Add primary and foreign keys automatically
#'
#' This function adds primary and foreign keys to a 'dm' object automatically,
#' assuming the names of the tables and keys follow these rules:
#' 1. For each table, the primary key has the same name as the table with the
#' prefix `_id`. For example the table `x` has a primary key named `x_id`.
#' 2. If an `_id` column exists in a table which name is different than the
#' prefix of `_id`, then that column is a foreign key linking to another table.
#' For example, in the table `x_id`, the column `y_id` is a foreign key linking
#' to the table `y`.
#'
#' @inheritParams dm::dm_add_pk
#'
#' @return An updated dm with primary and foreign key relations.
#' @export
#'
#' @examples
#' dm <- dm::dm(x = data.frame(x_id = 1, y_id = 2), y = data.frame(y_id = 2))
#' add_keys(dm)
add_keys <- function(dm) {
  dm |>
    add_primary_keys() |>
    add_foreign_keys()
}
