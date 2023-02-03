test_that("adds the expected primary keys", {
  data_model <- dm(
    x = tibble(x_id = 1, y_id = 2),
    y = tibble(y_id = 2)
  )

  out <- add_primary_keys(data_model)

  pk <- dm::dm_get_all_pks(out)
  expect_equal(nrow(pk), length(data_model))
  expect_equal(pk$table, c("x", "y"))
  expect_equal(unlist(pk$pk_col), c("x_id", "y_id"))
})
