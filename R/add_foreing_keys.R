add_foreign_keys <- function(dm) {
  dm |>
    add_fk() |>
    warn_if_lacks_fk()
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
  dm |>
    as.list() |>
    map(names) |>
    map(\(x) grep("_id$", x, value = TRUE)) |>
    imap(\(x, names_x) setdiff(x, paste0(names_x, "_id"))) |>
    keep(\(x) length(x) > 0L) |>
    enframe(name = "table", value = "columns") |>
    unnest("columns") |>
    mutate(ref_table = gsub("_id$", "", .data$columns)) |>
    filter(.data$ref_table %in% names(dm))
}
