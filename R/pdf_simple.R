#' Convert to simple PDF/LaTeX document
#'
#' This function serves as wrapper to \code{\link[rmarkdown]{pdf_document}}, with a
#' custom Pandoc \LaTeX template and different default values for other arguments
#' (e.g., \code{keep_tex = TRUE}). This function as well as its helper function are
#' based on the \href{https://github.com/rstudio/rticles}{rticles} package that
#' provides templates for various journal articles. The Pandoc \LaTeX template
#' and report layout are inspired by INWTlab's
#' \href{https://github.com/INWTlab/ireports}{ireports} package.
#'
#' @param number_sections logical; \code{TRUE} to number section headings.
#' @param highlight character; syntax highlighting style. Supported styles include "default",
#'        "tango", "pygments", "kate" (default here), "monochrome", "espresso", "zenburn", and "haddock".
#'        Pass \code{NULL} to prevent syntax highlighting.
#' @param font character; default font is "Helvetica"; for members of the UHH there is also the font
#'        "TheSansUHH" available. If you want to use another font, simply use the setting "other" and
#'        replace the .ttf files for regular, italic, bold, and bold-italic font with your own files
#'        (should be named EXACTLY as the template font files).
#' @param citation_package character; the \LaTeX package to process "citations", "natbib" (default) or
#'        "biblatex". Use "none" if neither package is to be used.
#' @param latex_engine character; LaTeX engine for producing PDF output. Options
#'        are "pdflatex", "lualatex", and "xelatex" (default).
#' @param ... Further arguments passed to \code{\link[rmarkdown]{pdf_document}}.
#'
#' @details
#' Possible arguments for the YAML header are:
#' \itemize{
#'   \item \code{title} Title of the manuscript.
#'   \item \code{subtitle} Subtitle of the manuscript.
#'   \item \code{author} Character of single or multiple author(s).
#'   \item \code{header_left} A running title as left header.
#'   \item \code{heder_right} A second right header (e.g. authors).
#'   \item \code{date} The date (automatically set).
#'   \item \code{fontsize} The font size for the body text (default is 11pt).
#'   \item \code{linkcolor}, \code{filecolor}, \code{citecolor}, \code{urlcolor}
#'              Colors for internal links (incl. ToC), external links, citation
#'              links, and linked URLs.
#'   \item \code{classoption} Options of the \code{article} class.
#'   \item \code{bibliography} Path to the bibliography file to use for references
#'              (BibTeX *.bib* file). This template uses the bibliography-related
#'              package \href{https://ctan.org/pkg/natbib}{natbib}. The current file
#'              includes 3 dummy references; either insert your references into
#'              this file or replace the file with your own.
#'   \item \code{bibliographystyle} The style is provided in the bibstyle.bst
#'              file, which adopts the
#'              \href{https://uk.sagepub.com/sites/default/files/sage_harvard_reference_style_0.pdf}{SAGE Harvard}
#'              reference style. Just leave the file as it is.
#'   \item \code{header-includes} Custom additions to the header, before the
#'              \code{\\begin\{document\}} statement.
#'   \item \code{include-after} For including additional LaTeX code before the
#'              \code{\\end\{document\}} statement.
#'  }
#'
#' @return R Markdown output format to pass to \code{\link[rmarkdown]{render}}
#' @export
#'
pdf_simple <- function(number_sections = TRUE, highlight = "kate",
                       font = "Helvetica", citation_package = "natbib", latex_engine = "xelatex", ...) {

  # Font setting
  if (!font %in% c("Helvetica", "other")) {
    stop('Set the font option to "Helvetica" or "other".')
  }
  if (font %in% c("Helvetica")) {
    copy_font_files("pdf_simple", font)
  }

  rmd_pdf_document_format(
    "pdf_simple",
    number_sections = number_sections,
    highlight = highlight,
    citation_package = citation_package,
    latex_engine = latex_engine,
    ...
  )

}