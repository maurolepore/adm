test_that("outputs the expected columns", {
  dm <- abcd() |> dm::dm_select_tbl(b, b_c, c, d)
  out <- flatten_tables(dm)
  nms <- unique(unname(unlist(lapply(dm, names))))
  expect_equal(sort(names(out)), sort(nms))
})
