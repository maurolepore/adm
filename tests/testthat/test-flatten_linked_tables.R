test_that("outputs the expected columns", {
  dm <- adm_demo()%>%dm::dm_select_tbl(b, b_c, c, d)
  out <- flatten_linked_tables(dm)%>%suppressMessages()
  nms <- unique(unname(unlist(lapply(dm, names))))
  expect_equal(sort(names(out)), sort(nms))
})

test_that("outputs names in the order they apprear in the dm", {
  dm <- adm_demo()
  expect_warning(
    out <- flatten_linked_tables(dm)%>%suppressMessages(),
    "Unlinked.*e"
  )
  exp <- c(
    "a_id",
    "a",
    "a_b_id",
    "b_id",
    "b",
    "b_c_id",
    "c_id",
    "c",
    "d_id",
    "d"
  )
  expect_named(out, exp)

  expect_true(hasName(dm, "e"))
  # The `e` tabe is unlinked so it doesn't show up in the output
  expect_false(hasName(out, "e"))
})

test_that("flattens linked tables by position in the data model", {
  dm <- adm::add_keys(dm::dm(
    x = tibble(x_id = 1, y_id = 1),
    y = tibble(y_id = 1, z_id = 1),
    z = tibble(z_id = 1)
  ))

  out1 <- dm |>
    dm::dm_flatten_to_tbl(x) |>
    suppressMessages()
  out2 <- dm |>
    flatten_linked_tables() |>
    suppressMessages() |>
    suppressWarnings()

  expect_equal(out1, out2)
})

test_that("ignores unliked tables with a warning", {
  dm <- adm::add_keys(dm::dm(
    x = tibble(x_id = 1, y_id = 1),
    y = tibble(y_id = 1),
    z = tibble(z_id = 1)
  ))
  out <- expect_warning(suppressMessages(flatten_linked_tables(dm)), "Unlinked.*z")
  expect_false("z" %in% names(out))
})

test_that("with unlinkable tables throws an error", {
  dm <- dm::dm(x = tibble(x_id = 1), y = tibble(y_id = 1))
  expect_error(flatten_linked_tables(dm), "Can't join")
})

test_that("joins tables in multiple non-linear pathways", {
  dm <- adm::add_keys(dm::dm(
    a = tibble(a_id = 1, b_id = 1, d_id = 1),
    b = tibble(b_id = 1, c_id = 1),
    c = tibble(c_id = 1),
    d = tibble(d_id = 1)
  ))

  out <- flatten_linked_tables(dm)%>%suppressMessages()
  expect_equal(sort(names(out)), paste0(names(dm), "_id"))
})

test_that("joins tables in multiple non-linear pathways", {
  dm <- adm::add_keys(dm::dm(
    d = tibble(d_id = 1),
    c = tibble(c_id = 1),
    b = tibble(b_id = 1, c_id = 1),
    a = tibble(a_id = 1, b_id = 1, d_id = 1)
  ))

  out <- flatten_linked_tables(dm)%>%suppressMessages()
  expect_equal(sort(names(out)), sort(paste0(names(dm), "_id")))
})

test_that("is sensitive to .join", {
  dm <- adm::add_keys(dm::dm(
    a = tibble(a_id = 1, b_id = 1),
    b = tibble(b_id = 1:2, c = 1:2)
  ))

  out1 <- flatten_linked_tables(dm)%>%suppressMessages()
  out2 <- flatten_linked_tables(dm, dplyr::right_join)%>%suppressMessages()
  expect_false(identical(out1, out2))
})
