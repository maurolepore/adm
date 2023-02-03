test_that("adds the expected foreign keys", {
  tmp <- local_tempdir()
  write_csv(tibble(x_id = 1, y_id = 2), path(tmp, "x.csv"))
  write_csv(tibble(y_id = 2), path(tmp, "y.csv"))

  dm <- adm(tmp)
  expect_s3_class(dm, "dm")
})
