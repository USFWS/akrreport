#' Convert R Markdown to a PDF document
#'
#' Format for creating a FWS Alaska Refuge Report. 
#' This function serves as wrapper for \code{\link[bookdown]{pdf_book}}
#' @param ... Arguments to \code{bookdown::pdf_book}
#' @param keep_tex A boolean toggle to select whether intermediate
#' LaTeX files are to be kept, defaults to \code{FALSE}
#' @return output format to pass to \code{\link[bookdown:render_book]{render_book}}
#' @export
pdf_doc <- function(..., keep_tex = FALSE) {
  rmd_pdf_book_format(...,
                  keep_tex = keep_tex,
                  template = "project_report",
                  filename = "template.tex",
                  csl = "the-journal-of-wildlife-management.csl")
}