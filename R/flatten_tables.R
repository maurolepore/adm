#' Title
#'
#' @param dm
#'
#' @return
#' @export
#'
#' @examples
#' dm <- dm(
#'   a = tibble(a_id = 1, a = 1),
#'   b = tibble(b_id = 1, b = 1),
#'   a_b = tibble(a_b_id = 1, a_id = 1, b_id = 1),
#'   c = tibble(c_id = 1, c = 1, d_id = 1),
#'   b_c = tibble(b_c_id = 1, b_id = 1, c_id = 1),
#'   d = tibble(d_id = 1, d = 1)
#' ) |> add_keys()
#'
#' flat <- dm |> flatten_tables()
#' expect_true(all(c("a", "b", "c", "d") %in% names(flat)))
#'
#' flat <- dm |>
#'   dm_select_tbl(a, b, a_b) |>
#'   flatten_tables()
#' expect_true(all(c("a", "b") %in% names(flat)))
#' expect_false(any(c("c", "c") %in% names(flat)))
flatten_tables <- function(dm) {
  link_table <- tidyr::crossing(link = names(dm), table = names(dm)) |>
    filter(link != table) |>
    filter(str_detect(link, table))
  link_table
  links <- link_table |> distinct(link) |> pull()
  flat <- lapply(links, \(x) dm_flatten_to_tbl(dm, !!x, .recursive = TRUE))
  purrr::reduce(flat, dplyr::left_join)
}


