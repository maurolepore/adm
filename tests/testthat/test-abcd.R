test_that("outputs the expected data model", {
  dm <- abcd()
  expect_s3_class(dm, "dm")
  expect_named(dm, c("a", "b", "a_b", "c", "b_c", "d"))
  expect_equal(unname(dm::dm_nrow(dm)), rep(1, length(dm)))
})
