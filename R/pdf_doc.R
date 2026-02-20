#' Render a PDF report using R Markdown
#'
#' This function serves as wrapper to \code{\link[rmarkdown]{pdf_document}}, with a
#' custom Pandoc \LaTeX template and different default values for other arguments
#' (e.g., \code{keep_tex = TRUE}) that match the template of the Alaska Refuge 
#' Report Series.
#'
#' @param ... Arguments to \code{bookdown::pdf_book}
#' @param keep_tex A boolean toggle to select whether intermediate
#' LaTeX files are to be kept, defaults to \code{FALSE}
#' @return output format to pass to \code{\link[bookdown:render_book]{render_book}}
#' @export
#' @param ... Further arguments passed to \code{\link[rmarkdown]{pdf_document}}.
#'
#' @details
#' Possible arguments for the YAML header are:
#' \itemize{
#'   \item \code{bibliography} Path to the bibliography file to use for references
#'              (BibTeX *.bib* file). This template uses the bibliography-related
#'              package \href{https://ctan.org/pkg/natbib}{natbib}. The current file
#'              includes 3 dummy references; either insert your references into
#'              this file or replace the file with your own.
#'   \item \code{header-includes} Custom additions to the header, before the
#'              \code{\\begin\{document\}} statement
#'   \item \code{include-after} For including additional LaTeX code before the
#'              \code{\\end\{document\}} statement
#'  }
#'
#' @return output format to pass to \code{\link[bookdown:render_book]{render_book}}
#' @export
#'
pdf_doc <- function(..., keep_tex = FALSE) {
  rmd_pdf_book_format(...,
                      keep_tex = keep_tex,
                      template = "project_report",
                      filename = "template.tex",
                      csl = "the-journal-of-wildlife-management.csl")
}