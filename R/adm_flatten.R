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
#' dm <- abcd()
#' dm |> flatten()
#'
#' dm |>
#'   dm_select_tbl(a, b, a_b) |>
#'   flatten()
flatten <- function(dm) {
  link_table <- tidyr::crossing(link = names(dm), table = names(dm)) |>
    filter(.data$link != .data$table) |>
    dplyr::rowwise() |>
    filter(grepl(.data$table, .data$link)) |>
    dplyr::ungroup()

  links <- link_table |>
    dplyr::distinct(.data$link) |>
    dplyr::pull()
  links <- unique(link_table$link)
  flat <- lapply(links, \(x) dm::dm_flatten_to_tbl(dm, !!x, .recursive = TRUE))

  out <- purrr::reduce(flat, dplyr::left_join)
  nms <- unique(unname(unlist(lapply(dm, names))))
  out[nms]
}
