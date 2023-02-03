add_keys <- function(dm) {
  dm |>
    add_primary_keys() |>
    add_foreign_keys()
}
