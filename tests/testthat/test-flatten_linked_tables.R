test_that("outputs the expected columns", {
  dm <- adm_demo() |> dm::dm_select_tbl(b, b_c, c, d)
  out <- flatten_linked_tables(dm)
  nms <- unique(unname(unlist(lapply(dm, names))))
  expect_equal(sort(names(out)), sort(nms))
})

test_that("outputs names in the order they apprear in the dm", {
  dm <- adm_demo() |> dm::dm_select_tbl(b, b_c, c, d)
  out <- flatten_linked_tables(dm)
  nms <- unique(unname(unlist(lapply(dm, names))))
  expect_named(out, nms)
})

test_that("outputs names in the order they apprear in the dm", {
  dm <- adm_demo()
  out <- flatten_linked_tables(dm)
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
