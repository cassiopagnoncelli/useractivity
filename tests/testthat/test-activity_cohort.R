test_that("cohort matrix generates a matrix", {
  data("user_activity")
  mat <- cohort_matrix(user_activity)
  expect_true(inherits(mat, "tbl_df"))
})
