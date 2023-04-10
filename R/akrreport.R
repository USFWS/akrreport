#' akrreport: R Markdown/Quarto templates designed for Refuge Reports in Alaska
#'
#' A package for creating PDF and Microsoft Word reports using R Markdown or Quarto.
#'
#' @section Quarto templates:
#' The following templates can be created using the function \code{\link{create_quarto_doc}}.
#' Simply set the \emph{template} argument to one of the following types:
#' \itemize{
#'   \item \emph{'html'}: Creates a simple HTML document with a
#'     fixed navigation bar on the left side.
#'   \item \emph{'word'}: Creates a simple MS Word document
#'   \item \emph{'pdf_simple'}: Creates a simple PDF/LaTeX document
#'   \item \emph{'pdf_report'}: Creates a report-like PDF/LaTeX document
#' }
#'
#'
#' @section R Markdown templates:
#' The following templates can be created using RStudio's IDE or by using the
#' function \code{\link{create_rmd_doc}}:
#' \itemize{
#'   \item \code{\link{word_doc}}: Creates a simple MS Word document
#'   \item \code{\link{pdf_report}}: Creates a report-like PDF/LaTeX document
#' }
#' @docType package
#' @name akrreport
NULL