context("testing testthat")

test_that("This is my test", {
  set.seed(1)
  invisible(capture.output(res <- hello(5)))
  expect_true( length(res) == 5)
  # expect_that(length(res), 4)
  expect_equal(res, c(-0.626453810742332, 0.183643324222082, -0.835628612410047,
                     1.59528080213779, 0.329507771815361))
  expect_error(hello("abc"), "invalid arguments")
})
