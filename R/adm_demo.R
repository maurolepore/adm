#' A toy data model
#'
#' @return A dm.
#' @export
#'
#' @examples
#' adm_demo()
adm_demo <- function() {
  dm(
    a = tibble(a_id = 1, a = 1),
    a_b = tibble(a_b_id = 1, a_id = 1, b_id = 1),
    b = tibble(b_id = 1, b = 1),
    b_c = tibble(b_c_id = 1, b_id = 1, c_id = 1),
    c = tibble(c_id = 1, c = 1, d_id = 1),
    d = tibble(d_id = 1, d = 1),
    e = tibble(e_id = 1, e = 1)
  ) |> add_keys()
}
