#' Check if an argument is an environment
#'
#' @templateVar fn Environment
#' @template x
#' @param contains [\code{character}]\cr
#'  Vector of object names expected in the environment.
#'  Defaults to \code{character(0)}.
#' @template checker
#' @template null.ok
#' @family basetypes
#' @export
#' @examples
#' ee = as.environment(list(a = 1))
#' testEnvironment(ee)
#' testEnvironment(ee, contains = "a")
checkEnvironment = function(x, contains = character(0L), null.ok = FALSE) {
  qassert(contains, "S")
  if (identical(null.ok, TRUE) && is.null(x))
    return(TRUE)
  if (!is.environment(x))
    return("Must be an environment")
  if (length(contains) > 0L) {
    w = wf(contains %nin% ls(x, all.names = TRUE))
    if (length(w) > 0L)
      return(sprintf("Must contain an object with name '%s'", contains[w]))
  }
  return(TRUE)
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkEnvironment
assertEnvironment = makeAssertionFunction(checkEnvironment)

#' @export
#' @rdname checkEnvironment
assert_environment = assertEnvironment

#' @export
#' @include makeTest.r
#' @rdname checkEnvironment
testEnvironment = makeTestFunction(checkEnvironment)

#' @export
#' @rdname checkEnvironment
test_environment = testEnvironment

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkEnvironment
expect_environment = makeExpectationFunction(checkEnvironment)
