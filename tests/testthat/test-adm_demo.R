test_that("outputs the expected data model", {
  dm <- adm_demo()
  expect_s3_class(dm, "dm")
  expect_named(dm, c("a", "a_b", "b", "b_c", "c", "d", "e"))
  expect_equal(unname(dm::dm_nrow(dm)), rep(1, length(dm)))
})
