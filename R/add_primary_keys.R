add_primary_keys <- function(dm) {
  nm <- names(dm)
  pk <- set_names(paste0(nm, "_id"), nm)
  for (i in seq_along(dm)) {
    table <- nm[[i]]
    primary_key <- pk[[i]]
    dm <- dm_add_pk(dm, !!table, columns = !!primary_key)
  }
  dm
}
