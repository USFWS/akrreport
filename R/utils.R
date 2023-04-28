# find_file <- function(format, template) {
#   template <- system.file("rmarkdown", "templates", format,
#                           "resources", template, package = "akrreport")
#   if (template == "") {
#     stop("Couldn't find file.", call. = FALSE)
#   }
#   template
# }


find_file <- function(template, file, type = "rmarkdown") {
  types <- c("rmarkdown", "quarto")
  type <- match.arg(type, types)
  if (type == "rmarkdown") {
    res <- system.file(
      "rmarkdown", "templates", template, "resources", file, package = "akrreport"
    )
  }
  if (type == "quarto") {
    res <- system.file(
      "quarto", "templates", template, "resources", file, package = "akrreport"
    )
  }
  if (res == "") stop(
    "Couldn't find template file ", template, "/resources/", file, call. = FALSE
  )
  return(res)
}


# Helper function to copy font files under different name into working directory
copy_font_files <- function(template, font, type = "rmarkdown", current_dir = ".") {
  types <- c("rmarkdown", "quarto")
  type <- match.arg(type, types)
  file_copy <- function(template, font, input, output, type, current_dir) {
    file.copy(
      from = find_resource(template, file = file.path("fonts", font, input), type),
      to = file.path(current_dir, output), overwrite = TRUE
    )
  }
  if (font == "Helvetica") {
    file_copy(template, font, "HelNeueLight8.ttf", "font_regular.ttf", type, current_dir)
    file_copy(template, font, "HelNeueLightItalic9.ttf", "font_italic.ttf", type, current_dir)
    file_copy(template, font, "HelNeueBold2.ttf", "font_bold.ttf", type, current_dir)
    file_copy(template, font, "HelNeueBoldItalic4.ttf", "font_bolditalic.ttf", type, current_dir)
  }
  if (font == "TheSansUHH") {
    file_copy(template, font, "ftsr8a.ttf", "font_regular.ttf", type, current_dir)
    file_copy(template, font, "ftsri8a.ttf", "font_italic.ttf", type, current_dir)
    file_copy(template, font, "ftsb8a.ttf", "font_bold.ttf", type, current_dir)
    file_copy(template, font, "ftsbi8a.ttf", "font_bolditalic.ttf", type, current_dir)
  }
}


# Call bookdown::pdf_book and mark the return value as inheriting pdf_book
inherit_pdf_book <- function(...) {
  fmt <- bookdown::pdf_book(...)
  fmt$inherits <- "pdf_book"
  fmt
}



### R Markdown-specific functions

# Helper function to create a custom format derived from bookdown::pdf_book
# that includes a custom LaTeX template and custom CSL definition
rmd_pdf_book_format <- function(..., template, filename, csl) {
  # base format
  fmt <- bookdown::pdf_book(..., template = find_file(template = template,
                                                      file = filename,
                                                      type = "rmarkdown"))
  fmt$inherits <- "pdf_book"
  # add csl to pandoc_args
  fmt$pandoc$args <- c(fmt$pandoc$args,
                       "--csl",
                       rmarkdown::pandoc_path_arg(find_file(template, csl)))
  # return format
  fmt
}


# Helper function to create a custom format derived from bookdown::word_document2
# that includes a custom Word template
rmd_word_document_format <- function(format, filename, ...) {
  template <- find_file(format, file = filename)
  fmt <- officedown::rdocx_document(..., 
                                    base_format = "bookdown::word_document2",
                                    tables = list(caption = list(fp_text = officer::fp_text_lite(bold = FALSE))),
                                    plots = list(caption = list(style = "Image Caption",
                                                                fp_text = officer::fp_text_lite(bold = FALSE))),
                                    reference_docx = template,
                                    clean = TRUE)
  return(fmt)
}


