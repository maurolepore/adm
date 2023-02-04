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
#' dm |> adm_flatten()
#'
#' dm |>
#'   dm_select_tbl(a, b, a_b) |>
#'   adm_flatten()
adm_flatten <- function(dm) {
  link_table <- tidyr::crossing(link = names(dm), table = names(dm)) |>
    filter(link != table) |>
    dplyr::rowwise() |>
    filter(grepl(table, link)) |>
    dplyr::ungroup()

  links <- link_table |>
    dplyr::distinct(link) |>
    pull()
  flat <- lapply(links, \(x) dm::dm_flatten_to_tbl(dm, !!x, .recursive = TRUE))

  out <- purrr::reduce(flat, dplyr::left_join)
  nms <- unique(unname(unlist(lapply(dm, names))))
  out[nms]
}
