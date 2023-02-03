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
