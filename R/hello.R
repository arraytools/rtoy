#' My hello world function
#'
#' @param n Number of random numbers
#'
#' @return A vector of length n
#' @export
#'
#' @examples
#' res <- hello(5)
#' \dontrun{
#' hello(10)
#' }
hello <- function(n=5) {
  print("Hello, world!")
  invisible(rnorm(n))
}
