#' Create a new directory with an R Markdown report template
#'
#' \code{create_rmd_doc} creates a new subdirectory inside the current directory, 
#' which will contain the ready-to-use R Markdown file and associated files.
#'
#' @param dirname Name of the directory to create.
#' @param template The name of the template to use.The current option is "word_doc".
#' @details
#' The function is a modified version of the `create.doc` function in the
#' \href{https://github.com/juba/rmdformats}{rmdformats} package.
#'
#' @examples
#' \dontrun{
#' # Create template for a MS Word report document
#' create_rmd_doc("my_report", template = "word_doc")
#' }
#' @export
#'
create_rmd_doc <- function(dirname = "new-doc", 
                           template = "word_doc") {
  
  templates <- c("pdf_doc","word_doc")
  template <- match.arg(template, templates)
  
  tmp_dir <- paste(dirname, "_tmp", sep = "")
  if (file.exists(dirname) || file.exists(tmp_dir)) {
    stop(paste("Cannot run create_rmd_doc() from a directory containing already",
               dirname, "or", tmp_dir))
  }
  dir.create(tmp_dir)
  template_dir <- template

  # Get all file names in the skeleton folder
  list_of_files <- list.files(
    system.file(file.path("rmarkdown", "templates", template_dir, "skeleton"),
                package = "akrreport"))

  # Copy all files and subfolders from the skeleton folder into the new folder
  for (i in seq_along(list_of_files)) {
    file.copy(system.file(file.path("rmarkdown", "templates", template_dir, "skeleton", list_of_files[i]),
                          package = "akrreport"), file.path(tmp_dir), recursive = TRUE)
  }

  file.rename(tmp_dir, dirname)
  file.rename(file.path(dirname, "skeleton.Rmd"), file.path(dirname, paste0(dirname, ".Rmd")))
  unlink(tmp_dir, recursive = TRUE)
}
