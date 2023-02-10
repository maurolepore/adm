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
  dm %>%
    add_primary_keys() %>%
    add_foreign_keys()
}

add_primary_keys <- function(dm) {
  out <- dm
  nm <- names(out)
  pk <- set_names(paste0(nm, "_id"), nm)
  for (i in seq_along(out)) {
    table <- nm[[i]]
    primary_key <- pk[[i]]
    out <- dm_add_pk(out, !!table, columns = !!primary_key)
  }
  out
}

add_foreign_keys <- function(dm) {
  out <- dm %>%
    add_fk() %>%
    warn_if_lacks_fk()
  out
}

add_fk <- function(dm) {
  fk <- enframe_fk(dm)
  has_fk <- !identical(nrow(fk), 0L)
  if (has_fk) {
    for (i in seq_len(nrow(fk))) {
      table_i <- fk$table[[i]]
      columns_i <- fk$columns[[i]]
      ref_table_i <- fk$ref_table[[i]]
      dm <- dm_add_fk(dm, !!table_i, !!columns_i, !!ref_table_i)
    }
  }
  dm
}

warn_if_lacks_fk <- function(dm) {
  lacks_fk <- identical(nrow(dm::dm_get_all_fks(dm)), 0L)
  if (lacks_fk) {
    warning("Added no foreign key (found no candidate).")
  }
  invisible(dm)
}

enframe_fk <- function(dm) {
  out <- dm %>%
    as.list() %>%
    map(names) %>%
    map(\(x) grep("_id$", x, value = TRUE)) %>%
    imap(\(x, names_x) setdiff(x, paste0(names_x, "_id"))) %>%
    keep(\(x) length(x) > 0L) %>%
    enframe(name = "table", value = "columns")

  out %>%
    group_by(table) %>%
    reframe(columns = unlist(.data$columns)) %>%
    mutate(ref_table = gsub("_id$", "", .data$columns)) %>%
    filter(.data$ref_table %in% names(dm))
}
