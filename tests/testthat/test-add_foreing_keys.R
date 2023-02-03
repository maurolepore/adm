test_that("handles country_id and main_activity_id", {
  data_model <- dm::dm(
    companies = tibble(
      companies_id = 1,
      country_id = 1,
      main_activity_id = 1
    ),
    main_activity = tibble(
      main_activity_id = 1,
      main_activity = 1
    ),
    country = tibble(
      country_id = 1
    ),
  )

  fk <- data_model |>
    add_primary_keys() |>
    add_foreign_keys() |>
    expect_no_warning()

  expect_equal(nrow(dm::dm_get_all_fks(fk)), 2L)
})

test_that("adds the expected foreign keys", {
  data_model <- dm::dm(
    # `x` references `y`
    x = tibble(x_id = 1, y_id = 2),
    # `y` references nothing
    y = tibble(y_id = 2, blah = 3),
    # `z` references `x`
    # `z` references `y`
    z = tibble(z_id = 2, x_id = 1, y_id = 2)
  ) |>
    add_primary_keys()

  out <- add_foreign_keys(data_model)

  fk <- dm::dm_get_all_fks(out)
  fk |>
    filter(parent_table == "y") |>
    pull(child_table) |>
    # `x` references `y`
    # `z` references `y`
    expect_equal(c("x", "z"))
  fk |>
    filter(parent_table == "x") |>
    pull(child_table) |>
    # `z` references `x`
    expect_equal("z")
})

test_that("handles _id columns of missing tables", {
  # The `y` table is missing
  pk <- dm(x = tibble(x_id = 1, y_id = 1)) |>
    add_primary_keys()
  expect_warning(add_foreign_keys(pk), "no foreign key")
})
