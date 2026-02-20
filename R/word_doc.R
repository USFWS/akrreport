#' Render a MS Word report using R Markdown
#'
#' This function serves as wrapper for \code{\link[bookdown]{word_document2}}, 
#' with a custom Pandoc Word template and knitr default values 
#' (e.g., \code{number_sections = FALSE}) that match the template of the Alaska 
#' Refuge Report Series.
#'
#' @param toc logical; \code{TRUE} to include a table of contents in the output.
#' @param toc_depth integer; Depth of headers to include in table of contents. Default set to 4.
#' @param number_sections logical; whether to number section headers: if TRUE, figure/table numbers
#'        will be of the form X.i, where X is the current first-level section number, and i is an
#'        incremental number (the i-th figure/table); if FALSE (default), figures/tables will be numbered
#'        sequentially in the document from 1, 2, ..., and you cannot cross-reference section
#'        headers in this case.
#' @param highlight character; syntax highlighting style. Supported styles include "default",
#'        "tango", "pygments", "kate", "monochrome", "espresso", "zenburn", and "haddock".
#'        Pass \code{NULL} to prevent syntax highlighting.
#' @param reference_docx character; use the specified file as a style reference in producing a docx file.
#'        The 'akrreport-template.docx' template implements the standard requirements for the Alaska
#'        Refuge Report Series. If you prefer another template, pass the file name to this argument or simply use
#'        'default' to use your standard Word template.
#' @param dpi integer; the resolution of the output figures, default is 144 dots per inch.
#' @param pandoc_args Additional command line options to pass to pandoc.
#' @param ... Additional parameters to pass to \code{\link[bookdown]{word_document2}}.
#'
#' @return A modified \code{\link[rmarkdown]{word_document}} based on a Word template.
#'
#' @import bookdown
#' @import knitr
#'
#' @export
#'
#' @examples
#' \dontrun{
#'  # put in YAML header:
#'  output: akrreport::word_doc
#' }
word_doc <- function(toc = FALSE, 
                     toc_depth = 4, 
                     number_sections = FALSE,
                     highlight = "default", 
                     reference_docx = "akrreport-template", 
                     dpi = 144, 
                     pandoc_args = NULL, 
                     ...) {
  
  filename <- "akrreport-template.docx"

  if (reference_docx == "akrreport-template") {
    base <- rmd_word_document_format(
      format = "word_doc",
      filename = filename,
      toc = toc,
      toc_depth = toc_depth,
      number_sections = number_sections,
      highlight = highlight,
      keep_md = FALSE,
      pandoc_args = c(pandoc_args, "--top-level-division=section"),
      ...
    )
  }
  else {
    base <- officedown::rdocx_document(
      base_format = "bookdown::word_document2",
      toc = toc,
      toc_depth = toc_depth,
      number_sections = number_sections,
      highlight = highlight,
      keep_md = FALSE,
      reference_docx = reference_docx,
      pandoc_args = c(pandoc_args, "--top-level-division=section"),
      ...
    )
  }

  # Set chunk options
  base$knitr$opts_chunk$comment <- NA
  base$knitr$opts_chunk$dpi <- dpi

  return(base)
}