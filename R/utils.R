#' @noRd
theme_apa <- function(x) {
  #if (require(ggplot2)) {
    #rlang::check_installed("ggplot2", reason = "for this function.")
    x +
    ggplot2::theme_bw(base_size = 24) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(hjust = 0.5),
      legend.position = "none",
      axis.text.x = ggplot2::element_text(colour = "black"),
      axis.text.y = ggplot2::element_text(colour = "black"),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      panel.border = ggplot2::element_blank(),
      axis.line = ggplot2::element_line(colour = "black"),
      axis.ticks = ggplot2::element_line(colour = "black")
    )
  }

#' @noRd
message_white <- function(...) {
  message("\033[97m", ..., "\033[97m")
}

#' @noRd
check_col_names <- function(data, names) {
  missing.cols <- lapply(names, function(x) {
    x %in% names(data)
    # grep(x, names(data), invert = F)
  })
  if(length(missing.cols) > 0) {
    id <- which(!unlist(missing.cols))
    if (isTRUE(length(id >= 1))) {
      missing.cols <- toString(names[id])
      stop(paste0("Variables not found: ", missing.cols, ". Please double check spelling."))
    }
  }
}
