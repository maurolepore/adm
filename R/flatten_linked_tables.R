#' Flatten a data model
#'
#' @inheritParams dm::dm_flatten_to_tbl
#'
#' @return A single table that results from consecutively joining all linked
#'   tables.
#' @export
#'
#' @examples
#' library(dm)
#'
#' dm <- adm_demo()
#' dm %>% flatten_linked_tables()
#'
#' dm %>%
#'   dm_select_tbl(a, b, a_b) %>%
#'   flatten_linked_tables()
flatten_linked_tables <- function(dm, .join = dplyr::left_join) {
  all_fk <- dm %>% dm::dm_get_all_fks()
  tables <- names(dm)
  linked <- unique(c(all_fk$child_table, all_fk$parent_table))

  if (length(linked) == 0) {
    rlang::abort(c(
      x = "Can't join any table.",
      i = "Do you need to check for common '*_id' columns?"
    ))
  }

  unlinked <- setdiff(names(dm), linked)
  if (!length(unlinked) == 0) {
    rlang::warn(paste0("Unlinked tables: ", toString(unlinked)))
  }

  out <- purrr::reduce(dm[linked], .join)

  # Relocate names as in `dm`
  nms <- unique(unname(unlist(lapply(dm, names))))
  nms2 <- nms[nms %in% names(out)]
  out[nms2]
}
