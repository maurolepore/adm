create_data_model <- function(path) {
  name <- path_ext_remove(path_file(path))
  dm(!!!enlist(path, name))
}

enlist <- function(path, nm) {
  path |>
    map(\(file) read_csv(file, show_col_types = FALSE)) |>
    set_names(nm)
}
