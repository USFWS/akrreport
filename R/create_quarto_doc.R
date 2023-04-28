#' Create a new directory with the Quarto template
#'
#' \code{create_quarto_doc} creates a new subdirectory inside the current directory, which will
#' contain the ready-to-use Quarto file and all associated files. The Word and PDF templates are
#' based on the standard template of the Alaska Refuge Report Series.
#'
#' @param dirname character; the name of the directory to create.
#' @param template character; the template type to use. Choose "html" (default),
#'   "pdf_simple", "pdf_report", or "word".
#' @param font The font family of the document. Default is "Helvetica" (i.e. Helvetica Neue).
#'
#' @examples
#' \dontrun{
#'  # Create template for Word document
#'  create_quarto_doc(dirname = "my_word_report", template = "word_doc")
#'  # Create template for a PDF document
#'  create_quarto_doc(dirname = "my_pdf_report", template = "pdf_doc")
#' }
#' @export

create_quarto_doc <- function(dirname = "new_report", template = "word_doc") {

  templates <- c("pdf_doc", "word_doc")
  template <- match.arg(template, templates)
  tmp_dir <- paste(dirname, "_tmp", sep = "")
  if (file.exists(dirname) || file.exists(tmp_dir)) {
    stop(paste("Cannot run create_quarto_doc() from a directory containing already",
               dirname, "or", tmp_dir))
  }
  dir.create(tmp_dir)
  template_dir <- template

  # Get all file names in the template folder
  list_of_files <- list.files(
    system.file(file.path("quarto", "templates", template_dir, "skeleton"),
                package = "akrreport"))

  # Copy all files and subfolders in the skeleton folder into a new folder
  for (i in seq_along(list_of_files)) {
    file.copy(system.file(file.path("quarto", "templates", template_dir, "skeleton", list_of_files[i]),
                          package = "akrreport"), file.path(tmp_dir), recursive = TRUE)
  }
  
  # Copy selected resource file into new path
  if (template == "pdf_doc") {
    copy_font_files(template, font, type = "quarto", current_dir = tmp_dir)
  }
  
  if (template == "word_doc") {
    filename <- "akrreport-template.docx"
    file.copy(
      from = find_file("word_doc", file = filename, type = "quarto"),
      to = file.path(tmp_dir, "akrreport-template.docx")
    )
  }

  file.rename(tmp_dir, dirname)
  file.rename(file.path(dirname, "skeleton.qmd"), file.path(dirname, paste0(dirname, ".qmd")))
  unlink(tmp_dir, recursive = TRUE)

}