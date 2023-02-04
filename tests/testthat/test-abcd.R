test_that("outputs the expected data model", {
  dm <- abcd()
  expect_s3_class(dm, "dm")
  expect_named(dm, c("a", "a_b", "b", "b_c", "c", "d"))
  expect_equal(unname(dm::dm_nrow(dm)), rep(1, length(dm)))
})
