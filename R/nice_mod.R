#' @title Easy moderations
#'
#' @description Easily compute moderation analyses, with effect
#' sizes, and format in publication-ready format.
#'
#' @inherit nice_lm details return
#'
#' @param data The data frame
#' @param response The dependent variable.
#' @param predictor The independent variable.
#' @param moderator The moderating variable.
#' @param moderator2 The second moderating variable, if applicable.
#' @param covariates The desired covariates in the model.
#' @param b.label What to rename the default "b" column (e.g.,
#' to capital B if using standardized data for it to be converted
#' to the Greek beta symbol in the `nice_table` function).
#' @param mod.id Logical. Whether to display the model number,
#' when there is more than one model.
#' @param ci.alternative Alternative for the confidence interval
#' of the sr2. It can be either "two.sided (the default in this
#' package), "greater", or "less".
#' @param ... Further arguments to be passed to the `lm`
#' function for the models.
#'
#' @keywords moderation interaction regression
#' @export
#' @examples
#' # Make the basic table
#' nice_mod(
#'   data = mtcars,
#'   response = "mpg",
#'   predictor = "gear",
#'   moderator = "wt"
#' )
#'
#' # Multiple dependent variables at once
#' nice_mod(
#'   data = mtcars,
#'   response = c("mpg", "disp", "hp"),
#'   predictor = "gear",
#'   moderator = "wt"
#' )
#'
#' # Add covariates
#' nice_mod(
#'   data = mtcars,
#'   response = "mpg",
#'   predictor = "gear",
#'   moderator = "wt",
#'   covariates = c("am", "vs")
#' )
#'
#' # Three-way interaction
#' nice_mod(
#'   data = mtcars,
#'   response = "mpg",
#'   predictor = "gear",
#'   moderator = "wt",
#'   moderator2 = "am"
#' )
#'
#' @seealso
#' Checking simple slopes after testing for moderation:
#' \code{\link{nice_slopes}}, \code{\link{nice_lm}},
#' \code{\link{nice_lm_slopes}}. Tutorial:
#' \url{https://rempsyc.remi-theriault.com/articles/moderation}
#'

nice_mod <- function(data,
                     response,
                     predictor,
                     moderator,
                     moderator2 = NULL,
                     covariates = NULL,
                     b.label = "b",
                     mod.id = TRUE,
                     ci.alternative = "two.sided",
                     ...) {
  check_col_names(data, c(predictor, response, moderator, moderator2, covariates))
  rlang::check_installed("effectsize", reason = "for this function.")
  if (!missing(covariates)) {
    covariates.term <- paste("+", covariates, collapse = " ")
  } else {
    covariates.term <- ""
  }
  if (!missing(moderator2)) {
    moderator2.term <- paste("*", moderator2, collapse = " ")
  } else {
    moderator2.term <- ""
  }
  formulas <- paste(
    response, "~", predictor, "*", moderator,
    moderator2.term, covariates.term
  )
  models.list <- lapply(formulas, stats::lm, data = data, ...)

  table.stats <- lapply(models.list, nice_lm, ci.alternative = ci.alternative)
  model.number.rows <- lapply(table.stats, nrow)
  table.stats <- dplyr::bind_rows(table.stats)

  if (length(models.list) > 1 && mod.id == TRUE) {
    model.number <- rep(seq_along(models.list), times = model.number.rows)
    table.stats <- stats::setNames(cbind(model.number, table.stats),
                            c("Model Number", names(table.stats)))
  }
  if (!missing(b.label)) {
    names(table.stats)[names(
      table.stats
    ) == "b"] <- b.label
  }
  table.stats
}
