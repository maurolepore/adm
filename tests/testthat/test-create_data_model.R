test_that("names the tables using their corresponding .csv file", {
  tmp <- local_tempdir()
  write_csv(tibble(x = 1), fs::path(tmp, "a.csv"))
  write_csv(tibble(y = 2), fs::path(tmp, "b.csv"))
  write_csv(tibble(z = 3), fs::path(tmp, "c.csv"))

  dm <- create_data_model(dir_ls(tmp))
  expect_named(dm, c("a", "b", "c"))
})

test_that("creates a data model", {
  tmp <- local_tempdir()
  write_csv(tibble(x = 1), fs::path(tmp, "a.csv"))
  dm <- create_data_model(dir_ls(tmp))
  expect_s3_class(dm, "dm")
})
