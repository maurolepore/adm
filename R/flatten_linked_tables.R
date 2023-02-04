#' Flatten a data model
#'
#' @param dm A dm.
#'
#' @return A tbl.
#' @export
#'
#' @examples
#' library(dm)
#'
#' dm <- adm_demo()
#' dm |> flatten_linked_tables()
#'
#' dm |>
#'   dm_select_tbl(a, b, a_b) |>
#'   flatten_linked_tables()
flatten <- function(dm) {
  link_table <- tidyr::crossing(link = names(dm), table = names(dm)) |>
    filter(.data$link != .data$table) |>
    dplyr::rowwise() |>
    filter(grepl(.data$table, .data$link)) |>
    dplyr::ungroup()

  links <- unique(link_table$link)
  flat <- lapply(links, \(x) dm::dm_flatten_to_tbl(dm, !!x, .recursive = TRUE))
  out <- Reduce(dplyr::left_join, flat)

  # Relocate names as in `dm`
  nms <- unique(unname(unlist(lapply(dm, names))))
  nms2 <- nms[nms %in% names(out)]
  out[nms2]
}
